//
//  CHQD_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/9.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CHQD_ViewController.h"
#import "CHQD_Cell.h"
#import "CHGL_Model.h"
#import "XHQD_Lookdetails_TableViewController.h"
#import "CHGL_search_ViewController.h"
@interface CHQD_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation CHQD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"CHQD_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    
    if (self.str4.length == 0) {
        self.str4 = @"";
    }
    if (self.str5.length == 0) {
        self.str5 = @"";
    }
    
    [self setUpReflash];
    
    // Do any additional setup after loading the view.
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    CHGL_search_ViewController *search = [[CHGL_search_ViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 271;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    CHQD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[CHQD_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailsbtn.layer.borderWidth = 1;
    cell.detailsbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.detailsbtn.layer.masksToBounds = YES;
    cell.detailsbtn.layer.cornerRadius = 5;
    
    cell.cancle.layer.borderWidth = 1;
    cell.cancle.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cancle.layer.masksToBounds = YES;
    cell.cancle.layer.cornerRadius = 5;
    
    [cell.detailsbtn addTarget:self action:@selector(clickdetailsbtn:) forControlEvents:UIControlEventTouchUpInside];
    CHGL_Model *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.lab1.text = model.shipmentNo;
    cell.lab2.text = model.planShipmentDate;
    cell.lsb3.text = model.actualDate;
    cell.lab4.text = model.logistics;
    cell.lab5.text = model.field1;
    cell.lab6.text = model.address;
    
    if ([model.status isEqualToString:@"create"]) {
        cell.lab7.text = @"已申请";
        cell.cancle.hidden = NO;
        cell.lab7.textColor = [UIColor redColor];
    }else if ([model.status isEqualToString:@"pending"]){
        cell.lab7.text = @"待出货";
        cell.cancle.hidden = YES;
        cell.lab7.textColor = [UIColor magentaColor];
    }else if ([model.status isEqualToString:@"finish"]){
        cell.lab7.text = @"已完成";
        cell.lab7.textColor = [UIColor blueColor];
        cell.cancle.hidden = YES;
    }
    [cell.cancle addTarget:self action:@selector(clickcancle:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)clickcancle:(UIButton *)sender{
    CHQD_Cell *cell = (CHQD_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    CHGL_Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString2(@"servlet", @"shipment", @"zh_cn",@"all/detail/cancel") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"取消申请成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"取消申请失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}



- (void)clickdetailsbtn:(UIButton *)sender{
    CHQD_Cell *cell = (CHQD_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    CHGL_Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    XHQD_Lookdetails_TableViewController *details = [[XHQD_Lookdetails_TableViewController alloc]init];
    details.navigationItem.title = @"详情";
    details.orderId = model.id;
    details.str1 = model.shipmentNo;
    if ([model.status isEqualToString:@"create"]) {
        details.str2 = @"已申请";
    }else if ([model.status isEqualToString:@"pending"]){
        details.str2 = @"待出货";
    }else if ([model.status isEqualToString:@"finish"]){
        details.str2 = @"已完成";
    }
    
    details.string1 = model.address;
    details.string2 = model.logistics;
    details.string3 = model.field1;
    details.string4 = model.planShipmentDate;
    
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
            
            @"shipmentNo":self.str1,
            @"planShipmentDate":self.str4,
            @"status":self.str5,
            };
    

    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"shipment/zh_cn",@"all",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        //NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            CHGL_Model *model = [CHGL_Model mj_objectWithKeyValues:dict];
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
            
            @"shipmentNo":self.str1,
            @"planShipmentDate":self.str4,
            @"status":self.str5,

            };
    [session POST:KURLNSString2(@"servlet", @"shipment/zh_cn",@"all",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            CHGL_Model *model = [CHGL_Model mj_objectWithKeyValues:dict];
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
