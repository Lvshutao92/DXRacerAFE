//
//  FPGL_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FPGL_TableViewController.h"
#import "FPPZViewController.h"
#import "KKFPViewController.h"
#import "WDFPViewController.h"
#import "SYFPViewController.h"
#import "DKPViewController.h"
#import "DJPViewController.h"
@interface FPGL_TableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation FPGL_TableViewController

- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发票管理";
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    
    [self lodXianShiInformation];
}


- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
//    NSLog(@"%@---%@",[Manager sharedManager].shouhouID,[Manager redingwenjianming:@"roleid.text"]);
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":@"491",
            @"roleId":[Manager redingwenjianming:@"roleid.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"system", @"systemrole", @"getAppResourceByRPId") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        [weakSelf.arr removeAllObjects];
        for (NSDictionary *dic in arr) {
            rolemodel *model = [rolemodel mj_objectWithKeyValues:dic];
            [weakSelf.arr addObject:model];
            //            NSLog(@"%@",model.NAME);
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)back{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC openLeftView];
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    rolemodel *model = [self.arr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.NAME;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"发票配置"]) {
        FPPZViewController *jxs1 = [[FPPZViewController alloc]init];
        jxs1.navigationItem.title = @"发票配置";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"可开发票"]) {
        KKFPViewController *jxs1 = [[KKFPViewController alloc]init];
        jxs1.navigationItem.title = @"可开发票";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"我的发票"]) {
        WDFPViewController *jxs1 = [[WDFPViewController alloc]init];
        jxs1.navigationItem.title = @"我的发票";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"所有发票"]) {
        SYFPViewController *jxs1 = [[SYFPViewController alloc]init];
        jxs1.navigationItem.title = @"所有发票";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"待开票"]) {
        DKPViewController *jxs1 = [[DKPViewController alloc]init];
        jxs1.navigationItem.title = @"待开票";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"待寄票"]) {
        DJPViewController *jxs1 = [[DJPViewController alloc]init];
        jxs1.navigationItem.title = @"待寄票";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    
    
}

@end
