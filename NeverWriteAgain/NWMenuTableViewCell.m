//
//  NWMenuTableViewCell.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWMenuTableViewCell.h"


@implementation NWMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.lessonNameLabel setText:@""];
    [self.lessonDescriptionLabel setText:@""];
    //show the lesson text if our lesson has been set
    [self setLessonNameAndDescription];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//override the normal setLesson method
- (void)setLesson:(NWLesson *)lesson {
    _lesson = lesson;
    [self setLessonNameAndDescription];
}

- (void) setLessonNameAndDescription {
    if (self.lesson != nil) {
        [self.lessonNameLabel setText:[self.lesson getName]];
        [self.lessonDescriptionLabel setText:[self.lesson getDescription]];
    }
}



@end
