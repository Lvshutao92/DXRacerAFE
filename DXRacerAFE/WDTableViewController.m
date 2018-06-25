//
//  WDTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WDTableViewController.h"
#import "AppDelegate.h"


#import "WD_1_ViewController.h"
#import "WD_2_ViewController.h"
#import "WD_3_ViewController.h"
#import "WD_4_ViewController.h"
#import "WD_5_ViewController.h"
#import "WD_6_ViewController.h"
#import "WD_7_ViewController.h"
#import "WD_8_ViewController.h"
#import "WD_9_ViewController.h"
#import "WD_10_ViewController.h"


@interface WDTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation WDTableViewController
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
    self.navigationItem.title = NSLocalizedString(@"btn7", nil);
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
//    self.arr = [@[NSLocalizedString(@"wd1", nil),NSLocalizedString(@"wd2", nil),NSLocalizedString(@"wd3", nil),NSLocalizedString(@"wd4", nil),NSLocalizedString(@"wd5", nil),NSLocalizedString(@"wd6", nil),NSLocalizedString(@"wd7", nil),NSLocalizedString(@"wd8", nil),NSLocalizedString(@"wd9", nil),NSLocalizedString(@"wd10", nil)]mutableCopy];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    [self lodXianShiInformation];
}



- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":@"78",
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
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd1", nil)]) {
        WD_1_ViewController *jxs1 = [[WD_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd2", nil)]) {
        WD_2_ViewController *jxs1 = [[WD_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd3", nil)]) {
        WD_3_ViewController *jxs1 = [[WD_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd4", nil)]) {
        WD_4_ViewController *jxs1 = [[WD_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd5", nil)]) {
        WD_5_ViewController *jxs1 = [[WD_5_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd6", nil)]) {
        WD_6_ViewController *jxs1 = [[WD_6_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd6", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd7", nil)]) {
        WD_7_ViewController *jxs1 = [[WD_7_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd7", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd8", nil)]) {
        WD_8_ViewController *jxs1 = [[WD_8_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd8", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd9", nil)]) {
        WD_9_ViewController *jxs1 = [[WD_9_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd9", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"wd10", nil)]) {
        WD_10_ViewController *jxs1 = [[WD_10_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"wd10", nil);
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
