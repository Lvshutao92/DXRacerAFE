//
//  SK1ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SK1ViewController.h"
#import "SK1Cell.h"
#import "SK1Model.h"
#import "SK_search_one_ViewController.h"
@interface SK1ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation SK1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"SK1Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    if (self.str5.length == 0) {
        self.str5 = @"";
    }
    if (self.str6.length == 0) {
        self.str6 = @"confirmed,production,undelivery,delivery";
    }
    [self loddeList];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SK_search_one_ViewController *search = [[SK_search_one_ViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    SK1Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SK1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SK1Model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text  = model.order_no;
    
    cell.lab2.text  = model.company_name;
    cell.lab3.text  = [Manager jinegeshi:model.total_fee];
    
    if ([model.order_status isEqualToString:@"confirm"]) {
        cell.lab4.text  = @"待确认订单";
    }else if ([model.order_status isEqualToString:@"confirmed"]) {
        cell.lab4.text  = @"已确认订单";
    }else if ([model.order_status isEqualToString:@"production"]) {
        cell.lab4.text  = @"生产中订单";
    }else if ([model.order_status isEqualToString:@"undelivery"]) {
        cell.lab4.text  = @"待发货订单";
    }else if ([model.order_status isEqualToString:@"delivery"]) {
        cell.lab4.text  = @"已发货订单";
    }else if ([model.order_status isEqualToString:@"cancel"]) {
        cell.lab4.text  = @"已取消订单";
    }
    
    if (model.estimated_date != nil) {
        cell.lab5.text  = [Manager TimeCuoToTime:model.estimated_date];
    }else{
        cell.lab5.text  = @"-";
    }
    
    return cell;
}




- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            
            @"orderNo":self.str1,
            @"startDate":self.str2,
            @"endDate":self.str3,
            @"dealerIds":self.str4,
            @"currencyId":self.str5,
            @"orderStatuss":self.str6,
            };
    //NSLog(@"dic = %@",dic);
    [session POST:KURLNSString3(@"servlet", @"receivables", @"manager",@"order",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"dic = %@",dic);
                [weakSelf.dataArray removeAllObjects];
        
                NSMutableArray *arr = (NSMutableArray *)dic;
        
                for (NSDictionary *dic in arr) {
                    SK1Model *model = [SK1Model mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray addObject:model];
                }
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end
