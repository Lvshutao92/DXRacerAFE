//
//  Sk4ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Sk4ViewController.h"
#import "SK4Cell.h"
#import "SK4model.h"
#import "Sk4OrderModel.h"
#import "SK4_dealer_model.h"
#import "LookPictureViewController.h"
#import "SK4detailsTableViewController.h"
@interface Sk4ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation Sk4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"SK4Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    SK4Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SK4Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SK4model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.ordermodel.orderNo;
    
    cell.lab2.text = model.ordermodel.dealermodel.companyName;
    
    
//    if (model.field1) {
//        <#statements#>
//    }
//    
    
    cell.lab3.text = [Manager jinegeshi:model.ordermodel.productTotalFee];
    
    
    if ([model.paymentStatus isEqualToString:@"N"]) {
        cell.lab4.text = @"未付款";
    }else if ([model.paymentStatus isEqualToString:@"A"]) {
        cell.lab4.text = @"待审核";
    }else if ([model.paymentStatus isEqualToString:@"Y"]) {
        cell.lab4.text = @"已审核";
    }else if ([model.paymentStatus isEqualToString:@"C"]) {
        cell.lab4.text = @"已取消";
    }
    
    
    
    if ([model.ordermodel.orderType isEqualToString:@"batchOrder"]) {
        cell.lab5.text = @"批量订单";
    }else if ([model.ordermodel.orderType isEqualToString:@"afterSale"]) {
        cell.lab5.text = @"售后订单";
    }else if ([model.ordermodel.orderType isEqualToString:@"tradOrder"]) {
        cell.lab5.text = @"现货订单";
    }
   
    
    
    if ([model.ordermodel.orderStatus isEqualToString:@"confirm"]) {
        cell.lab6.text = @"待确认订单";
    }else if ([model.ordermodel.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab6.text = @"已确认订单";
    }else if ([model.ordermodel.orderStatus isEqualToString:@"production"]) {
        cell.lab6.text = @"生产中订单";
    }else if ([model.ordermodel.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab6.text = @"待发货订单";
    }else if ([model.ordermodel.orderStatus isEqualToString:@"delivery"]) {
        cell.lab6.text = @"已发货订单";
    }else if ([model.ordermodel.orderStatus isEqualToString:@"cancelled"]) {
        cell.lab6.text = @"已取消订单";
    }
    
    
    
    if (model.field1 == nil) {
        [cell.lookbtn setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [cell.lookbtn setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.lookbtn addTarget:self action:@selector(look:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
   
    [cell.auditbtn addTarget:self action:@selector(audit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}


- (void)look:(UIButton *)sender{
    SK4Cell *cell = (SK4Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    SK4model *model = [self.dataArray objectAtIndex:indexpath.row];
    if (model.field1 != nil) {
        LookPictureViewController *look = [[LookPictureViewController alloc]init];
        look.imgStr = model.field1;
        [self.navigationController pushViewController:look animated:YES];
    }
    
}

- (void)audit:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定审核吗？" preferredStyle:1];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SK4Cell *cell = (SK4Cell *)[[sender.superview superview] superview];
        NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
        SK4model *model = [self.dataArray objectAtIndex:indexpath.row];
        [self lodaudit:model.id indexpath:indexpath];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)lodaudit:(NSString *)str indexpath:(NSIndexPath *)indexpath{
   
    
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"username":[Manager redingwenjianming:@"userName.text"],
            @"id":str,
            };
    
    [session POST:KURLNSString2(@"servlet", @"lc", @"manager",@"audit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//         NSLog(@"dic = %@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"审核成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SK4model *model = [self.dataArray objectAtIndex:indexPath.row];
    SK4detailsTableViewController *commit = [[SK4detailsTableViewController alloc]init];
    commit.navigationItem.title = @"详情";
    
    commit.strid = model.orderId;
    [self.navigationController pushViewController:commit animated:YES];
}






//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"Page":[NSString stringWithFormat:@"%ld",(long)page],
            @"lcCheck":@"lcCheck",
            };
    
    [session POST:KURLNSString2(@"servlet", @"lc", @"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"dic = %@",dic);
                totalnum = [[dic objectForKey:@"total"] integerValue];
                [weakSelf.dataArray removeAllObjects];
        
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
                for (NSDictionary *dic in arr) {
                    SK4model *model = [SK4model mj_objectWithKeyValues:dic];
        
                    Sk4OrderModel *model1 = [Sk4OrderModel mj_objectWithKeyValues:model.order];
                    model.ordermodel = model1;
                    
                    
                    SK4_dealer_model *model2 = [SK4_dealer_model mj_objectWithKeyValues:model1.dealerInfo];
                    model1.dealermodel = model2;
        
                    
                    [weakSelf.dataArray addObject:model];
                }
        
        
        
        page=2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"Page":[NSString stringWithFormat:@"%ld",(long)page],
            @"lcCheck":@"lcCheck",
            };
    [session POST:KURLNSString2(@"servlet", @"lc", @"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            SK4model *model = [SK4model mj_objectWithKeyValues:dic];
            
            Sk4OrderModel *model1 = [Sk4OrderModel mj_objectWithKeyValues:model.order];
            model.ordermodel = model1;
            
            
            SK4_dealer_model *model2 = [SK4_dealer_model mj_objectWithKeyValues:model1.dealerInfo];
            model1.dealermodel = model2;
            
            
            [weakSelf.dataArray addObject:model];
        }
        
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}










- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
