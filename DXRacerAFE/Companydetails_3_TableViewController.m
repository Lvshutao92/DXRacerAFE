//
//  Companydetails_3_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Companydetails_3_TableViewController.h"
#import "company_3_Cell.h"
#import "paymodel.h"
#import "Pay_Two_model.h"
#import "Pay_One_model.h"
@interface Companydetails_3_TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableView;

@end

@implementation Companydetails_3_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"company_3_Cell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"cell3";
    company_3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[company_3_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    paymodel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"公司名称：%@",model.dealerInfomodel.companyName];
    
    cell.lab2.text = [NSString stringWithFormat:@"货币类型：%@",model.configCurrencymodel.currencyCode];
    
    
    
    cell.lab3.text = [NSString stringWithFormat:@"开户银行：%@",model.bankName];
    
    
    
    cell.lab4.text = [NSString stringWithFormat:@"银行账户：%@",model.bankAccount];
    
    
    
    
    cell.lab5.text = [NSString stringWithFormat:@"银行账号：%@",model.bankNo];

    
    cell.lab6.text = [NSString stringWithFormat:@"SWIFT：%@",model.swift];
    
    return cell;
}


//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableView.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.idstr,
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    //    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerbank",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model1 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model1;
            
            
            Pay_Two_model *model2 = [Pay_Two_model mj_objectWithKeyValues:model.configCurrency];
            model.configCurrencymodel = model2;
            
            [weakSelf.dataArray addObject:model];
        }
        page=2;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableView.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.idstr,
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerbank",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model1 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model1;
            
            
            Pay_Two_model *model2 = [Pay_Two_model mj_objectWithKeyValues:model.configCurrency];
            model.configCurrencymodel = model2;
            
            [weakSelf.dataArray addObject:model];
        }
        
        
        page++;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}




















- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end
