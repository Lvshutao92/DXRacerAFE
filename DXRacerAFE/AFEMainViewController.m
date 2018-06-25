//
//  AFEMainViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "AFEMainViewController.h"
#import "LeftTableViewCell.h"
#import "JXSGLTableViewController.h"
#import "CPTableViewController.h"
#import "PLTableViewController.h"
#import "XHTableViewController.h"
#import "SKTableViewController.h"
#import "JCPZTableViewController.h"
#import "WDTableViewController.h"
#import "ZYTableViewController.h"
#import "XTTableViewController.h"
#import "DXTableViewController.h"
#import "PaymentManagerViewController.h"

#import "FPGL_TableViewController.h"
#import "WTGL_TableViewController.h"


#import "SHOrderTableViewController.h"
#import "PL____TableViewController.h"
#import "XH___TableViewController.h"

#import "ChuHuoTableViewController.h"

#import "UserTableViewController.h"
@interface AFEMainViewController ()
{
    float height;
    UILabel *lab;
    NSString *totalMoney;
}
@property(nonatomic, strong)UIScrollView *scrollview;
@property(nonatomic, strong)NSMutableArray *imgArray;

@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)NSMutableArray *dataSourceArray;
@end

@implementation AFEMainViewController
- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArray;
}
- (NSMutableArray *)imgArray {
    if (_imgArray == nil) {
        self.imgArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgArray;
}


- (void)lodfanwei{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString1(@"servlet", @"batch", @"batchshoppingcart") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"---------%@",dic);
        NSDictionary *dict = [[dic objectForKey:@"rows"] objectForKey:@"batchOrderQuantityAttr"];
        [Manager sharedManager].gerenMax = [dict objectForKey:@"unitMaxNumber"];
        [Manager sharedManager].gerenMin = [dict objectForKey:@"unitMinNumber"];
        
        
        [Manager sharedManager].piliangMax = [dict objectForKey:@"orderMaxNumber"];
        [Manager sharedManager].piliangMin = [dict objectForKey:@"orderMinNumber"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lodfanwei];
    
//    self.navigationItem.title = NSLocalizedString(@"y1", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self setStatusBarBackgroundColor:RGBACOLOR(64, 64, 64, 1.0)];
    
    
    
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140+50*SCALE_HEIGHT)];
    headView.backgroundColor = RGBACOLOR(64, 64, 64, 1.0);
    
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 55*SCALE_HEIGHT, 80, 80)];
    self.userImageView.layer.cornerRadius = 40;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.userInteractionEnabled = YES;
    self.userImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageview:)];
    [self.userImageView addGestureRecognizer:tap];
//    UIImage *theImage = [UIImage imageNamed:@"user"];
//    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.userImageView.image = [UIImage imageNamed:@"user"];
//    self.userImageView.tintColor = [UIColor whiteColor];
    [headView addSubview:self.userImageView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-50, 10, 30, 30) ;
    [btn setImage:[UIImage imageNamed:@"sz"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btn];
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(120, 50*SCALE_HEIGHT+5, SCREEN_WIDTH-130, 45)];
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor whiteColor];
    
    lab.text = [NSString stringWithFormat:@"%@",[Manager redingwenjianming:@"userName.text"]];
    [headView addSubview:lab];
    
    
    UILabel  *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(120, 50*SCALE_HEIGHT+40, SCREEN_WIDTH-130, 45)];
    lab1.numberOfLines = 0;
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.textColor = [UIColor whiteColor];
    lab1.text = [NSString stringWithFormat:@"%@",[Manager redingwenjianming:@"companyName.text"]];
    [headView addSubview:lab1];
    
    
    [self.scrollview addSubview:headView];
    [self.view addSubview:self.scrollview];
    
    
    [self.dataSourceArray removeAllObjects];
    
    for (NSString *str in [Manager sharedManager].yijiarr) {
        if ([str isEqualToString:@"批量订单"]) {
            [self.dataSourceArray addObject:NSLocalizedString(@"btn3", nil)];
        }
        else if ([str isEqualToString:@"现货订单"]) {
            [self.dataSourceArray addObject:NSLocalizedString(@"btn4", nil)];
        }
        else if ([str isEqualToString:@"售后订单"]) {
            [self.dataSourceArray addObject:NSLocalizedString(@"btn5", nil)];
        }
        else if ([str isEqualToString:@"问题管理"]) {
            [self.dataSourceArray addObject:NSLocalizedString(@"btn9", nil)];
        }
    }
    
    self.imgArray = [Manager sharedManager].yijiimgarr;
    
    [self setbutton];
}
- (void)setbutton {
    
    int b = 0;
    int hangshu;
    if (self.dataSourceArray.count % 3 == 0 ) {
        hangshu = (int )self.dataSourceArray.count / 3;
    } else {
        hangshu = (int )self.dataSourceArray.count / 3 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 3; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < self.dataSourceArray.count) {
                btn.frame = CGRectMake((0  + j * SCREEN_WIDTH/3), (140+50*SCALE_HEIGHT + i * 120*SCALE_HEIGHT) ,SCREEN_WIDTH/3, 120*SCALE_HEIGHT);
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = b;
                [btn setTitle:self.dataSourceArray[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                height = i * 120*SCALE_HEIGHT + 350*SCALE_HEIGHT;
                [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
                
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgArray[b]]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(yejian:) forControlEvents:UIControlEventTouchUpInside];
                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                [btn.layer setBorderWidth:0.5f];
                [btn.layer setMasksToBounds:YES];
                [self.scrollview addSubview:btn];
                if (b > self.dataSourceArray.count   )
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
            
        }
    }
    
    
}
- (void)yejian:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn0", nil)]){
        self.tabBarController.selectedIndex = 2;
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn1", nil)]) {
        JXSGLTableViewController *vc = [[JXSGLTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn2", nil)]) {
        CPTableViewController *vc = [[CPTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn3", nil)]) {
        PLTableViewController *vc = [[PLTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn4", nil)]) {
        XHTableViewController *vc = [[XHTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn6", nil)]) {
        SKTableViewController *vc = [[SKTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn7", nil)]) {
        JCPZTableViewController *vc = [[JCPZTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn12", nil)]) {
        WDTableViewController *vc = [[WDTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn8", nil)]) {
        ZYTableViewController *vc = [[ZYTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn11", nil)]) {
        XTTableViewController *vc = [[XTTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn10", nil)]) {
        DXTableViewController *vc = [[DXTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn13", nil)]) {
        PaymentManagerViewController *vc = [[PaymentManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //    "btn0"  = "首页";
    //    "btn1"  = "经销商管理";
    //    "btn2"  = "产品浏览";
    //    "btn3"  = "批量订单";
    //    "btn4"  = "现货订单";
    //    "btn5"  = "售后订单";
    //    "btn6"  = "收款管理";
    //    "btn7"  = "基础配置";
    //    "btn8"  = "资源中心";
    //    "btn9"  = "问题管理";
    //    "btn10" = "迪锐克斯";
    //    "btn11"  = "系统管理";
    //
    //    "btn12"  = "我的信息";
    //    "btn13" = "付款管理";
    //    "btn14"  = "发票管理";
    
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn5", nil)]) {
        SHOrderTableViewController *vc = [[SHOrderTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn14", nil)]) {
        FPGL_TableViewController *vc = [[FPGL_TableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"btn9", nil)]) {
        WTGL_TableViewController *vc = [[WTGL_TableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"出货管理"]) {
        ChuHuoTableViewController *vc = [[ChuHuoTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
    

    
    
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickImageview:(UITapGestureRecognizer *)gesture{
        UserTableViewController *install = [[UserTableViewController alloc]init];
        [self.navigationController pushViewController:install animated:YES];
        self.tabBarController.tabBar.hidden = YES;
}
- (void)clickEdit{
        UserTableViewController *install = [[UserTableViewController alloc]init];
    
        [self.navigationController pushViewController:install animated:YES];
    
        self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:RGBACOLOR(64, 64, 64, 1.0)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:RGBACOLOR(248, 248, 248, 1.0)];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    return;
}







@end
