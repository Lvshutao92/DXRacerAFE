//
//  ZY_3_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "ZY_3_ViewController.h"
#import "GongxiangCenterCell.h"
#import "ZY3model.h"
#import "WebViewController.h"
@interface ZY_3_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation ZY_3_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"GongxiangCenterCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    GongxiangCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[GongxiangCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    ZY3model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.lab1.text = model.filename;
    [cell.lookbtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.lab2.text = model.uploaduser;
    cell.lab3.text = [Manager TimeCuoToTimes:model.createTime];
    return cell;
}


- (void)clickbtn:(UIButton *)sender{
    GongxiangCenterCell *cell = (GongxiangCenterCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ZY3model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    WebViewController *web = [[WebViewController alloc]init];
    web.navigationItem.title = @"文件详情";
    web.webStr = model.filepath;
    web.str = @"wenjian";
    [self.navigationController pushViewController:web animated:YES];
    
    
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
            };
    
    [session POST:KURLNSString1(@"servlet", @"uploadfile",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"dic = %@",dic);
                totalnum = [[dic objectForKey:@"total"] integerValue];
                [weakSelf.dataArray removeAllObjects];
        
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
                for (NSDictionary *dic in arr) {
                    ZY3model *model = [ZY3model mj_objectWithKeyValues:dic];
        
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
            };
    [session POST:KURLNSString1(@"servlet", @"uploadfile",@"list")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
                for (NSDictionary *dic in arr) {
                    ZY3model *model = [ZY3model mj_objectWithKeyValues:dic];
        
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