//
//  SK3ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SK3ViewController.h"
#import "SK3Cell.h"
#import "LookPictureViewController.h"
#import "Sk3Model.h"
#import "Moneysinemodel.h"
#import "SK2_details_TableViewController.h"
#import "SK_search_threeViewController.h"
@interface SK3ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation SK3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"SK3Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    if (self.str1.length == 0) {
        self.str1 = @"";
    }
    if (self.str2.length == 0) {
        self.str2 = @"";
    }
    if (self.str3.length == 0) {
        self.str3 = @"";
    }
    if (self.str4.length == 0) {
        self.str4 = @"";
    }
    [self setUpReflash];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SK_search_threeViewController *search = [[SK_search_threeViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 410;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    SK3Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SK3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Sk3Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = model.paymentNo;
    cell.lab2.text = [Manager jinegeshi:model.totalFee];
    cell.lab3.text = [Manager jinegeshi:model.paidFee];
    
    if ([model.totalFee isEqualToString:model.paidFee]) {
        cell.lab3.textColor =[UIColor blackColor];
    }else{
        cell.lab3.textColor =[UIColor redColor];
    }
    
    
    
    if ([model.totalFee floatValue]-[model.paidFee floatValue] == 0) {
        cell.lab4.textColor = [UIColor blackColor];
    }else{
        cell.lab4.textColor = [UIColor redColor];
    }
    cell.lab4.text = [Manager jinegeshi:[NSString stringWithFormat:@"%.02f",[model.totalFee floatValue]-[model.paidFee floatValue]]];
    
    
    if ([model.paymentType isEqualToString:@"Deposit"]) {
        cell.lab5.text = @"定金";
    }else if ([model.paymentType isEqualToString:@"Retainage"]) {
        cell.lab5.text = @"尾款";
    }
    
    
    
    if ([model.paymentStatus isEqualToString:@"create"]) {
        cell.lab6.text = @"创建成功";
    }else if ([model.paymentStatus isEqualToString:@"confirm"]) {
        cell.lab6.text = @"确认支付";
    }else if ([model.paymentStatus isEqualToString:@"paysuccess"]) {
        cell.lab6.text = @"支付成功";
    }else if ([model.paymentStatus isEqualToString:@"payfail"]) {
        cell.lab6.text = @"支付失败";
    }else if ([model.paymentStatus isEqualToString:@"canceled"]) {
        cell.lab6.text = @"取消成功";
    }
    
    
    if (model.receiptCompanyName == nil) {
        model.receiptCompanyName = @"";
    }
    if (model.receiptBankName == nil) {
        model.receiptBankName = @"";
    }
    if (model.receiptBankNo == nil) {
        model.receiptBankNo = @"";
    }
    cell.lab7.text = [NSString stringWithFormat:@"%@ %@ %@",model.receiptCompanyName,model.receiptBankName,model.receiptBankNo];
    
    
    
    if (model.paymentCompanyName == nil) {
        model.paymentCompanyName = @"";
    }
    if (model.paymentBankName == nil) {
        model.paymentBankName = @"";
    }
    if (model.paymentBankNo == nil) {
        model.paymentBankNo = @"";
    }
    cell.lab8.text = [NSString stringWithFormat:@"%@ %@ %@",model.paymentCompanyName,model.paymentBankName,model.paymentBankNo];
    cell.lab9.text = model.transactionNo;
    
    
    
    
    
    if (model.paymentVoucher == nil) {
        [cell.look1btn setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [cell.look1btn setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.look1btn addTarget:self action:@selector(look1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (model.receiptVoucher == nil) {
        [cell.look2btn setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [cell.look2btn setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.look2btn addTarget:self action:@selector(look2:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    
    if (![model.paymentStatus isEqualToString:@"paysuccess"]) {
        cell.lab10.text = @"-";
    }else{
        if (model.field6 == nil) {
            cell.lab10.text = @"-";
        }else{
            
            cell.lab10.text = [NSString stringWithFormat:@"%@%.02f",model.model1.field1,[model.paidFee floatValue]*[model.field6 floatValue]];
        }
    }
    
    
    
    if (model.field6 != nil) {
        cell.lab11.text = model.field6;
    }else{
        cell.lab11.text = @"-";
    }
    
    
    return cell;
}

- (void)look1:(UIButton *)sender{
    SK3Cell *cell = (SK3Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Sk3Model *model = [self.dataArray objectAtIndex:indexpath.row];
    if (model.paymentVoucher != nil) {
        LookPictureViewController *look = [[LookPictureViewController alloc]init];
        look.imgStr = model.paymentVoucher;
        [self.navigationController pushViewController:look animated:YES];
    }
    
}
- (void)look2:(UIButton *)sender{
    SK3Cell *cell = (SK3Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Sk3Model *model = [self.dataArray objectAtIndex:indexpath.row];
    if (model.receiptVoucher != nil) {
        LookPictureViewController *look = [[LookPictureViewController alloc]init];
        look.imgStr = model.receiptVoucher;
        [self.navigationController pushViewController:look animated:YES];
    }
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Sk3Model *model = [self.dataArray objectAtIndex:indexPath.row];
    SK2_details_TableViewController *commit = [[SK2_details_TableViewController alloc]init];
    commit.navigationItem.title = @"详情";
    
    commit.strid = model.id;
    
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
            @"paymentNo":self.str1,
            @"paymentType":self.str2,
            @"paymentStatus":self.str3,
            @"dealerId":self.str4,
            };

    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"dic = %@",dic);
                totalnum = [[dic objectForKey:@"total"] integerValue];
                [weakSelf.dataArray removeAllObjects];
        
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
                for (NSDictionary *dic in arr) {
                    Sk3Model *model = [Sk3Model mj_objectWithKeyValues:dic];
        
                    Moneysinemodel *model1 = [Moneysinemodel mj_objectWithKeyValues:model.configCurrency];
                    model.model1 = model1;
        
        
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
            
            @"paymentNo":self.str1,
            @"paymentType":self.str2,
            @"paymentStatus":self.str3,
            @"dealerId":self.str4,
            };
    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            Sk3Model *model = [Sk3Model mj_objectWithKeyValues:dic];
            Moneysinemodel *model1 = [Moneysinemodel mj_objectWithKeyValues:model.configCurrency];
            model.model1 = model1;
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
