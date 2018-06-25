//
//  Companydetails_4_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Companydetails_4_TableViewController.h"
#import "company_4_Cell.h"
#import "paymodel.h"
#import "ConfigDutyModel.h"
#import "Pay_One_model.h"
@interface Companydetails_4_TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableView;
@end

@implementation Companydetails_4_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"company_4_Cell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"cell4";
    company_4_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[company_4_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab9.hidden = YES;
    paymodel *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.lab1.text = [NSString stringWithFormat:@"公司名称：%@",model.dealerInfomodel.companyName];

    cell.lab2.text = [NSString stringWithFormat:@"联系人姓名：%@",model.person];
    
    cell.lab3.text = [NSString stringWithFormat:@"联系人职务：%@",model.configDutymodel.chineseName];
    
    cell.lab4.text = [NSString stringWithFormat:@"QQ：%@",model.qq];
   
    cell.lab5.text = [NSString stringWithFormat:@"Skype：%@",model.wechat];
   
    cell.lab6.text = [NSString stringWithFormat:@"固定电话：%@",model.telephone];
    
    if (model.mobile == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"移动电话：%@",model.mobile];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"移动电话：-"];
    }
    
    
    cell.lab8.text = [NSString stringWithFormat:@"电子邮箱：%@",model.email];

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
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealercontact",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            ConfigDutyModel *model1 = [ConfigDutyModel mj_objectWithKeyValues:model.configDuty];
            model.configDutymodel = model1;
            
            Pay_One_model *model2 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealercontact",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            ConfigDutyModel *model1 = [ConfigDutyModel mj_objectWithKeyValues:model.configDuty];
            model.configDutymodel = model1;
            
            
            Pay_One_model *model2 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
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
