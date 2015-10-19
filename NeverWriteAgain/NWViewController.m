//
//  ViewController.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/18/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWViewController.h"
#import "NWLesson.h"
#import "NWMenuTableViewCell.h"

const NSString * NWTableViewCellKey = @"NWTableViewCellKey";

@interface NWViewController ()

@end

@implementation NWViewController {
    NSMutableArray * mLessonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //make sure we initialize our lesson array
    mLessonArray = [[NSMutableArray alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"NWMenuTableViewCell" bundle:nil] forCellReuseIdentifier:NWTableViewCellKey];
    
    //make sure that we are our own data and interaction delegate
    //make sure the table view tells this view controller when things happen
    [self.tableView setDelegate:self];
    //make sure we tell our tableview what data to show and how to show it
    [self.tableView setDataSource:self];
    
    //load up our examples
    NSString * lessonName;
    NSString * lessonDescription;
    NSString * lessonViewControllerName;
    
    NWLesson * lesson;
    
    lessonName = @"Move TextView With Keyboard";
    lessonDescription = @"Make sure that the textview you're editing doesn't get covered by the keyboard!";
    lessonViewControllerName = @"NWKeyboardMoveTextViewController";
    lesson = [[NWLesson alloc]initWithLessonName:lessonName description:lessonDescription lessonViewControllerName:lessonViewControllerName];
    [mLessonArray addObject:lesson];
    [self.tableView reloadData];
    
}



#pragma mark UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}


#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //we only have one section for now
    //tell it that it has as many rows as we have lessons in the mLessonArray
    if (section == 0) {
        return mLessonArray.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NWLesson * lessonForCell = [mLessonArray objectAtIndex:indexPath.row];
    
    NWMenuTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:NWTableViewCellKey];
    if (cell == nil) {
        cell = [[NWMenuTableViewCell alloc]init];
    }
    [cell setLesson:lessonForCell];
    
    return cell;
}




@end
