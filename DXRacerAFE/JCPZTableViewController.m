//
//  JCPZTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JCPZTableViewController.h"
#import "AppDelegate.h"


#import "JC_1_ViewController.h"
#import "JC_2_ViewController.h"
#import "JC_3_ViewController.h"
#import "JC_4_ViewController.h"
#import "JC_5_ViewController.h"

#import "JC_6_ViewController.h"
#import "JC_7_ViewController.h"
#import "JC_8_ViewController.h"
#import "JC_9_ViewController.h"
#import "JC_10_ViewController.h"

#import "JC_11_ViewController.h"
#import "JC_12_ViewController.h"
#import "JC_13_ViewController.h"
#import "JC_14_ViewController.h"

@interface JCPZTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation JCPZTableViewController

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
    self.navigationItem.title = NSLocalizedString(@"btn6", nil);
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
//    self.arr = [@[NSLocalizedString(@"jc1", nil),NSLocalizedString(@"jc2", nil),NSLocalizedString(@"jc3", nil),NSLocalizedString(@"jc4", nil),NSLocalizedString(@"jc5", nil),NSLocalizedString(@"jc6", nil),NSLocalizedString(@"jc7", nil),NSLocalizedString(@"jc8", nil),NSLocalizedString(@"jc10", nil),NSLocalizedString(@"jc11", nil),NSLocalizedString(@"jc12", nil),NSLocalizedString(@"jc13", nil),NSLocalizedString(@"jc14", nil)]mutableCopy];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    [self lodXianShiInformation];
}



- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":@"63",
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
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc1", nil)]) {
        JC_1_ViewController *jxs1 = [[JC_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc2", nil)]) {
        JC_2_ViewController *jxs1 = [[JC_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc3", nil)]) {
        JC_3_ViewController *jxs1 = [[JC_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc4", nil)]) {
        JC_4_ViewController *jxs1 = [[JC_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc5", nil)]) {
        JC_5_ViewController *jxs1 = [[JC_5_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc6", nil)]) {
        JC_6_ViewController *jxs1 = [[JC_6_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc6", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc7", nil)]) {
        JC_7_ViewController *jxs1 = [[JC_7_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc7", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc8", nil)]) {
        JC_8_ViewController *jxs1 = [[JC_8_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc8", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
//    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc9", nil)]) {
//        JC_9_ViewController *jxs1 = [[JC_9_ViewController alloc]init];
//        jxs1.navigationItem.title = NSLocalizedString(@"jc9", nil);
//        [self.navigationController pushViewController:jxs1 animated:YES];
//    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc10", nil)]) {
        JC_10_ViewController *jxs1 = [[JC_10_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc10", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc11", nil)]) {
        JC_11_ViewController *jxs1 = [[JC_11_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc11", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc12", nil)]) {
        JC_12_ViewController *jxs1 = [[JC_12_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc12", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc13", nil)]) {
        JC_13_ViewController *jxs1 = [[JC_13_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc13", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jc14", nil)]) {
        JC_14_ViewController *jxs1 = [[JC_14_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jc14", nil);
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
