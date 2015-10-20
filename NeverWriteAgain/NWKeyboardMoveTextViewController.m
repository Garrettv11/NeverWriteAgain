//
//  NWKeyboardMoveTextView.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWKeyboardMoveTextViewController.h"

@interface NWKeyboardMoveTextViewController()<UITextFieldDelegate> {
    UITextField *lastTextViewSelected;
    CGPoint originalFrameCenter;
}
@property (strong, nonatomic) IBOutlet UIButton *clearTextFieldFocusButton;
@property (strong, nonatomic) IBOutlet UITextField *animatedTextField;
@property (strong, nonatomic) IBOutlet UITextField *instantMovementTextField;

@end

@implementation NWKeyboardMoveTextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //tell the textfields to tell us when something happens to them
    [self.animatedTextField setDelegate:self];
    [self.instantMovementTextField setDelegate:self];
}
- (void)viewWillAppear:(BOOL)animated {
    //we're visible so we should start listening for keyboard events!
    [self observeKeyboard];
}

//we need to make a note of the center of our view here because
//onload has the wrong center point because it adds the navigation bar space later!!!!
- (void)viewDidAppear:(BOOL)animated {
    originalFrameCenter = self.view.center;
}

- (void)viewWillDisappear:(BOOL)animated {
    //when this viewcontroller is not visible, stop listening for keyboard notifications.
    //we don't want to know if another view controller textview is being edited
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (IBAction)clearTextViewFocusButtonPressed:(id)sender {
    //we pressed the invisible button
    //drop that keyboard now!
    if (lastTextViewSelected != nil) {
        [lastTextViewSelected resignFirstResponder];
    }
}


#pragma mark Keyboard Methods

//when the keyboard goes up, the app sends us a notification telling us this happened
//the notification it sends has info on the keyboard like the size of the keyboard and how far/ how fast it will come up

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    NSValue *frameOfKeyboardAfterAnimation = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [frameOfKeyboardAfterAnimation CGRectValue];
    
    CGRect finalKeyboardFrame = [self.view convertRect:keyboardFrame fromView:self.view.window];
    
    CGFloat selectedTextFieldLowerBound = lastTextViewSelected.frame.origin.y + lastTextViewSelected.frame.size.height;
    
    CGFloat distanceToMoveView = selectedTextFieldLowerBound - finalKeyboardFrame.origin.y;
    CGPoint newViewCenter = self.view.center;
    newViewCenter.y = newViewCenter.y - distanceToMoveView;
    
    //if our textview is already higher than the keyboard, don't shift the view
    if(distanceToMoveView > 0){
        if (lastTextViewSelected == self.animatedTextField) {
            //animate the keyboard movement
            [UIView animateWithDuration:animationDuration animations:^{
                [self.view setCenter:newViewCenter];
            }];
        } else {
            //don't animate - just move it instantly - it might appear to animate anyway
            [self.view setCenter:newViewCenter];
        }
    }
}

// the keyboard tells us when it's going to go down and how fast it will go down

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (lastTextViewSelected == self.animatedTextField) {
        //animate the keyboard movement
        [UIView animateWithDuration:animationDuration animations:^{
            [self.view setCenter:originalFrameCenter];
        }];
    } else {
        //don't animate - just move it instantly
        [self.view setCenter:originalFrameCenter];
    }
}



//listen to the textfields when something happens to them

#pragma mark UITextFieldDelegate Methods

//we need to know which textview is being edited
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    lastTextViewSelected = textField;
}
@end
