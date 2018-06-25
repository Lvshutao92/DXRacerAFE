//
//  MainNavigationViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "MainNavigationViewController.h"
@interface MainNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) UIViewController *currentShowVC;
@end

@implementation MainNavigationViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationController.navigationBar.barTintColor = RGBACOLOR(64, 64, 64, 1.0);
        self.navigationController.navigationBar.tintColor = RGBACOLOR(64, 64, 64, 1.0);
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
@end
