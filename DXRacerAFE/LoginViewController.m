//
//  LoginViewController.m
//  DXRacer
//
//  Created by ilovedxracer on 2017/6/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LoginViewController.h"
#import "rolemodel.h"
#import "Allresourcemodel.h"
#import "NSBundle+Language.h"

@interface LoginViewController ()<UITextFieldDelegate,PGGDropDelegate>
{
    NSString *appstore_verson;
    NSString *appstore_newverson;
}
@property(nonatomic, strong)UITextField *textfield;
@property(strong,nonatomic)PGGDropView * dropView;
@end

@implementation LoginViewController


- (void)vie1{
    _numberTextfield.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login1"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _numberTextfield.leftView = lv;
}
- (void)vie2{
    _usernameTextfield.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login2"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _usernameTextfield.leftView = lv;
}
- (void)vie3{
    _passwordTextfield.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login3"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _passwordTextfield.leftView = lv;
}



- (void)viewDidLoad {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"myLanguage"] == nil) {
        //获取当前设备语言
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *languageName = [appLanguages objectAtIndex:0];
        if ([languageName isEqualToString:@"zh-Hans-CN"]) {
            languageName = @"zh-Hans";
        }else {
            languageName = @"en";
        }
        [[NSUserDefaults standardUserDefaults] setObject:languageName forKey:@"myLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [NSBundle setLanguage:languageName];
    }else{
        [NSBundle setLanguage:[ud objectForKey:@"myLanguage"]];
    }
    
    
    [super viewDidLoad];
    self.lab.hidden = YES;
    self.wangjimimabtn.hidden = YES;
    [self setupshuxingdaila];
    
    LRViewBorderRadius(self.img, 10, 1, [UIColor colorWithWhite:.85 alpha:.3]);
    
    [self vie1];
    [self vie2];
    [self vie3];
    
    self.namelab.text = NSLocalizedString(@"f7", nil);
    [self.yuyanbtn setTitle:NSLocalizedString(@"f13", nil) forState:UIControlStateNormal];
    self.numberTextfield.placeholder   = NSLocalizedString(@"x1", nil);
    self.usernameTextfield.placeholder = NSLocalizedString(@"x2", nil);
    self.passwordTextfield.placeholder = NSLocalizedString(@"x3", nil);
    [self.btn setTitle:NSLocalizedString(@"x4", nil) forState:UIControlStateNormal];
    
    [self.yuyanbtn setTitle:NSLocalizedString(@"x5", nil) forState:UIControlStateNormal];
    [self.wangjimimabtn setTitle:NSLocalizedString(@"x6", nil) forState:UIControlStateNormal];
    
    self.numberTextfield.text   = [Manager redingwenjianming:@"bianhao.text"];
    self.usernameTextfield.text = [Manager redingwenjianming:@"user.text"];
    self.passwordTextfield.text = [Manager redingwenjianming:@"password.text"];
    
    //self.btn.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
  
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    
    self.lab.textColor =  RGBACOLOR(32, 157, 149, 1.0);
    NSMutableAttributedString *notestr = [[NSMutableAttributedString alloc]initWithString:@"登录即代表已阅读并同意服务条款"];
    NSRange ran = NSMakeRange(0,11);
    [notestr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:ran];
    [self.lab setAttributedText:notestr];
 
    
    [self lodverson];
    
}


- (void)lodverson{
    NSString *dom= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *tex= [dom stringByAppendingPathComponent:@"newversion.text"];
    //取出存入的上次版本号版本号
    appstore_verson = [NSString stringWithContentsOfFile:tex encoding:NSUTF8StringEncoding error:nil];
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *session = [Manager returnsession];
    [session POST:@"https://itunes.apple.com/lookup?id=1306606424" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [dic objectForKey:@"results"];
        NSDictionary *dict = [arr lastObject];
        //app store版本号
        appstore_newverson = dict[@"version"];
        
        //写入版本号
        NSString *doucments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *text= [doucments stringByAppendingPathComponent:@"newversion.text"];
        [appstore_newverson writeToFile:text atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        //NSLog(@"appstore版本：%@----存入的版本号：%@",appstore_newverson,appstore_verson);
        
        if (![appstore_verson isEqualToString:appstore_newverson] && appstore_verson != nil){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"f12", nil) message:NSLocalizedString(@"x9", nil) preferredStyle:1];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"f14", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:NSLocalizedString(@"f15", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id1306606424?mt=8"]];
            }];
            [alert addAction:cancel];
            [alert addAction:sure];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)setupshuxingdaila {
    self.numberTextfield.delegate = self;
    self.numberTextfield.borderStyle = UITextBorderStyleNone;
    self.numberTextfield.keyboardType = UIKeyboardTypePhonePad;
    self.numberTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.usernameTextfield.delegate = self;
    self.usernameTextfield.borderStyle = UITextBorderStyleNone;
    self.usernameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordTextfield.delegate = self;
    self.passwordTextfield.borderStyle = UITextBorderStyleNone;
    self.passwordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextfield.secureTextEntry = YES;
    self.passwordTextfield.keyboardType = UIKeyboardTypeASCIICapable;
    self.textfield.delegate = self;
}
- (IBAction)clickButton:(id)sender {
    
//
    
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.numberTextfield resignFirstResponder];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"未知网络");
                [self lodlogin];
                break;
            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"没有网络(断网)");
                [self noNetWorking];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"手机自带网络");
                [self lodlogin];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"WIFI");
                [self lodlogin];
                break;
        }
    }];
    [manager startMonitoring];
}


- (void)noNetWorking{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x21", nil) message:NSLocalizedString(@"x9", nil) preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}





- (void)lodlogin {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"jh", @"HUD loading title");
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (self.numberTextfield.text != nil && self.usernameTextfield.text && self.passwordTextfield.text) {
        dic = @{@"businessId":self.numberTextfield.text,
                @"username":self.usernameTextfield.text,
                @"password":self.passwordTextfield.text,
                @"ipAddress":[[Manager sharedManager] getIPAddress:YES],
                };
//        NSLog(@"++%@",dic);
        [session POST:KURLNSString(@"user", @"login") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"++%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]){
                
                NSDictionary *diction = [[dic objectForKey:@"rows"] objectForKey:@"systemUser"];
                
                NSString *str;
                if ([[[dic objectForKey:@"rows"] objectForKey:@"dealerUser"] isEqual:[NSNull null]]) {
                    [Manager writewenjianming:@"dealerId.text" content:@""];
                }else{
                    str = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"] objectForKey:@"dealerUser"] objectForKey:@"dealerId"]];
                    [Manager writewenjianming:@"dealerId.text" content:str];
                }
                
                
                
                if ([[[dic objectForKey:@"rows"] objectForKey:@"dealerType"] isEqual:[NSNull null]] || [[dic objectForKey:@"rows"] objectForKey:@"dealerType"] == nil) {
                    [Manager writewenjianming:@"dealerType.text" content:@""];
                }else{
                    [Manager writewenjianming:@"dealerType.text" content:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"rows"] objectForKey:@"dealerType"]]];
                }
                
                
                [Manager writewenjianming:@"loginId.text" content:[NSString stringWithFormat:@"%@",[diction objectForKey:@"id"]]];
                [Manager writewenjianming:@"businessId.text" content:[diction objectForKey:@"businessId"]];
                
                
                [Manager writewenjianming:@"userName.text" content:[diction objectForKey:@"username"]];
                [Manager writewenjianming:@"companyName.text" content:[[[dic objectForKey:@"rows"] objectForKey:@"dealerInfo"]objectForKey:@"companyName"]];
                
                
                [Manager writewenjianming:@"bianhao.text" content:weakSelf.numberTextfield.text];
                [Manager writewenjianming:@"password.text" content:weakSelf.passwordTextfield.text];
                [Manager writewenjianming:@"user.text" content:self.usernameTextfield.text];
                
                
                
                
                NSDictionary *dictrole = [[dic objectForKey:@"rows"] objectForKey:@"systemUserRole"];
                [Manager writewenjianming:@"roleid.text" content:[NSString stringWithFormat:@"%@",[dictrole objectForKey:@"roleId"]]];

//                [self loddddd];
                
               
                [weakSelf lod:[dictrole objectForKey:@"roleId"]];
                
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"x22", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error = %@",error);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x22", nil) message:NSLocalizedString(@"x9", nil) preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            [hud hideAnimated:YES];
        }];
    }

    
}


- (void)lod:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    //__weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"pId":@"",
            @"roleId":str,
            };
    [session POST:KURLNSString2(@"servlet", @"system", @"systemrole", @"getAppResourceByRPId") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];

        [[Manager sharedManager].yijiarr removeAllObjects];
        [[Manager sharedManager].yijiimgarr removeAllObjects];
        [Manager sharedManager].piliangID = nil;
        [Manager sharedManager].xianhuoID = nil;
        [Manager sharedManager].shouhouID = nil;
        
        for (NSDictionary *dic in arr) {
            rolemodel *model = [rolemodel mj_objectWithKeyValues:dic];
            
//
            
//            if ([model.id isEqualToString:@"13"]) {
//               [[Manager sharedManager].yijiarr addObject:@"首页"];
//               [[Manager sharedManager].yijiimgarr addObject:@"00"];
//            }
//            else if ([model.id isEqualToString:@"14"]) {
//                [[Manager sharedManager].yijiarr addObject:@"经销商管理"];
//                [[Manager sharedManager].yijiimgarr addObject:@"01"];
//            }
//            
//            else if ([model.id isEqualToString:@"78"]) {
//                [[Manager sharedManager].yijiarr addObject:@"我的信息"];
//                [[Manager sharedManager].yijiimgarr addObject:@"07"];
//            }
//            else if ([model.id isEqualToString:@"26"]) {
//                [[Manager sharedManager].yijiarr addObject:@"产品浏览"];
//                [[Manager sharedManager].yijiimgarr addObject:@"02"];
//            }
            
            
            if ([model.id isEqualToString:@"39"]) {
                [[Manager sharedManager].yijiarr addObject:@"批量订单"];
                [[Manager sharedManager].yijiimgarr addObject:@"pldd"];
                [Manager sharedManager].piliangID = @"39";
            }
            else if ([model.id isEqualToString:@"47"]) {
                [[Manager sharedManager].yijiarr addObject:@"现货订单"];
                [[Manager sharedManager].yijiimgarr addObject:@"xhdd"];
                [Manager sharedManager].xianhuoID = @"47";
            }
            
            
            else if ([model.id isEqualToString:@"29"]) {
                [[Manager sharedManager].yijiarr addObject:@"批量订单"];
                [[Manager sharedManager].yijiimgarr addObject:@"pldd"];
                [Manager sharedManager].piliangID = @"29";
                
            }
            else if ([model.id isEqualToString:@"34"]) {
                [[Manager sharedManager].yijiarr addObject:@"现货订单"];
                [[Manager sharedManager].yijiimgarr addObject:@"xhdd"];
                [Manager sharedManager].xianhuoID = @"34";
            }
            
            
            else if ([model.id isEqualToString:@"445"]) {
                [[Manager sharedManager].yijiarr addObject:@"售后订单"];
                [[Manager sharedManager].yijiimgarr addObject:@"shdd"];
                [Manager sharedManager].shouhouID = @"445";
            }
            else if ([model.id isEqualToString:@"438"]) {
                [[Manager sharedManager].yijiarr addObject:@"售后订单"];
                [[Manager sharedManager].yijiimgarr addObject:@"shdd"];
                [Manager sharedManager].shouhouID = @"438";
            }
            
            
            
            
            
            
            
//            else if ([model.id isEqualToString:@"54"]) {
//                [[Manager sharedManager].yijiarr addObject:@"付款管理"];
//                [[Manager sharedManager].yijiimgarr addObject:@"11"];
//            }
//            else if ([model.id isEqualToString:@"59"]) {
//                [[Manager sharedManager].yijiarr addObject:@"收款管理"];
//                [[Manager sharedManager].yijiimgarr addObject:@"05"];
//            }
//
//            else if ([model.id isEqualToString:@"63"]) {
//                [[Manager sharedManager].yijiarr addObject:@"基础配置"];
//                [[Manager sharedManager].yijiimgarr addObject:@"06"];
//            }
            
            
//            else if ([model.id isEqualToString:@"89"]) {
//                [[Manager sharedManager].yijiarr addObject:@"资源中心"];
//                [[Manager sharedManager].yijiimgarr addObject:@"08"];
//            }
//            
//            else if ([model.id isEqualToString:@"94"]) {
//                [[Manager sharedManager].yijiarr addObject:@"迪锐克斯"];
//                [[Manager sharedManager].yijiimgarr addObject:@"10"];
//            }
            
            
            
//            else if ([model.id isEqualToString:@"491"]) {
//                [[Manager sharedManager].yijiarr addObject:@"发票管理"];
//                [[Manager sharedManager].yijiimgarr addObject:@"11"];
//            }
            else if ([model.id isEqualToString:@"468"]) {
                [[Manager sharedManager].yijiarr addObject:@"问题管理"];
                [[Manager sharedManager].yijiimgarr addObject:@"问题管理"];
            }
//            else if ([model.id isEqualToString:@"516"]) {
//                [[Manager sharedManager].yijiarr addObject:@"出货管理"];
//                [[Manager sharedManager].yijiimgarr addObject:@"08"];
//            }
            
            
//            NSLog(@"%@---%@",model.id,model.NAME);
            
        }
//        NSLog(@"%@****%@****%@",[Manager sharedManager].piliangID,[Manager sharedManager].xianhuoID,[Manager sharedManager].shouhouID);
        //跳转进入
        NSDictionary *dict = [[NSDictionary alloc]init];
        NSNotification *notification =[NSNotification notificationWithName:@"hiddenlogin" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    

}










- (void)changeLanguageTo:(NSString *)language {
    // 设置语言
    [NSBundle setLanguage:language];
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"myLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (IBAction)clickyuyanbtn:(id)sender {
    
    
   
    self.dropView = [[PGGDropView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 65 ,100, 120) withTitleArray:@[@"中文",@"English"]];
    [self.dropView beginAnimation];
    self.dropView.delegate = self;
    [self.view addSubview:self.dropView];
   
    
}
- (void)PGGDropView:(PGGDropView *)DropView didSelectAtIndex:(NSInteger )index{
    if (index == 100) {
        [self changeLanguageTo:@"zh-Hans"];
        self.namelab.text = NSLocalizedString(@"f7", nil);
        [self.yuyanbtn setTitle:NSLocalizedString(@"f13", nil) forState:UIControlStateNormal];
        self.numberTextfield.placeholder   = NSLocalizedString(@"x1", nil);
        self.usernameTextfield.placeholder = NSLocalizedString(@"x2", nil);
        self.passwordTextfield.placeholder = NSLocalizedString(@"x3", nil);
        [self.btn setTitle:NSLocalizedString(@"x4", nil) forState:UIControlStateNormal];
        [self.yuyanbtn setTitle:NSLocalizedString(@"x5", nil) forState:UIControlStateNormal];
    }else if (index == 101){
        [self changeLanguageTo:@"en"];
        self.namelab.text = NSLocalizedString(@"f7", nil);
        [self.yuyanbtn setTitle:NSLocalizedString(@"f13", nil) forState:UIControlStateNormal];
        self.numberTextfield.placeholder   = NSLocalizedString(@"x1", nil);
        self.usernameTextfield.placeholder = NSLocalizedString(@"x2", nil);
        self.passwordTextfield.placeholder = NSLocalizedString(@"x3", nil);
        [self.btn setTitle:NSLocalizedString(@"x4", nil) forState:UIControlStateNormal];
        [self.yuyanbtn setTitle:NSLocalizedString(@"x5", nil) forState:UIControlStateNormal];
    }
}





- (IBAction)clickwangjimimabtn:(id)sender {
    
    
    
}



- (IBAction)clicktiaokuanbtn:(id)sender {
    
}



//触摸回收键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.textfield = textField;
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textfield resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
