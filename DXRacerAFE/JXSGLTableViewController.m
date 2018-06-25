//
//  JXSGLTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXSGLTableViewController.h"
#import "AppDelegate.h"

#import "JXS_1_ViewController.h"
#import "JXS_2_ViewController.h"
#import "JXS_3_ViewController.h"
#import "JXS_4_ViewController.h"
#import "JXS_5_ViewController.h"
#import "JXS_6_ViewController.h"
#import "JXS_7_ViewController.h"
#import "JXS_8_ViewController.h"
#import "JXS_9_ViewController.h"
#import "JXS_10_ViewController.h"
#import "JXS_11_ViewController.h"

#import "JXS_12_ViewController.h"
#import "JXS_13_ViewController.h"
#import "JXS_14_ViewController.h"
#import "MDG_ViewController.h"
@interface JXSGLTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation JXSGLTableViewController

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

- (void)back{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC openLeftView];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"btn1", nil);
    
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
//    self.arr = [@[NSLocalizedString(@"jxs1", nil),NSLocalizedString(@"jxs3", nil),NSLocalizedString(@"jxs4", nil),NSLocalizedString(@"jxs2", nil),NSLocalizedString(@"jxs5", nil),NSLocalizedString(@"jxs6", nil),NSLocalizedString(@"jxs7", nil),NSLocalizedString(@"jxs8", nil),NSLocalizedString(@"jxs9", nil),NSLocalizedString(@"jxs10", nil),NSLocalizedString(@"jxs11", nil)]mutableCopy];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    
    [self lodXianShiInformation];
}



- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":@"14",
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
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs1", nil)]) {
        JXS_1_ViewController *jxs1 = [[JXS_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs2", nil)]) {
        JXS_4_ViewController *jxs1 = [[JXS_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs3", nil)]) {
        JXS_2_ViewController *jxs1 = [[JXS_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs4", nil)]) {
        JXS_3_ViewController *jxs1 = [[JXS_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs5", nil)]) {
        JXS_5_ViewController *jxs1 = [[JXS_5_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs6", nil)]) {
        JXS_6_ViewController *jxs1 = [[JXS_6_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs6", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs7", nil)]) {
        JXS_7_ViewController *jxs1 = [[JXS_7_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs7", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs8", nil)]) {
        JXS_8_ViewController *jxs1 = [[JXS_8_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs8", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs9", nil)]) {
        JXS_9_ViewController *jxs1 = [[JXS_9_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs9", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs10", nil)]) {
        JXS_10_ViewController *jxs1 = [[JXS_10_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs10", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"jxs11", nil)]) {
        JXS_11_ViewController *jxs1 = [[JXS_11_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"jxs11", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    
    
    else if ([cell.textLabel.text isEqualToString:@"用户管理"]) {
        JXS_12_ViewController *jxs1 = [[JXS_12_ViewController alloc]init];
        jxs1.navigationItem.title = @"用户管理";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"说明书"]) {
        JXS_13_ViewController *jxs1 = [[JXS_13_ViewController alloc]init];
        jxs1.navigationItem.title = @"说明书";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"标签管理"]) {
        JXS_14_ViewController *jxs1 = [[JXS_14_ViewController alloc]init];
        jxs1.navigationItem.title = @"标签管理";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"目的港"]) {
        MDG_ViewController *jxs1 = [[MDG_ViewController alloc]init];
        jxs1.navigationItem.title = @"目的港";
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
