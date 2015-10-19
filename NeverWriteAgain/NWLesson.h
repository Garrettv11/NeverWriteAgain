//
//  Lesson.h
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NWLesson : NSObject {
    //out private variables
    NSString * mLessonName;
    NSString * mLessonDescription;
    NSString * mViewControllerName;
}

//our methods

- (id)initWithLessonName:(NSString *)name description:(NSString* )description lessonViewControllerName:(NSString *) viewControllerName;
- (NSString *)getName;
- (NSString *)getDescription;
- (NSString *)getViewControllerName;

@end
