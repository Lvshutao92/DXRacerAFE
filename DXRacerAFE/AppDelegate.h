//
//  AppDelegate.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/8/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "MainNavigationViewController.h"
#import "AFEMainTabbarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainNavigationViewController *mainNavigationController;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

@property (strong, nonatomic)AFEMainTabbarController *tabbarcontroller;
@end

//   layer.cornerRadius
//   layer.masksToBounds
