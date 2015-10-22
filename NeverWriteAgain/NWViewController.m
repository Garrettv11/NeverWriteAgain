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

NSString * const NWTableViewCellKey = @"NWTableViewCellKey";

@interface NWViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet

    UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation NWViewController {
    NSMutableArray * mLessonArray;
    NSMutableArray * mFilteredLessonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //make sure we initialize our lesson array
    mLessonArray = [[NSMutableArray alloc]init];
    //initialize our filtered array
    mFilteredLessonArray = [[NSMutableArray alloc]init];
    
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
    
    lessonName = @"Delegates and Delegate Methods";
    lessonDescription = @"Learn how to make a reusable view that can tell its delegate what's happening to it.";
    lessonViewControllerName = @"NWLetterColorViewController";
    lesson = [[NWLesson alloc]initWithLessonName:lessonName description:lessonDescription lessonViewControllerName:lessonViewControllerName];
    [mLessonArray addObject:lesson];
    
    lessonName = @"Move TextView With Keyboard";
    lessonDescription = @"Make sure that the textview you're editing doesn't get covered by the keyboard!";
    lessonViewControllerName = @"NWKeyboardMoveTextViewController";
    lesson = [[NWLesson alloc]initWithLessonName:lessonName description:lessonDescription lessonViewControllerName:lessonViewControllerName];
    [mLessonArray addObject:lesson];
    
    //we haven't filtered anything so we should just add all the lessons to our filtered lessons array
    [mFilteredLessonArray addObjectsFromArray:mLessonArray];
    [self.tableView reloadData];
    
    [self.searchBar setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [self setTitle:@"Lesson Menu"];
}

#pragma mark UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //
    [mFilteredLessonArray removeAllObjects];
    if (searchText == nil || searchText.length == 0) {
        [mFilteredLessonArray addObjectsFromArray:mLessonArray];
    } else {
        //getName is actually the method of lesson just like [lesson getName]
        NSString *queryString = [NSString stringWithFormat:@"getName contains[c] '%@'", searchText];
        //a predicate is like a query
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:queryString];
        [mFilteredLessonArray removeAllObjects];
        [mFilteredLessonArray addObjectsFromArray:[mLessonArray filteredArrayUsingPredicate:filterPredicate]];
    }
    
    //reload the data after filtering
    [self.tableView reloadData];
}


#pragma mark UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

//what happens if we select a cell
//answer: go to the lesson view controller
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //get the lesson at the index
    NWLesson * lessonForCell = [mFilteredLessonArray objectAtIndex:indexPath.row];

    //it should be noted that the viewControllerIdentifier is not the class name.
    //in interface builder you can specify an id for a view controller or view.
    //make a viewcontroller that matches the identifer given to it in storyboard
    NSString * viewControllerIdentifier = lessonForCell.getViewControllerName;
    UIViewController *viewControllerToNavigateTo = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:viewControllerIdentifier];
    //push the viewControllerToNavigateTo onto the navigation stack. This will allow us to go back to the main menu
    //later if we want to
    [viewControllerToNavigateTo setTitle:[lessonForCell getName]];
    [self.navigationController pushViewController:viewControllerToNavigateTo animated:YES];
}

#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //we only have one section for now
    //tell it that it has as many rows as we have lessons in the mLessonArray
    if (section == 0) {
        return mFilteredLessonArray.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NWLesson * lessonForCell = [mFilteredLessonArray objectAtIndex:indexPath.row];
    
    NWMenuTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:NWTableViewCellKey];
    if (cell == nil) {
        cell = [[NWMenuTableViewCell alloc]init];
    }
    [cell setLesson:lessonForCell];
    
    return cell;
}




@end
