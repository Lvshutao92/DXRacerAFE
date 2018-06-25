//
//  UserTableViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/12/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "UserTableViewController.h"
#import "WaiTableViewCell.h"

#import "LoginViewController.h"
#import "LeftSortsViewController.h"
#import "MainPageViewController.h"
#import "NSBundle+Language.h"
#import "AppDelegate.h"
@interface UserTableViewController ()
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *imgarr;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *imgarr1;

@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *imgarr2;
@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"y5", nil);
    
    self.arr = [@[NSLocalizedString(@"y6", nil)]mutableCopy];
    self.imgarr = [@[@"修改密码"]mutableCopy];
    
    
    self.arr1 = [@[NSLocalizedString(@"xxx", nil)]mutableCopy];
    self.imgarr1 = [@[@"语言切换"]mutableCopy];
    
    self.arr2 = [@[NSLocalizedString(@"y8", nil)]mutableCopy];
    self.imgarr2 = [@[@"退出登录"]mutableCopy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    self.tableView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
    view.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr.count;
    }
    if (section == 1) {
        return self.arr1.count;
    }
    return self.arr2.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.lab.text = self.arr[indexPath.row];
        cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr[indexPath.row]]];
        return cell;
    }
    if (indexPath.section == 1) {
        cell.lab.text = self.arr1[indexPath.row];
        cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr1[indexPath.row]]];
        return cell;
    }
    cell.lab.text = self.arr2[indexPath.row];
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr2[indexPath.row]]];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaiTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lab.text isEqualToString:NSLocalizedString(@"y6", nil)]) {
        
        YBAlertView *alertView = [[YBAlertView alloc] initWithFrame:CGRectMake(50, 130, kScreenW-100, 250)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = NSLocalizedString(@"y6", nil);
        titleLabel.font = [UIFont systemFontOfSize:20];
        [alertView addSubview:titleLabel];
        
        
        
        
        UITextField *passwordTF0 = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 20, alertView.width-32, 40)];
        passwordTF0.tag = 99;
        passwordTF0.borderStyle = UITextBorderStyleRoundedRect;
        passwordTF0.layer.borderWidth = 1;
        passwordTF0.placeholder = NSLocalizedString(@"m1", nil);
        passwordTF0.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
        passwordTF0.layer.cornerRadius = 5;
        [alertView addSubview:passwordTF0];
        
        
        UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 70, alertView.width-32, 40)];
        passwordTF.tag = 100;
        passwordTF.borderStyle = UITextBorderStyleRoundedRect;
        passwordTF.layer.borderWidth = 1;
        passwordTF.placeholder = NSLocalizedString(@"m2", nil);
        passwordTF.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
        passwordTF.layer.cornerRadius = 5;
        [alertView addSubview:passwordTF];
        
        
        UITextField *passwordTF1 = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 120, alertView.width-32, 40)];
        passwordTF1.tag = 101;
        passwordTF1.borderStyle = UITextBorderStyleRoundedRect;
        passwordTF1.layer.borderWidth = 1;
        passwordTF1.placeholder = NSLocalizedString(@"m3", nil);
        passwordTF1.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
        passwordTF1.layer.cornerRadius = 5;
        [alertView addSubview:passwordTF1];
        
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 170, passwordTF.width/2, 40);
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:NSLocalizedString(@"n", ninl) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [alertView addSubview:cancelBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(titleLabel.frame) + 170, passwordTF.width/2, 40);
        [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitle:NSLocalizedString(@"sure", nil) forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [alertView addSubview:confirmBtn];
        
        [alertView show];
    }
    
    
    
    if ([cell.lab.text isEqualToString:NSLocalizedString(@"xxx", nil)]){
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
            [self changeLanguageTo:@"zh-Hans"];
        }else{
            [self changeLanguageTo:@"en"];
        }
    }
    
    
    
    
    
    
    if ([cell.lab.text isEqualToString:NSLocalizedString(@"y8", nil)]) {
        LoginViewController *login = [[LoginViewController alloc]init];
        login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:login animated:YES completion:nil];
    }
}

- (void)changeLanguageTo:(NSString *)language {
    // 设置语言
    [NSBundle setLanguage:language];
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"myLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AFEMainTabbarController *mainVC = [[AFEMainTabbarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
    [[UIApplication sharedApplication].keyWindow makeKeyWindow];
}










- (void)cancelClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
}
-  (void)confirmClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
    UITextField *TextField1 = [btn.superview viewWithTag:99];
    UITextField *TextField2 = [btn.superview viewWithTag:100];
    UITextField *TextField3 = [btn.superview viewWithTag:101];
    
    
    
    if ([TextField1.text isEqualToString:[Manager redingwenjianming:@"password.text"]]) {
        if ([TextField2.text isEqualToString:TextField3.text] && ![TextField1.text isEqualToString:TextField2.text]) {
            [self lodChangePassword:TextField1.text str2:TextField2.text str3:TextField3.text];
        }else{
            if ([TextField1.text isEqualToString:TextField2.text]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x26", nil) message:NSLocalizedString(@"x9", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            if (![TextField3.text isEqualToString:TextField2.text]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x27", nil) message:NSLocalizedString(@"x9", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x28", nil) message:NSLocalizedString(@"x9", nil) preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}






- (void)lodChangePassword:(NSString *)str1 str2:(NSString *)str2 str3:(NSString *)str3{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"userId":[Manager redingwenjianming:@"loginId.text"],
            
            @"oldPassword":str1,
            @"newPassword":str2,
            @"confirmPassword":str3,
            };
    //    NSLog(@"+++%@",dic);
    [session POST:KURLNSString(@"user",@"updatePassword") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        /NSLog(@"----%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"x24", nil) preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [Manager writewenjianming:@"password.text" content:str2];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"x25", nil) preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
































- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)imgarr{
    if (_imgarr == nil) {
        self.imgarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr;
}

- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)imgarr1{
    if (_imgarr1 == nil) {
        self.imgarr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr1;
}
- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)imgarr2{
    if (_imgarr2 == nil) {
        self.imgarr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr2;
}
@end
