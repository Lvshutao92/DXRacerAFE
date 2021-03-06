//
//  JC_6_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JC_6_ViewController.h"
#import "JC_6_Cell.h"
#import "JC_6_Model.h"
#import "JC_06_Model.h"
#import "JC6_add_edit_ViewController.h"

@interface JC_6_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@end

@implementation JC_6_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"JC_6_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
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
    return 170;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JC_6_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JC_6_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.portNameCn;
    cell.lab2.text = model.portNameEn;
    
    cell.lab3.text = model.jcmodel.chineseName;
    cell.lab4.text = model.jcmodel.englishName;
    
    
    if ([model.status isEqualToString:@"Y"]) {
        cell.lab5.text = @"启用";
    }else{
        cell.lab5.text = @"禁用";
    }
    
    
    return cell;
}





- (void)clickadd{
    JC6_add_edit_ViewController *jxs_add = [[JC6_add_edit_ViewController alloc]init];
    jxs_add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:jxs_add animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *suer = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull sure, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JC_6_Model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        JC6_add_edit_ViewController *jxs_add = [[JC6_add_edit_ViewController alloc]init];
        jxs_add.navigationItem.title = @"编辑";
        
        jxs_add.strid = model.id;
        
        jxs_add.str2   = model.portNameCn;
        jxs_add.str1   = model.portNameEn;
        
        jxs_add.str3   = model.portNameCn;
        jxs_add.str3id = model.jcmodel.areaId;
        
        if ([model.status isEqualToString:@"Y"]) {
            jxs_add.str4 = @"启用";
            jxs_add.str4id = @"Y";
        }else{
            jxs_add.str4 = @"禁用";
            jxs_add.str4id = @"N";
        }
        
        [self.navigationController pushViewController:jxs_add animated:YES];
        
    }];
    suer.backgroundColor = RGBACOLOR(254, 91, 91, 1.0);
    
    
    UITableViewRowAction *deleate = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull kaipiao, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JC_6_Model *model = [self.dataArray objectAtIndex:indexPath.row];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除？删除后无法恢复" preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self lodDelete:model.id IndexPath:indexPath];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    deleate.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    return @[suer,deleate];
}


- (void)lodDelete:(NSString *)idStr IndexPath:(NSIndexPath *)IndexPath{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"id":idStr,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configport", @"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.dataArray removeObjectAtIndex:IndexPath.row];
                [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:IndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:IndexPath.row inSection:IndexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableview reloadData];
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
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configport", @"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        //NSLog(@"---%@",dic);
        
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *array = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *temp in array) {
            JC_6_Model *model = [JC_6_Model mj_objectWithKeyValues:temp];
            
            JC_06_Model *addressmodel = [JC_06_Model mj_objectWithKeyValues:model.configCountry];
            model.jcmodel = addressmodel;
            
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
    
    [session POST:KURLNSString2(@"servlet", @"config", @"configport", @"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);
        
        NSMutableArray *array = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *temp in array) {
            JC_6_Model *model = [JC_6_Model mj_objectWithKeyValues:temp];
            
            JC_06_Model *addressmodel = [JC_06_Model mj_objectWithKeyValues:model.configCountry];
            model.jcmodel = addressmodel;
            
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
