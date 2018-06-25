//
//  JXS_12_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_12_ViewController.h"
#import "JXS_12_Cell.h"
#import "jxs1model.h"
#import "systemRoleModel.h"
#import "JXS_12_model.h"
#import "JXS_12_add_edit_ViewController.h"
@interface JXS_12_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation JXS_12_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"JXS_12_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    return 240;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    JXS_12_Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[JXS_12_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.editbtn.layer.borderWidth = 1;
    cell.editbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.editbtn.layer.masksToBounds = YES;
    cell.editbtn.layer.cornerRadius = 5;
    JXS_12_model *model = [self.dataArray objectAtIndex:indexPath.row];
   
    cell.lab1.text = model.username;
    
    cell.lab2.text = model.rolemodel.roleName;
    
    cell.lab3.text = model.dealerInfomodel.companyName;
    
    cell.lab4.text = model.password;
    if ([model.status isEqualToString:@"Y"]) {
        cell.lab5.text = @"正常";
    }else if ([model.status isEqualToString:@"N"]) {
        cell.lab5.text = @"停用";
    }
    
    cell.lab6.text = model.businessId;
    
    
    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)clickadd{
    JXS_12_add_edit_ViewController *add = [[JXS_12_add_edit_ViewController alloc]init];
    add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
}

- (void)clickeditbtn:(UIButton *)sender{
    JXS_12_Cell *cell = (JXS_12_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    JXS_12_model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    JXS_12_add_edit_ViewController *edit = [[JXS_12_add_edit_ViewController alloc]init];
    edit.navigationItem.title = @"编辑";
    edit.idstr = model.id;

    edit.str1   = model.username;
    edit.str2   = model.rolemodel.roleName;
    edit.str3   = model.dealerInfomodel.companyName;
    edit.str4   = model.password;
    edit.str5   = model.status;
    
    edit.roleid      = model.rolemodel.id;
    edit.companyid   = model.id;

    [self.navigationController pushViewController:edit animated:YES];
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager", @"dealeruser",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//                                        NSLog(@"dic = %@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            JXS_12_model *model = [JXS_12_model mj_objectWithKeyValues:dic];
            
            systemRoleModel *model1 = [systemRoleModel mj_objectWithKeyValues:model.systemRole];
            model.rolemodel = model1;
            
            jxs1model *model2 = [jxs1model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
            
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
    [session POST:KURLNSString3(@"servlet", @"dealer", @"manager", @"dealeruser",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            JXS_12_model *model = [JXS_12_model mj_objectWithKeyValues:dic];
            
            systemRoleModel *model1 = [systemRoleModel mj_objectWithKeyValues:model.systemRole];
            model.rolemodel = model1;
            
            jxs1model *model2 = [jxs1model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
            
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
