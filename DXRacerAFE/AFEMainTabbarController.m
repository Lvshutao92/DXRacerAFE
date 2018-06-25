//
//  AFEMainTabbarController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "AFEMainTabbarController.h"
#import "AFEMainViewController.h"
#import "MainPageViewController.h"
#import "Tabbar_Two_ViewController.h"
@interface AFEMainTabbarController ()

@end

@implementation AFEMainTabbarController
- (instancetype)init {
    if (self = [super init]) {
        AFEMainViewController *oneVc = [[AFEMainViewController alloc]init];
        MainNavigationViewController *mainoneVC = [[MainNavigationViewController alloc]initWithRootViewController:oneVc];
        mainoneVC.title = NSLocalizedString(@"vc1Title", nil);
        oneVc.navigationItem.title = NSLocalizedString(@"y1", nil);
        mainoneVC.tabBarItem.image = [UIImage imageNamed:@"tabbar1"];
        mainoneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar01"];
        
        
        
        Tabbar_Two_ViewController *twoVc = [[Tabbar_Two_ViewController alloc]init];
        MainNavigationViewController *maintwoVC = [[MainNavigationViewController alloc]initWithRootViewController:twoVc];
        twoVc.title = NSLocalizedString(@"vc2Title", nil);
        maintwoVC.tabBarItem.image = [UIImage imageNamed:@"tabbar2"];
        maintwoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar02"];
        
        
        
        
        MainPageViewController *threeVc = [[MainPageViewController alloc]init];
        MainNavigationViewController *mainthreeVC = [[MainNavigationViewController alloc]initWithRootViewController:threeVc];
        threeVc.title = NSLocalizedString(@"vc3Title", nil);
        mainthreeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar4"];
        mainthreeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar04"];
        
        self.tabBar.tintColor = RGBACOLOR(64, 64, 64, 1.0);
        self.viewControllers = @[mainoneVC,mainthreeVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
