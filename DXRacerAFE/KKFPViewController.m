//
//  KKFPViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "KKFPViewController.h"
#import "KKFP_Cell.h"
#import "kkfpmodel.h"
#import "KKFP_details_Controller.h"
@interface KKFPViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableview;

@end

@implementation KKFPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"KKFP_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self setUpReflash];
}
- (void)clickkkfpbtn:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定申请吗？" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        KKFP_Cell *cell = (KKFP_Cell *)[[sender.superview superview] superview];
        NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
        kkfpmodel *model = [self.dataArray objectAtIndex:indexpath.row];
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString2(@"servlet", @"invoice",@"apply",@"invoice") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"申请成功" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"申请失败" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            [weakSelf.tableview reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
        
    }];
    [alert addAction:cancel];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kkfpmodel *model = [self.dataArray objectAtIndex:indexPath.row];
    KKFP_details_Controller *details = [[KKFP_details_Controller alloc]init];
    details.navigationItem.title = @"详情";
    details.ids = model.id;
    [self.navigationController pushViewController:details animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    KKFP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[KKFP_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.kkfpbtn.layer.borderWidth = 1;
    cell.kkfpbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.kkfpbtn.layer.masksToBounds = YES;
    cell.kkfpbtn.layer.cornerRadius = 5;
    
    kkfpmodel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.orderNo;
    cell.lab2.text = [Manager jinegeshi:model.orderTotalFee];
    if ([model.orderType isEqualToString:@"batchOrder"]) {
        cell.lab3.text = @"批量订单";
    }else if ([model.orderType isEqualToString:@"afterSale"]) {
        cell.lab3.text = @"售后订单";
    }else if ([model.orderType isEqualToString:@"tradOrder"]) {
        cell.lab3.text = @"现货订单";
    }
    
    
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.lab4.text = @"待确认订单";
    }else if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab4.text = @"已确认订单";
    }else if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab4.text = @"生产中订单";
    }else if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab4.text = @"待发货订单";
    }else if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab4.text = @"已发货订单";
    }else if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab4.text = @"已取消订单";
    }
    
    
    [cell.kkfpbtn addTarget:self action:@selector(clickkkfpbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
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
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    
    [session POST:KURLNSString2(@"servlet", @"invoice",@"apply",@"order")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                                        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            kkfpmodel *model = [kkfpmodel mj_objectWithKeyValues:dict];
            
            //            jxs1model *model1 = [jxs1model mj_objectWithKeyValues:model.dealerInfo];
            //            model.dealerInfomodel = model1;
            
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
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    
    [session POST:KURLNSString2(@"servlet", @"invoice",@"apply",@"order") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            kkfpmodel *model = [kkfpmodel mj_objectWithKeyValues:dict];
            
//            jxs1model *model1 = [jxs1model mj_objectWithKeyValues:model.dealerInfo];
//            model.dealerInfomodel = model1;
            
            [weakSelf.dataArray addObject:model];
        }
        
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}



- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end
