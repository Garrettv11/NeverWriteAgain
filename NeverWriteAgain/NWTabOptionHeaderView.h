//
//  NWTabOptionHeaderView.h
//  NeverWriteAgain
//
//  Created by Garrett Kim on 10/20/15.
//  Copyright © 2015 GKIM. All rights reserved.
//

#import <UIKit/UIKit.h>

//declare an enum that represents the tab modes we can be in

typedef enum  {
    NWTabOptionHeaderViewTabModeA,
    NWTabOptionHeaderViewTabModeB,
    NWTabOptionHeaderViewTabModeC,
} NWTabOptionHeaderViewTabMode;

//declare a delegate (interface) that knows how to listen for NWTabOptionHeaderView events!
//we are going to forward declare the NWTabOptionHeaderViewDelegate without really saying what methods it provides because we need to use this class in the NWTabOptionHeaderView interface declaration :P
@protocol  NWTabOptionHeaderViewDelegate;

@interface NWTabOptionHeaderView : UIView {

}

//this NWTabOptionHeaderView will keep track of a delegate or a class to tell about events happening to it. It should implement the NWTabOptionHeaderViewDelegate interface and should be able to handle the methods declared at the bottom of this header
@property (assign, nonatomic) id<NWTabOptionHeaderViewDelegate> delegate;
@property (assign, nonatomic) NWTabOptionHeaderViewTabMode tabMode;
//public methods for this class
- (void)setTabMode:(NWTabOptionHeaderViewTabMode)mode;
@end
//declare the actual fully fleshed out protocol for the delegate
@protocol  NWTabOptionHeaderViewDelegate <NSObject>
//say that these methods are optional for any class that uses the NWTabOptionHeaderViewDelegate interface
@optional
- (void) tabOptionHeaderView:(NWTabOptionHeaderView *)tabOptionHeaderView didSelectTabMode:(NWTabOptionHeaderViewTabMode)tabMode;

@end