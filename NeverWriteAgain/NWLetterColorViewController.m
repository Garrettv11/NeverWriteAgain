//
//  NWLetterColorViewController.m
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/20/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import "NWLetterColorViewController.h"
#import "NWTabOptionHeaderView.h"

@interface NWLetterColorViewController ()<NWTabOptionHeaderViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *letterColorView;
@property (strong, nonatomic) IBOutlet UILabel *currentModeLabel;
@property (strong, nonatomic) IBOutlet UIView *tabOptionHeaderPlaceHolderView;
@property (strong, nonatomic)  NWTabOptionHeaderView *tabOptionHeaderView;
@end

@implementation NWLetterColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabOptionHeaderView = [[NWTabOptionHeaderView alloc]init];
    [self.tabOptionHeaderView setFrame:CGRectMake(0, 0, self.tabOptionHeaderPlaceHolderView.frame.size.width, self.tabOptionHeaderPlaceHolderView.frame.size.height)];
    [self.tabOptionHeaderPlaceHolderView addSubview:self.tabOptionHeaderView];
    // Do any additional setup after loading the view from its nib.
    //set the delegate of our tabOptionHeader view!!
    [self.tabOptionHeaderView setDelegate:self];
    [self.tabOptionHeaderView setTabMode:NWTabOptionHeaderViewTabModeA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NWTabOptionHeaderViewDelegate methods
- (void)tabOptionHeaderView:(NWTabOptionHeaderView *)tabOptionHeaderView didSelectTabMode:(NWTabOptionHeaderViewTabMode)tabMode {
    //our header view told us that it changed modes - do something!
    switch (tabMode) {
        case NWTabOptionHeaderViewTabModeA:
            [self.letterColorView setBackgroundColor:[UIColor greenColor]];
            [self.currentModeLabel setTextColor:[UIColor blackColor]];
            [self.currentModeLabel setText:@"A"];
            break;
        case NWTabOptionHeaderViewTabModeB:
            [self.letterColorView setBackgroundColor:[UIColor redColor]];
            [self.currentModeLabel setTextColor:[UIColor whiteColor]];
            [self.currentModeLabel setText:@"B"];
            break;
        case NWTabOptionHeaderViewTabModeC:
            [self.letterColorView setBackgroundColor:[UIColor blueColor]];
            [self.currentModeLabel setTextColor:[UIColor whiteColor]];
            [self.currentModeLabel setText:@"C"];
            break;
        default:
            break;
    }
}


@end
