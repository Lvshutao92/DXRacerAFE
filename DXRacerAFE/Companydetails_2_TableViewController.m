//
//  Companydetails_2_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Companydetails_2_TableViewController.h"
#import "company_2_Cell.h"
#import "DizhiModel.h"
@interface Companydetails_2_TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray2;


@property(nonatomic,strong)UITableView *tableView;

@end

@implementation Companydetails_2_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"company_2_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray2.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"cell2";
    company_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[company_2_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DizhiModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"公司名称：%@",model.company_name];
    
    cell.lab2.text = [NSString stringWithFormat:@"FCNO：%@",model.fcno];
    
    
    cell.lab3.textColor = [UIColor redColor];
    NSMutableAttributedString *notestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"销售价：%@",[Manager jinegeshi:model.unit_price]]];
    NSRange ran = NSMakeRange(0,4);
    [notestr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:ran];
    [cell.lab3 setAttributedText:notestr];
    

    
    if ([model.use_type isEqualToString:@"batchOrder"]) {
        cell.lab4.text = @"单据类型：批量订单";
    }else if ([model.use_type isEqualToString:@"afterSale"]) {
        cell.lab4.text = @"单据类型：售后订单";
    }else if ([model.use_type isEqualToString:@"tradOrder"]) {
        cell.lab4.text = @"单据类型：现货订单";
    }
    
    
    if ([model.dealer_use_status isEqualToString:@"A"]) {
        cell.lab5.text = @"状态：已申请";
    }else if ([model.dealer_use_status isEqualToString:@"Y"]) {
        cell.lab5.text = @"状态：已可买";
    }else if ([model.dealer_use_status isEqualToString:@"N"]) {
        cell.lab5.text = @"状态：已取消";
    }
    

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
        if (self.dataArray2.count == totalnum) {
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
    [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray2 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            DizhiModel *model = [DizhiModel mj_objectWithKeyValues:dict];
            
            
            
            [weakSelf.dataArray2 addObject:model];
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            DizhiModel *model = [DizhiModel mj_objectWithKeyValues:dict];
            
           
            
            [weakSelf.dataArray2 addObject:model];
        }
        
        
        page++;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}




















- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}


@end
