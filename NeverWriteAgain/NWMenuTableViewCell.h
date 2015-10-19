//
//  NWMenuTableViewCell.h
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWLesson.h"

@interface NWMenuTableViewCell : UITableViewCell
//declare our properties that are linked to interface builder vai NWMenuTableViewCell.xib

//The gray circles to the left of the properties are filled. That indicates that they are linked outlets to the interface builder file.
@property (strong, nonatomic) IBOutlet UILabel *lessonNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lessonDescriptionLabel;
@property (assign, nonatomic) NWLesson *lesson;

@end
