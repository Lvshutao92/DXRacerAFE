//
//  SKTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SKTableViewController.h"
#import "AppDelegate.h"
#import "SK1ViewController.h"
#import "SK2ViewController.h"
#import "SK3ViewController.h"
#import "Sk4ViewController.h"
#import "SK5ViewController.h"


@interface SKTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation SKTableViewController

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
    self.navigationItem.title = NSLocalizedString(@"btn5", nil);
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
//    self.arr = [@[@"应收款清单",@"待收款列表",@"所有收款单",@"信用证审核",@"信用证列表"]mutableCopy];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    [self lodXianShiInformation];
}



- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":@"59",
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
    if ([cell.textLabel.text isEqualToString:@"应收款清单"]) {
        SK1ViewController *jxs1 = [[SK1ViewController alloc]init];
        jxs1.navigationItem.title = @"应收款清单";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"待收款列表"]) {
        SK2ViewController *jxs1 = [[SK2ViewController alloc]init];
        jxs1.navigationItem.title = @"待收款列表";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"所有收款单"]) {
        SK3ViewController *jxs1 = [[SK3ViewController alloc]init];
        jxs1.navigationItem.title = @"所有收款单";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"信用证审核"]) {
        Sk4ViewController *jxs1 = [[Sk4ViewController alloc]init];
        jxs1.navigationItem.title = @"信用证审核";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"信用证列表"]) {
        SK5ViewController *jxs1 = [[SK5ViewController alloc]init];
        jxs1.navigationItem.title = @"信用证列表";
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
   
}





/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    return cell;
}
*/

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
