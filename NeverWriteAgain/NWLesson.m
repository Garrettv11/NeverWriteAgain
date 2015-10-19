//
//  Lesson.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWLesson.h"

@implementation NWLesson

- (id)initWithLessonName:(NSString *)name description:(NSString* )description lessonViewControllerName:(NSString *) viewControllerName {
    self = [super init];
    if (self != nil) {
        //if our basic constructor went okay, do custom setup
        mLessonName = name;
        mLessonDescription = description;
        mViewControllerName = viewControllerName;
    }
    return self;
}

- (NSString *)getName {
    return mLessonName;
}

- (NSString *)getDescription {
    return mLessonDescription;
}

- (NSString *)getViewControllerName {
    return mViewControllerName;
}


@end
