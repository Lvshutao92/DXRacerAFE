//
//  WTGL_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WTGL_TableViewController.h"
#import "WTFL_ViewController.h"
#import "RYPZ_ViewController.h"
#import "WYTW_ViewController.h"
#import "WDWT_ViewController.h"
#import "SYWT_ViewController.h"
#import "DHDWT_ViewController.h"
#import "YHDWT_ViewController.h"
#import "WaicengTableViewCell.h"
#import "CJWT_ViewController.h"
@interface WTGL_TableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation WTGL_TableViewController
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"btn9", nil);
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaicengTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    
    [self lodXianShiInformation];
}


- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    //    NSLog(@"%@---%@",[Manager sharedManager].shouhouID,[Manager redingwenjianming:@"roleid.text"]);
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":@"468",
            @"roleId":[Manager redingwenjianming:@"roleid.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"system", @"systemrole", @"getAppResourceByRPId") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        [weakSelf.arr removeAllObjects];
        for (NSDictionary *dic in arr) {
            rolemodel *model = [rolemodel mj_objectWithKeyValues:dic];
            
            if ([model.NAME isEqualToString:@"我要提问"]) {
                weakSelf.arr1 = [@[@"我要提问",@"常见问题",@"我的问题"]mutableCopy];
                [weakSelf.arr addObject:NSLocalizedString(@"e7", nil)];
            }else if ([model.NAME isEqualToString:@"常见问题"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"e8", nil)];
            }else if ([model.NAME isEqualToString:@"我的问题"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"e9", nil)];
            }
            
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaicengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lab.text = self.arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str = self.arr1[indexPath.row];
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",str]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaicengTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lab.text isEqualToString:@"问题分类"]) {
        WTFL_ViewController *jxs1 = [[WTFL_ViewController alloc]init];
        jxs1.navigationItem.title = @"问题分类";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"人员配置"]) {
        RYPZ_ViewController *jxs1 = [[RYPZ_ViewController alloc]init];
        jxs1.navigationItem.title = @"人员配置";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"e7", nil)]) {
        WYTW_ViewController *jxs1 = [[WYTW_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"e7", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"e9", nil)]) {
        WDWT_ViewController *jxs1 = [[WDWT_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"e9", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"所有问题"]) {
        SYWT_ViewController *jxs1 = [[SYWT_ViewController alloc]init];
        jxs1.navigationItem.title = @"所有问题";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"待回答问题"]) {
        DHDWT_ViewController *jxs1 = [[DHDWT_ViewController alloc]init];
        jxs1.navigationItem.title = @"待回答问题";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"已回答问题"]) {
        YHDWT_ViewController *jxs1 = [[YHDWT_ViewController alloc]init];
        jxs1.navigationItem.title = @"已回答问题";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"e8", nil)]) {
        CJWT_ViewController *jxs1 = [[CJWT_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"e8", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
}

@end
