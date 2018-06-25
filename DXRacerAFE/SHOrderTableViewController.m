//
//  SHOrderTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SHOrderTableViewController.h"
#import "SH1ViewController.h"
#import "SH2ViewController.h"
#import "SH3ViewController.h"
#import "SH4ViewController.h"
#import "SH5ViewController.h"
#import "SH6ViewController.h"


#import "JXS_SH_1_ViewController.h"
#import "JXS_SH_2_ViewController.h"
#import "JXS_SH_3_ViewController.h"
#import "JXS_SH_4_ViewController.h"

#import "WaicengTableViewCell.h"
@interface SHOrderTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation SHOrderTableViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    self.navigationItem.title = NSLocalizedString(@"btn5", nil);
//    UIButton *btn = [Manager returnButton];
//    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = bar;
   
//    self.arr = [@[@"所有订单",@"待确认订单",@"已确认订单",@"待发货订单",@"已发货订单",@"已取消订单"]mutableCopy];
    
    
//    self.arr = [@[@"无偿售后",@"有偿售后",@"我的购物车",@"订单列表"]mutableCopy];
    
    
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
    dic = @{@"id":[Manager sharedManager].shouhouID,
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
        }
        
        [weakSelf.arr removeAllObjects];
        for (rolemodel *model in arrrrr) {
            if ([model.NAME isEqualToString:@"所有订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh1", nil)];
                weakSelf.arr1 = [@[@"列表",@"列表",@"列表",@"列表",@"列表",@"列表"]mutableCopy];
            }else if ([model.NAME isEqualToString:@"待确认订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh2", nil)];
            }else if ([model.NAME isEqualToString:@"已确认订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh3", nil)];
            }else if ([model.NAME isEqualToString:@"待发货订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh4", nil)];
            }else if ([model.NAME isEqualToString:@"已发货订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh5", nil)];
            }else if ([model.NAME isEqualToString:@"已取消订单"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh6", nil)];
            }
            
            else if ([model.NAME isEqualToString:@"无偿售后"]) {
                weakSelf.arr1 = [@[@"yc",@"我的购物车",@"列表",@"wc"]mutableCopy];
                [weakSelf.arr addObject:NSLocalizedString(@"sh-1", nil)];
            }else if ([model.NAME isEqualToString:@"有偿售后"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh-2", nil)];
            }else if ([model.NAME isEqualToString:@"我的购物车"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh-3", nil)];
            }else if ([model.NAME isEqualToString:@"订单列表"]) {
                [weakSelf.arr addObject:NSLocalizedString(@"sh-4", nil)];
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
    if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh1", nil)]) {
        SH1ViewController *jxs1 = [[SH1ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh2", nil)]) {
        SH2ViewController *jxs1 = [[SH2ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh3", nil)]) {
        SH3ViewController *jxs1 = [[SH3ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh5", nil)]) {
        SH4ViewController *jxs1 = [[SH4ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh5", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh6", nil)]) {
        SH5ViewController *jxs1 = [[SH5ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh6", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh4", nil)]) {
        SH6ViewController *jxs1 = [[SH6ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh4", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    
 
    
    
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh-1", nil)]) {
        JXS_SH_1_ViewController *jxs1 = [[JXS_SH_1_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh-1", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh-2", nil)]) {
        JXS_SH_2_ViewController *jxs1 = [[JXS_SH_2_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh-2", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh-3", nil)]) {
        JXS_SH_3_ViewController *jxs1 = [[JXS_SH_3_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh-3", nil);
        [self.navigationController pushViewController:jxs1 animated:YES];
    }
    else if ([cell.lab.text isEqualToString:NSLocalizedString(@"sh-4", nil)]) {
        JXS_SH_4_ViewController *jxs1 = [[JXS_SH_4_ViewController alloc]init];
        jxs1.navigationItem.title = NSLocalizedString(@"sh-4", nil);
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
