//
//  XH___TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XH___TableViewController.h"
#import "XH_1_ViewController.h"
#import "XH_2_ViewController.h"
#import "XH_3_ViewController.h"
#import "XH_4_ViewController.h"
#import "XH_5_ViewController.h"
#import "XH_6_ViewController.h"
@interface XH___TableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation XH___TableViewController


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"btn4", nil);
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.arr = [@[NSLocalizedString(@"xh1", nil),NSLocalizedString(@"xh2", nil),NSLocalizedString(@"xh3", nil),@"待发货订单",NSLocalizedString(@"xh4", nil),NSLocalizedString(@"xh5", nil)]mutableCopy];
    
    
    
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
    
    cell.textLabel.text = self.arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"xh1", nil)]) {
        XH_1_ViewController *jxs1 = [[XH_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"xh2", nil)]) {
        XH_2_ViewController *jxs1 = [[XH_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"xh3", nil)]) {
        XH_3_ViewController *jxs1 = [[XH_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"xh4", nil)]) {
        XH_4_ViewController *jxs1 = [[XH_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"xh5", nil)]) {
        XH_5_ViewController *jxs1 = [[XH_5_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    
    else if ([cell.textLabel.text isEqualToString:@"待发货订单"]) {
        XH_5_ViewController *jxs1 = [[XH_5_ViewController alloc]init];
        jxs1.navigationItem.title = @"待发货订单";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }

    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
