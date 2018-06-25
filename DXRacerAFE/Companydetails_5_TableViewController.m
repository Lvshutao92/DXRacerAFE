//
//  Companydetails_5_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Companydetails_5_TableViewController.h"
#import "company_4_Cell.h"

#import "Conaddrmodel.h"
#import "paymodel.h"
#import "configArea_Model.h"
#import "configCountry_Model.h"
#import "Pay_One_model.h"

@interface Companydetails_5_TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableView;

@end

@implementation Companydetails_5_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"company_4_Cell" bundle:nil] forCellReuseIdentifier:@"cell5"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 305;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"cell5";
    company_4_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[company_4_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    paymodel *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.lab1.text = [NSString stringWithFormat:@"公司名称：%@",model.dealerInfomodel.companyName];

    cell.lab2.text = [NSString stringWithFormat:@"地址类型：%@",model.configAddrTypemodel.typeCn];
    
    cell.lab3.text = [NSString stringWithFormat:@"地区：%@",model.dealerInfomodel.configAreamodel.chineseName];
    
    cell.lab4.text = [NSString stringWithFormat:@"国家：%@",model.dealerInfomodel.configCountrymodel.chineseName];
    
    cell.lab5.text = [NSString stringWithFormat:@"省份：%@",model.receiveProvince];
    
    cell.lab6.text = [NSString stringWithFormat:@"城市：%@",model.receiveCity];
    
    
    cell.lab7.text = [NSString stringWithFormat:@"区县：%@",model.receiveArea];
    
    
    cell.lab8.text = [NSString stringWithFormat:@"地址：%@",model.receiveAddress];
    
    cell.lab9.text = [NSString stringWithFormat:@"邮编：%@",model.zip];
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
//        NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model2 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
            
            Conaddrmodel *model5 = [Conaddrmodel mj_objectWithKeyValues:model.configAddrType];
            model.configAddrTypemodel = model5;
            
            
            configArea_Model *model1 = [configArea_Model mj_objectWithKeyValues:model.dealerInfomodel.configArea];
            model.dealerInfomodel.configAreamodel = model1;
            
            configCountry_Model *model3 = [configCountry_Model mj_objectWithKeyValues:model.dealerInfomodel.configCountry];
            model.dealerInfomodel.configCountrymodel = model3;
            
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model2 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
            configArea_Model *model1 = [configArea_Model mj_objectWithKeyValues:model.dealerInfomodel.configArea];
            model.dealerInfomodel.configAreamodel = model1;
            
            Conaddrmodel *model5 = [Conaddrmodel mj_objectWithKeyValues:model.configAddrType];
            model.configAddrTypemodel = model5;
            
            configCountry_Model *model3 = [configCountry_Model mj_objectWithKeyValues:model.dealerInfomodel.configCountry];
            model.dealerInfomodel.configCountrymodel = model3;
            
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
