//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
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
#import "UserTableViewController.h"
#import "ChuHuoTableViewController.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UILabel *lab;
}
@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)NSMutableArray *imgArray;
@end

@implementation LeftSortsViewController
- (NSMutableArray *)imgArray {
    if (_imgArray == nil) {
        self.imgArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgArray;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140*SCALE_HEIGHT)];
    view.backgroundColor = RGBACOLOR(0, 162, 153, 1);
    [self.view addSubview:view];
    
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 40*SCALE_HEIGHT,80*SCALE_HEIGHT, 80*SCALE_HEIGHT)];
    self.userImageView.layer.cornerRadius = 40*SCALE_HEIGHT;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageview:)];
    [view addGestureRecognizer:tap];
    self.userImageView.image = [UIImage imageNamed:@"user"];
    [view addSubview:self.userImageView];
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(30+80*SCALE_HEIGHT,40*SCALE_HEIGHT, SCREEN_WIDTH-160-80*SCALE_HEIGHT, 80*SCALE_HEIGHT)];
    lab.numberOfLines = 0;
    lab.text = [NSString stringWithFormat:@"%@\n%@",[Manager redingwenjianming:@"companyName.text"],[Manager redingwenjianming:@"userName.text"]];
    
    
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor whiteColor];
    [view addSubview:lab];
    
    return view;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140*SCALE_HEIGHT;
}






- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 140*SCALE_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-170*SCALE_HEIGHT)];
    self.tableview = tableview;
    tableview.dataSource = self;
    tableview.delegate  = self;
    [tableview registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableview];
    
     UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
     tableview.tableFooterView = view;
    
    
    
//    NSLog(@"--------------%ld",[Manager sharedManager].yijiarr.count);
    
//     self.imgArray = [@[@"00",@"01",@"02",@"03",@"04",@"11",@"05",@"06",@"07",@"08",@"09",@"10",@"05",@"03",@"04"]mutableCopy];
    
    
    
}
- (void)clickImageview:(UITapGestureRecognizer *)sender{
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
    UserTableViewController *user = [[UserTableViewController alloc]init];
    user.navigationItem.title = @"设置";
    [tempAppDelegate.mainNavigationController pushViewController:user animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Manager sharedManager].yijiarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"cell";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.lab.text = [Manager sharedManager].yijiarr[indexPath.row];
    
    cell.img.image = [UIImage imageNamed:[Manager sharedManager].yijiimgarr[indexPath.row]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
//    NSLog(@"%@",NSLocalizedString(@"btn1", nil));
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"btn0", nil)]){
        
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn1", nil)]) {
        JXSGLTableViewController *vc = [[JXSGLTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn2", nil)]) {
        CPTableViewController *vc = [[CPTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn3", nil)]) {
        PLTableViewController *vc = [[PLTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn4", nil)]) {
        XHTableViewController *vc = [[XHTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn5", nil)]) {
        SKTableViewController *vc = [[SKTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn6", nil)]) {
        JCPZTableViewController *vc = [[JCPZTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn7", nil)]) {
        WDTableViewController *vc = [[WDTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn8", nil)]) {
        ZYTableViewController *vc = [[ZYTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn9", nil)]) {
        XTTableViewController *vc = [[XTTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn10", nil)]) {
        DXTableViewController *vc = [[DXTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"btn11", nil)]) {
        PaymentManagerViewController *vc = [[PaymentManagerViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    
    
    
    else if ([cell.lab.text isEqualToString:@"售后订单"]) {
        SHOrderTableViewController *vc = [[SHOrderTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:@"发票管理"]) {
        FPGL_TableViewController *vc = [[FPGL_TableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else if ([cell.lab.text isEqualToString:@"问题管理"]) {
        WTGL_TableViewController *vc = [[WTGL_TableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    
    else if ([cell.lab.text isEqualToString:@"出货管理"]) {
        ChuHuoTableViewController *vc = [[ChuHuoTableViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
}



@end
