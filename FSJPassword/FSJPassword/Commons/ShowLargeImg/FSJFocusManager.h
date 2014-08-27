//
//  FSJFocusManager.h
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSJFocusController.h"
#import "FSJImageScrollView.h"

@class FSJFocusManager;
@protocol FSJFocusManagerDelegate <NSObject>

- (UIImage *)focusManager:(FSJFocusManager *)mediaFocusManager imageForView:(UIView *)view;

// 返回大图
- (UIImage *)focusManager:(FSJFocusManager *)mediaFocusManager mediaPathForView:(UIView *)view;


- (UIViewController *)parentViewControllerForMediaFocusManager:(FSJFocusManager *)mediaFocusManager;
@end

@interface FSJFocusManager : NSObject


@property (nonatomic,assign) id <FSJFocusManagerDelegate> delegate;
@property (nonatomic, strong) UIView *mediaView;
@property (nonatomic, strong) FSJFocusController *focusViewController;
// The animation duration. Defaults to 0.5.
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, strong) UIColor *backgroundColor;
// Returns whether zoom is enabled on fullscreen image. Defaults to YES.
@property (nonatomic, assign) BOOL zoomEnabled;

- (void)installOnViews:(NSArray *)views;

- (void)installOnView:(UIView *)view;

@end
