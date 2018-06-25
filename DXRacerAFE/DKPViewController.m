//
//  DKPViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "DKPViewController.h"
#import "DKP_Cell.h"
#import "WDFPModel.h"
#import "Ordermodel.h"
#import "FP_details_TableViewController.h"
#import "DKP_KPXX_ViewController.h"


@interface DKPViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation DKPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"DKP_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 335;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    DKP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DKP_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailsbtn.layer.borderWidth = 1;
    cell.detailsbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.detailsbtn.layer.masksToBounds = YES;
    cell.detailsbtn.layer.cornerRadius = 5;
    
    cell.kpxxbtn.layer.borderWidth = 1;
    cell.kpxxbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.kpxxbtn.layer.masksToBounds = YES;
    cell.kpxxbtn.layer.cornerRadius = 5;
    
    WDFPModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.ordermodel.orderNo;
    
    cell.lab2.text = [Manager jinegeshi:model.totalFee];
    
    cell.lab3.text = model.invoiceType;
    cell.lab4.text = model.title;
    cell.lab5.text = model.code;
    cell.lab6.text = model.address;
    cell.lab7.text = model.telephone;
    
    
    cell.lab8.text = model.bankName;
    cell.lab9.text = model.bankNo;
    
    [cell.kpxxbtn addTarget:self action:@selector(clickselected:) forControlEvents:UIControlEventTouchUpInside];
    [cell.detailsbtn addTarget:self action:@selector(clickdetails:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)clickselected:(UIButton *)sender{
    DKP_Cell *cell = (DKP_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    WDFPModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    DKP_KPXX_ViewController *addr = [[DKP_KPXX_ViewController alloc]init];
    addr.navigationItem.title = @"填写开票信息";
    addr.strid = model.id;
    
    addr.str1 = model.title;
    addr.str2 = [Manager jinegeshi:model.totalFee];
    [self.navigationController pushViewController:addr animated:YES];
    
}
- (void)clickdetails:(UIButton *)sender{
    DKP_Cell *cell = (DKP_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    WDFPModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    FP_details_TableViewController *details = [[FP_details_TableViewController alloc]init];
    details.navigationItem.title = @"发票详情";
    details.orderId = model.orderId;
    details.str1  = model.invoiceNo;
    details.str2  = model.ordermodel.orderNo;
    details.str3  = [Manager jinegeshi:model.totalFee];
    details.str4  = model.invoiceType;
    details.str5  = model.title;
    details.str6  = model.invoiceCode;
    
    details.str7  = model.invoiceNumber;
    
    
    if (model.receivePerson == nil) {
        model.receivePerson = @"";
    }
    if (model.phone == nil) {
        model.phone = @"";
    }
    details.str8  = [NSString stringWithFormat:@"%@ %@",model.receivePerson,model.phone];
    
    details.str9  = model.address;
    details.str10 = model.logisticName;
    details.str11 = model.logisticsNo;
    
    
    if ([model.invoiceStatus isEqualToString:@"apply"]) {
        details.str12 = @"已申请";
        
    }else if ([model.invoiceStatus isEqualToString:@"confirm"]) {
        details.str12 = @"待寄票";
        
    }else if ([model.invoiceStatus isEqualToString:@"finish"]) {
        details.str12 = @"已寄票";
        
    }
    
    
    [self.navigationController pushViewController:details animated:YES];
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
            @"invoiceStatus":@"apply",
            };
    
    [session POST:KURLNSString2(@"servlet", @"invoice",@"manager",@"list")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            WDFPModel *model = [WDFPModel mj_objectWithKeyValues:dict];
            
            Ordermodel *model1 = [Ordermodel mj_objectWithKeyValues:model.order];
            model.ordermodel = model1;
            
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
            @"invoiceStatus":@"apply",
            };
    
    [session POST:KURLNSString2(@"servlet", @"invoice",@"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            WDFPModel *model = [WDFPModel mj_objectWithKeyValues:dict];
            
            Ordermodel *model1 = [Ordermodel mj_objectWithKeyValues:model.order];
            model.ordermodel = model1;
            
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
