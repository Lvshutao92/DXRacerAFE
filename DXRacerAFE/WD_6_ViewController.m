//
//  WD_6_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WD_6_ViewController.h"
#import "WD_6_Cell.h"
#import "Wd_6_model.h"
#import "Wd6_con_model.h"
#import "WD_6_add_edit_ViewController.h"
@interface WD_6_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation WD_6_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WD_6_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    button.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [button setTitle:@"新增" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
    
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    WD_6_Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[WD_6_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell.editbtn addTarget:self action:@selector(clickedit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delebtn addTarget:self action:@selector(clickdele:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.editbtn.layer.borderWidth = 1;
    cell.editbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.editbtn.layer.masksToBounds = YES;
    cell.editbtn.layer.cornerRadius = 5;
    
    cell.delebtn.layer.borderWidth = 1;
    cell.delebtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.delebtn.layer.masksToBounds = YES;
    cell.delebtn.layer.cornerRadius = 5;
    
    Wd_6_model *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.lab1.text = model.model1.currencyCode;
    
    
    
    cell.lab2.text = model.bankName;
    cell.lab3.text = model.bankAccount;
    cell.lab4.text = model.bankNo;
    cell.lab5.text = model.swift;
    
    return cell;
}

- (void)clickedit:(UIButton *)sender{
    WD_6_Cell *cell = (WD_6_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Wd_6_model *model = [self.dataArray objectAtIndex:indexpath.row];
    WD_6_add_edit_ViewController *edit = [[WD_6_add_edit_ViewController alloc]init];
    edit.navigationItem.title = @"编辑";
    edit.strid = model.id;
    
    edit.str1 = model.model1.currencyCode;
    edit.str2id = model.model1.id;
    
    
    edit.str2 = model.bankName;
    edit.str3 = model.bankAccount;
    edit.str4 = model.bankNo;
    edit.str5 = model.swift;
   
    [self.navigationController pushViewController:edit animated:YES];
}
- (void)clickadd{
    WD_6_add_edit_ViewController *add = [[WD_6_add_edit_ViewController alloc]init];
    add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
}



- (void)clickdele:(UIButton *)sender{
    WD_6_Cell *cell = (WD_6_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Wd_6_model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerbank",@"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"----%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                //删除
                [self.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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
            };
    
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine", @"dealerbank",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//                NSLog(@"dic = %@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            Wd_6_model *model = [Wd_6_model mj_objectWithKeyValues:dic];
            
            Wd6_con_model *model1 = [Wd6_con_model mj_objectWithKeyValues:model.configCurrency];
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
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine", @"dealerbank",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            Wd_6_model *model = [Wd_6_model mj_objectWithKeyValues:dic];
            Wd6_con_model *model1 = [Wd6_con_model mj_objectWithKeyValues:model.configCurrency];
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
