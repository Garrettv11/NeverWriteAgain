//
//  NWTabOptionHeaderView.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/20/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWTabOptionHeaderView.h"

@interface NWTabOptionHeaderView (){
    //we linked a constraint from interface builder into the code here
    //we put it in the m file because we don't want other classes to know about it
    IBOutlet NSLayoutConstraint *leadingSliderViewConstraint;
    IBOutlet UIButton *optionAButton;
    IBOutlet UIButton *optionBButton;
    IBOutlet UIButton *optionCButton;
    IBOutlet UIView *sliderView;
}

@end

@implementation NWTabOptionHeaderView

- (id)init {
    self = [super init];
    
    if (self) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"NWTabOptionHeaderView" owner:self options:nil];
        self = [nib objectAtIndex:0];
    }
    
    return self;
}

//override the setTabMode function of our tabMode property to do a little extra
- (void)setTabMode:(NWTabOptionHeaderViewTabMode)mode {
    _tabMode = mode; //do it this way to prevent us from calling this function again
    CGFloat sliderViewOffset = 0;
    switch (self.tabMode) {
        case NWTabOptionHeaderViewTabModeA:
            sliderViewOffset = 0;
            break;
        case NWTabOptionHeaderViewTabModeB:
            sliderViewOffset = optionBButton.frame.origin.x;
            break;
        case NWTabOptionHeaderViewTabModeC:
            sliderViewOffset = optionCButton.frame.origin.x;
            break;
        default:
            break;
    }
    //animate for half a second
    [UIView animateWithDuration:0.5f animations:^{
        CGRect newSliderViewRect = sliderView.frame;
        newSliderViewRect.origin.x = sliderViewOffset;
        [sliderView setFrame:newSliderViewRect];
    } completion:^(BOOL finished) {
        [leadingSliderViewConstraint setConstant:sliderViewOffset];
    }];
    
    //if we have a delegate, tell it that we changed our tab mode
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tabOptionHeaderView:didSelectTabMode:)]) {
        [self.delegate tabOptionHeaderView:self didSelectTabMode:self.tabMode];
    }
}

- (IBAction)optionAPressed:(UIButton *)sender {
    //if someone is listening to us, tell them we switched our mode
    [self setTabMode:NWTabOptionHeaderViewTabModeA];
}

- (IBAction)optionBPressed:(id)sender {
    [self setTabMode: NWTabOptionHeaderViewTabModeB];
}

- (IBAction)optionCPressed:(id)sender {
    [self setTabMode:NWTabOptionHeaderViewTabModeC];
}



@end
