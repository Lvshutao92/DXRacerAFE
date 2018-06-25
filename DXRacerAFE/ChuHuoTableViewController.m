//
//  ChuHuoTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/9.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "ChuHuoTableViewController.h"
#import "SQCH_ViewController.h"
#import "CHQD_ViewController.h"
@interface ChuHuoTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation ChuHuoTableViewController

- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"出货管理";
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.arr = [@[@"申请出货",@"出货清单"]mutableCopy];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    
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
    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"申请出货"]) {
        SQCH_ViewController *jxs1 = [[SQCH_ViewController alloc]init];
        jxs1.navigationItem.title = @"申请出货";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"出货清单"]) {
        CHQD_ViewController *jxs1 = [[CHQD_ViewController alloc]init];
        jxs1.navigationItem.title = @"出货清单";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    
    
}

@end
