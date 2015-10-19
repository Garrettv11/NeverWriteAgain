//
//  ViewController.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWViewController.h"
#import "NWLesson.h"

@interface NWViewController ()

@end

@implementation NWViewController {
    NSMutableArray * mLessonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //make sure we initialize our lesson array
    mLessonArray = [[NSMutableArray alloc]init];
    
    //load up our examples
    NSString * lessonName;
    NSString * lessonDescription;
    NSString * lessonViewControllerName;
    
    NWLesson * lesson;
    
    
    lessonName = @"Move TextView With Keyboard";
    lessonDescription = @"Make sure that the textview you're editing doesn't get covered by the keyboard!";
    lessonViewControllerName = @"NWKeyboardMoveTextViewController";
    lesson = [[NWLesson alloc]initWithLessonName:lessonName description:@"Learn how to " lessonViewControllerName:lessonViewControllerName];
    [mLessonArray addObject:lesson];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
