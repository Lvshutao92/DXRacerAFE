//
//  JXS_1_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_1_ViewController.h"

#import "JXS_Add_ViewController.h"

#import "JXS_1_Cell.h"
#import "jxs1model.h"

#import "model1.h"
#import "model2.h"
#import "model3.h"
#import "model4.h"
#import "model5.h"

#import "COMdViewController.h"



#import "Pay_One_model.h"
#import "paymodel.h"
@interface JXS_1_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableview;
@end

@implementation JXS_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"JXS_1_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
- (void)clickadd{
    JXS_Add_ViewController *jxs_add = [[JXS_Add_ViewController alloc]init];
    jxs_add.navigationItem.title = @"新增";
    jxs_add.str1 = nil;
    jxs_add.str2 = nil;
    [self.navigationController pushViewController:jxs_add animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 385;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    JXS_1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[JXS_1_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.companyCode;
    cell.lab2.text = model.companyName;
    cell.lab3.text = model.model1.chineseName;
    cell.lab4.text = model.model2.chineseName;
    
    cell.lab5.text = model.model3.currencyCode;
    
    
    
    if ([model.status isEqualToString:@"created"]) {
        cell.lab6.text = @"新建";
        cell.lab6.textColor = RGBACOLOR(32, 157, 149, 1.0);
        
        [cell.auditbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.auditbtn addTarget:self action:@selector(clickaudit:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.stopbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [cell.delebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.delebtn  addTarget:self action:@selector(clickdele:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([model.status isEqualToString:@"cooperate"]) {
        cell.lab6.text = @"正常";
        cell.lab6.textColor = [UIColor greenColor];
        
        [cell.auditbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [cell.stopbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.stopbtn  addTarget:self action:@selector(clickstop:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.delebtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else if ([model.status isEqualToString:@"stop"]) {
        cell.lab6.text = @"停用";
        cell.lab6.textColor = [UIColor redColor];
        
        
        [cell.auditbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.auditbtn addTarget:self action:@selector(clickaudit:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.stopbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [cell.delebtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    
    
    cell.lab7.text = model.rememberCode;
    cell.lab8.text = model.website;
    cell.lab9.text = model.model5.nameCn;
    cell.lab10.text = model.model4.nameCn;
    cell.lab11.text = [Manager TimeCuoToTime:model.createTime];
    
    
    
    
     [cell.editbtn  addTarget:self action:@selector(clickedit:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
//    COMdViewController *details = [[COMdViewController alloc]init];
//    details.navigationItem.title = @"详情";
//    details.idstr = model.id;
    
    [Manager sharedManager].idstr = model.id;
    [self loddeListwww:model.id];
    
//    [self.navigationController pushViewController:details animated:YES];
}


- (void)loddeListwww:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":[Manager sharedManager].idstr,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer",@"manager",@"dealerpayment",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        [[Manager sharedManager].Array1 removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model1 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model1;
            
            [[Manager sharedManager].Array1 addObject:model];
        }
        
        COMdViewController *details = [[COMdViewController alloc]init];
        details.navigationItem.title = @"详情";
        details.idstr = str;
        [weakSelf.navigationController pushViewController:details animated:YES];
        
//        NSLog(@"*****%ld",[Manager sharedManager].Array1.count);
        
        //        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (void)clickdele:(UIButton *)sender{
    
    JXS_1_Cell *cell = (JXS_1_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    jxs1model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    if ([model.status isEqualToString:@"created"]) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString2(@"servlet", @"dealer", @"manager",@"dealerinfo/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"删除成功😊" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                    [weakSelf.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"删除失败😢" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            [weakSelf.tableview reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"删除失败,新建状态可删除" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (void)clickaudit:(UIButton *)sender{
    JXS_1_Cell *cell = (JXS_1_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    jxs1model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定审核吗？" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"id":model.id,
                @"status":@"cooperate",
                };
        [session POST:KURLNSString2(@"servlet", @"dealer", @"manager",@"dealerinfo/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"审核成功😊" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"审核失败😢" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            [weakSelf.tableview reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }];
    
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:quxiao];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)clickstop:(UIButton *)sender{
    JXS_1_Cell *cell = (JXS_1_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    jxs1model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定停用吗？" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"id":model.id,
                @"status":@"stop",
                };
        [session POST:KURLNSString2(@"servlet", @"dealer", @"manager",@"dealerinfo/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"停用成功😊" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"停用失败😢" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            [weakSelf.tableview reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }];
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:quxiao];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}










- (void)clickedit:(UIButton *)sender{
    JXS_1_Cell *cell = (JXS_1_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    jxs1model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    JXS_Add_ViewController *jxs_add = [[JXS_Add_ViewController alloc]init];
    jxs_add.navigationItem.title = @"编辑";
    jxs_add.idstr = model.id;
    
    
    jxs_add.str1 = model.companyCode;
    jxs_add.str2 = model.companyName;
    
    jxs_add.str3 = model.model1.chineseName;
    jxs_add.str3id = model.model1.id;
    
    jxs_add.str4 = model.model2.chineseName;
    jxs_add.str4id = model.model2.id;
    
    jxs_add.str5 = model.model3.currencyCode;
    jxs_add.str5id = model.model3.id;
    
    jxs_add.str6  = model.rememberCode;
    jxs_add.str7  = model.website;
    
    jxs_add.str8  = model.model5.nameCn;
    jxs_add.str8id = model.model5.id;
    
    jxs_add.str9  = model.model4.nameCn;
    jxs_add.str9id = model.model4.id;
    
    jxs_add.str10 = model.telephone;
    
    [self.navigationController pushViewController:jxs_add animated:YES];
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
    
    [session POST:KURLNSString3(@"servlet", @"dealer",@"manager",@"dealerinfo",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dict];
            
            model1 *model01 = [model1 mj_objectWithKeyValues:model.configArea];
            model.model1 = model01;
            
            model2 *model02 = [model2 mj_objectWithKeyValues:model.configCountry];
            model.model2 = model02;
            
            
            model3 *model03 = [model3 mj_objectWithKeyValues:model.configCurrency];
            model.model3 = model03;
            
            model4 *model04 = [model4 mj_objectWithKeyValues:model.configDuration];
            model.model4 = model04;
            
            model5 *model05 = [model5 mj_objectWithKeyValues:model.configScale];
            model.model5 = model05;
            
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
    
    [session POST:KURLNSString3(@"servlet", @"dealer",@"manager",@"dealerinfo",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dict];
            
            model1 *model01 = [model1 mj_objectWithKeyValues:model.configArea];
            model.model1 = model01;
            
            model2 *model02 = [model2 mj_objectWithKeyValues:model.configCountry];
            model.model2 = model02;
            
            
            model3 *model03 = [model3 mj_objectWithKeyValues:model.configCurrency];
            model.model3 = model03;
            
            model4 *model04 = [model4 mj_objectWithKeyValues:model.configDuration];
            model.model4 = model04;
            
            model5 *model05 = [model5 mj_objectWithKeyValues:model.configScale];
            model.model5 = model05;
            
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
