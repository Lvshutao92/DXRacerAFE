//
//  CP_1_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CP_1_ViewController.h"
#import "PL_03_Cell.h"
#import "cp1model.h"
#import "CP_search_one_ViewController.h"
@interface CP_1_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation CP_1_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"PL_03_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
        self.str6 = @"";
    }
    [self setUpReflash];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    CP_search_one_ViewController *search = [[CP_search_one_ViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 390;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    PL_03_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[PL_03_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.l1.text = @"英文名";
//    cell.l2.text = @"中文名";
//    cell.l3.text = @"包装尺寸(cm)";
//    cell.l4.text = @"重量(kg)";
//    cell.l5.text = @"商品状态";
    cp1model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.imageUrl)] placeholderImage:[UIImage imageNamed:@"bgview"]];
    
    cell.lab1.text = model.fcno;
    cell.lab2.text = model.itemno;
    cell.lab3.text = model.model;
    
    cell.lab4.text = model.fcnoNameEnglish;
    
    cell.lab5.text = model.fcnoNameChinese;
    
    cell.lab6.text = [NSString stringWithFormat:@"%@*%@*%@",model.packageLength,model.packageWidth,model.packageHeight];
    cell.lab7.text = model.packageWeight;
    
    
    if ([model.status isEqualToString:@"publish"]) {
         cell.lab8.text = @"已上架";
    }else if ([model.status isEqualToString:@"unpublish"]) {
         cell.lab8.text = @"未上架";
    }else if ([model.status isEqualToString:@"disabled"]) {
         cell.lab8.text = @"已停用";
    }
    
    
    cell.lab9.text = model.hsCode;
    
    
    
    
    
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
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            
            @"model":self.str1,
            @"itemno":self.str2,
            @"fcno":self.str3,
            @"status":self.str4,
            @"fcnoNameEnglish":self.str5,
            @"fcnoNameChinese":self.str6,
            };

    [session POST:KURLNSString2(@"servlet", @"batch", @"goods",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            cp1model *model = [cp1model mj_objectWithKeyValues:dict];
            
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
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            
            @"model":self.str1,
            @"itemno":self.str2,
            @"fcno":self.str3,
            @"status":self.str4,
            @"fcnoNameEnglish":self.str5,
            @"fcnoNameChinese":self.str6,
            };
    
    [session POST:KURLNSString2(@"servlet", @"batch", @"goods",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"+++%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            cp1model *model = [cp1model mj_objectWithKeyValues:dict];
            
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
