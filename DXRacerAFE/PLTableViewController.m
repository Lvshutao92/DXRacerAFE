//
//  PLTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PLTableViewController.h"
#import "AppDelegate.h"

#import "PL_1_ViewController.h"
#import "PL_2_ViewController.h"
#import "PL_3_ViewController.h"
#import "PL_4_ViewController.h"
#import "PL_5_ViewController.h"
#import "PL_6_ViewController.h"
#import "PL_7_ViewController.h"

#import "PL_01_ViewController.h"
#import "PL_02_ViewController.h"


#import "ShoppingCartViewController.h"

#import "PL_04_ViewController.h"
#import "WaicengTableViewCell.h"
@interface PLTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation PLTableViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"btn3", nil);
//    UIButton *btn = [Manager returnButton];
//    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = bar;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaicengTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    self.arr = [@[NSLocalizedString(@"pl1", nil),NSLocalizedString(@"pl2", nil),NSLocalizedString(@"pl3", nil),NSLocalizedString(@"pl4", nil),@"待发货订单",NSLocalizedString(@"pl5", nil),NSLocalizedString(@"pl6", nil)]mutableCopy];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
//    NSLog(@"%@",[Manager sharedManager].piliangID);
    [self lodXianShiInformation];
}



- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"id":[Manager sharedManager].piliangID,
            @"roleId":[Manager redingwenjianming:@"roleid.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"system", @"systemrole", @"getAppResourceByRPId") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        NSMutableArray *arrrrr = [NSMutableArray arrayWithCapacity:1];
        [arrrrr removeAllObjects];
        for (NSDictionary *dic in arr) {
            rolemodel *model = [rolemodel mj_objectWithKeyValues:dic];
            [arrrrr addObject:model];
            //NSLog(@"%@",model.NAME);
        }
        
        [weakSelf.arr removeAllObjects];
        for (rolemodel *model in arrrrr) {
            if ([model.NAME isEqualToString:@"所有订单"]) {
                weakSelf.arr1 = [@[@"列表",@"列表",@"列表",@"列表",@"列表",@"列表",@"列表"]mutableCopy];
                [weakSelf.arr addObject:NSLocalizedString(@"pl1", nil)];
            }else if ([model.NAME isEqualToString:@"待确认订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl2", nil)];
            }else if ([model.NAME isEqualToString:@"已确认订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl3", nil)];
            }else if ([model.NAME isEqualToString:@"生产中订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl4", nil)];
            }else if ([model.NAME isEqualToString:@"待发货订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl5", nil)];
            }else if ([model.NAME isEqualToString:@"已发货订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl6", nil)];
            }else if ([model.NAME isEqualToString:@"已取消订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl7", nil)];
            }
            
            else if ([model.NAME isEqualToString:@"产品浏览"]) {
                weakSelf.arr1 = [@[@"产品",@"可放心购买",@"我的购物车",@"列表"]mutableCopy];
                [weakSelf.arr addObject:NSLocalizedString(@"pl-1", nil)];
            }else if ([model.NAME isEqualToString:@"可买产品"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl-2", nil)];
            }else if ([model.NAME isEqualToString:@"我的购物车"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl-3", nil)];
            }else if ([model.NAME isEqualToString:@"订单列表"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"pl-4", nil)];
            }
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
    if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl1", nil)]) {
        PL_1_ViewController *jxs1 = [[PL_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl2", nil)]) {
        PL_2_ViewController *jxs1 = [[PL_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl3", nil)]) {
        PL_3_ViewController *jxs1 = [[PL_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl4", nil)]) {
        PL_4_ViewController *jxs1 = [[PL_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl6", nil)]) {
        PL_5_ViewController *jxs1 = [[PL_5_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl6", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl7", nil)]) {
        PL_6_ViewController *jxs1 = [[PL_6_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl7", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl5", nil)]) {
        PL_7_ViewController *jxs1 = [[PL_7_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    
   
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl-1", nil)]) {
        PL_01_ViewController *jxs1 = [[PL_01_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl-1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl-2", nil)]) {
        PL_02_ViewController *jxs1 = [[PL_02_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl-2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl-3", nil)]) {
        ShoppingCartViewController *jxs1 = [[ShoppingCartViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl-3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"pl-4", nil)]) {
        PL_04_ViewController *jxs1 = [[PL_04_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"pl-4", nil);
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
