//
//  AppDelegate.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/8/29.
//  Copyright © 2017年 .ilovedxracer All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "LeftSortsViewController.h"

// 引入JPush功能所需头文件
#import <JPush/JPUSHService.h>
#import <AdSupport/ASIdentifierManager.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString * const jpushAppKey = @"135e4879c9b416e39cdde41e";
static NSString * const channel = @"722954c86efc8e761296d6dd";
static BOOL isProduction = true;

@interface AppDelegate ()<JPUSHRegisterDelegate>
@property(nonatomic, strong)LoginViewController *login;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    
    //    else {
    //        //categories 必须为nil
    //        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
    //                                                          UIRemoteNotificationTypeSound |
    //                                                          UIRemoteNotificationTypeAlert)
    //                                              categories:nil];
    //    }
    // 获取IDFA  IDFA(广告标识符)-identifierForldentifier
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值   advertisingIdentifier:advertisingId
    //NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:jpushAppKey
                          channel:channel
                 apsForProduction:isProduction
     ];
    __weak typeof(self) weakSelf = self;
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSSet *set1 = [[NSSet alloc] initWithObjects:registrationID,nil];
        [JPUSHService setTags:set1 alias:[Manager redingwenjianming:@"loginId.text"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:weakSelf];
        //NSLog(@"--%@",registrationID);
    }];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.login = [[LoginViewController alloc]init];
    self.window.rootViewController = self.login;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self.window makeKeyWindow];
   
    [[UINavigationBar appearance]setTintColor:[UIColor blackColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickHiddenlogin:) name:@"hiddenlogin" object:nil];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    return YES;
}
- (void)clickHiddenlogin:(NSNotification *)text {
    
//    self.window.backgroundColor = [UIColor whiteColor];
//    MainPageViewController *mainVC = [[MainPageViewController alloc] init];
//    self.mainNavigationController = [[MainNavigationViewController alloc]initWithRootViewController:mainVC];
//    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
//    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
//    self.window.rootViewController = self.LeftSlideVC;
//    [self.window makeKeyWindow];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabbarcontroller = [[AFEMainTabbarController alloc] init];
    self.window.rootViewController = self.tabbarcontroller;
    [self.window makeKeyWindow];
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    //默认全局不支持横屏
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    double delayInSeconds = 1800.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //进入后台30分后杀掉该进程
        exit(0);
    });
}





- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    NSLog(@"userInfo====%@",userInfo);
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    
    
    
    AFEMainTabbarController *tabBarController = (AFEMainTabbarController *)self.window.rootViewController;
    MainNavigationViewController *nav = (MainNavigationViewController *)tabBarController.selectedViewController;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:content message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [nav presentViewController:alert animated:YES completion:nil];
    
    
    //    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得Extras字段内容
    //    NSString *customizeField1 = [userInfo valueForKey:@"extras"]; //服务端中Extras字段，key是自己定义的
    //    NSLog(@"%@=======%ld----%@----%@",content,badge,customizeField1,sound);
    
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
//        // 取到tabbarcontroller
//        MainTabbarViewController *tabBarController = (MainTabbarViewController *)self.window.rootViewController;
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:content message:@"温馨提示，消息提醒！" preferredStyle:1];
//        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            // 取到tabbarcontroller
//            UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//            // 取到navigationcontroller
//            UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
//            //跳转到我的消息
//            TopUpViewController *vc = [[TopUpViewController alloc] initWithAddVCARY:@[[TopUpCenterOneViewController new],[TopUpTwoViewController new],[TopUpCenterThreeViewController new],[TopUpCenterFourViewController new]] TitleS:@[@"充值审核",@"充值记录",@"消费流水",@"收款账户"]];
//            [nav pushViewController:vc animated:YES];
//        }];
//        UIAlertAction *ca = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alert addAction:ca];
//        [alert addAction:sure];
//        [tabBarController presentViewController:alert animated:YES completion:nil];
//    }else {
//        
//        
//    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [JPUSHService setBadge:0];
}








- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    NSLog(@"----%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    
    //    NSLog(@"url---%@",url);
    return YES;
    
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    
}
//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    //    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//添加处理APNs通知回调方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    //    NSLog(@"---rescode: %d, \n---tags: %@, \n---alias: %@\n", iResCode, tags , alias);
}













@end
