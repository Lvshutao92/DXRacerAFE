//
//  XHTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XHTableViewController.h"
#import "AppDelegate.h"

#import "XH_1_ViewController.h"
#import "XH_2_ViewController.h"
#import "XH_3_ViewController.h"
#import "XH_4_ViewController.h"
#import "XH_5_ViewController.h"
#import "XH_6_ViewController.h"

#import "XH_01_ViewController.h"
#import "XH_02_ViewController.h"
#import "XH_03_ViewController.h"
#import "XH_04_ViewController.h"
#import "WaicengTableViewCell.h"
@interface XHTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation XHTableViewController
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
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"btn4", nil);
//    UIButton *btn = [Manager returnButton];
//    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = bar;
    
//    self.arr = [@[NSLocalizedString(@"xh1", nil),NSLocalizedString(@"xh2", nil),NSLocalizedString(@"xh3", nil),NSLocalizedString(@"xh4", nil),NSLocalizedString(@"xh5", nil)]mutableCopy];
    
//    self.arr = [@[@"商品浏览",@"可买商品",@"我的购物车",@"订单列表"]mutableCopy];
    
    
     [self.tableView registerNib:[UINib nibWithNibName:@"WaicengTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
    
    
    [self lodXianShiInformation];
}




- (void)lodXianShiInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    
    dic = @{@"id":[Manager sharedManager].xianhuoID,
            @"roleId":[Manager redingwenjianming:@"roleid.text"],
            };
//     NSLog(@"----%@",dic);
    [session POST:KURLNSString2(@"servlet", @"system", @"systemrole", @"getAppResourceByRPId") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        NSMutableArray *arrrrr = [NSMutableArray arrayWithCapacity:1];
        [arrrrr removeAllObjects];
        for (NSDictionary *dic in arr) {
            rolemodel *model = [rolemodel mj_objectWithKeyValues:dic];
            [arrrrr addObject:model];
//                        NSLog(@"%@",model.NAME);
        }
        
        
        
        [weakSelf.arr removeAllObjects];
        for (rolemodel *model in arrrrr) {
            if ([model.NAME isEqualToString:@"所有订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh1", nil)];
                 weakSelf.arr1 = [@[@"列表",@"列表",@"列表",@"列表",@"列表",@"列表"]mutableCopy];
            }else if ([model.NAME isEqualToString:@"待确认订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh2", nil)];
            }else if ([model.NAME isEqualToString:@"已确认订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh3", nil)];
            }else if ([model.NAME isEqualToString:@"待发货订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh4", nil)];
            }else if ([model.NAME isEqualToString:@"已发货订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh5", nil)];
            }else if ([model.NAME isEqualToString:@"已取消订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh6", nil)];
            }
            
            else if ([model.NAME isEqualToString:@"商品浏览"]) {
                weakSelf.arr1 = [@[@"产品",@"可放心购买",@"我的购物车",@"列表"]mutableCopy];
                [weakSelf.arr addObject:NSLocalizedString(@"xh-1", nil)];
            }else if ([model.NAME isEqualToString:@"可买商品"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh-2", nil)];
            }else if ([model.NAME isEqualToString:@"我的购物车"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh-3", nil)];
            }else if ([model.NAME isEqualToString:@"订单列表"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"xh-4", nil)];
            }
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
    if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh1", nil)]) {
        XH_1_ViewController *jxs1 = [[XH_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh2", nil)]) {
        XH_2_ViewController *jxs1 = [[XH_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh3", nil)]) {
        XH_3_ViewController *jxs1 = [[XH_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh5", nil)]) {
        XH_4_ViewController *jxs1 = [[XH_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh6", nil)]) {
        XH_5_ViewController *jxs1 = [[XH_5_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh6", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh4", nil)]) {
        XH_6_ViewController *jxs1 = [[XH_6_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }

    
    
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh-1", nil)]) {
        XH_01_ViewController *jxs1 = [[XH_01_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh-1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh-2", nil)]) {
        XH_02_ViewController *jxs1 = [[XH_02_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh-2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh-3", nil)]) {
        XH_03_ViewController *jxs1 = [[XH_03_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh-3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"xh-4", nil)]) {
        XH_04_ViewController *jxs1 = [[XH_04_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"xh-4", nil);
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
