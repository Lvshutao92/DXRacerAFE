//
//  JXS_6_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_6_ViewController.h"
#import "JXS_6_Cell.h"

#import "Conaddrmodel.h"
#import "paymodel.h"
#import "configArea_Model.h"
#import "configCountry_Model.h"
#import "Pay_One_model.h"
#import "JXS_6_Add_Edit_ViewController.h"
@interface JXS_6_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation JXS_6_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"JXS_6_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
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
    return 330;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    JXS_6_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[JXS_6_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    paymodel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.dealerInfomodel.companyName];
    
    cell.lab2.text = [NSString stringWithFormat:@"%@",model.configAddrTypemodel.typeCn];
    
    cell.lab3.text = [NSString stringWithFormat:@"%@",model.dealerInfomodel.configAreamodel.chineseName];
    
    cell.lab4.text = [NSString stringWithFormat:@"%@",model.dealerInfomodel.configCountrymodel.chineseName];
    
    cell.lab5.text = [NSString stringWithFormat:@"%@",model.receiveProvince];
    
    cell.lab6.text = [NSString stringWithFormat:@"%@",model.receiveCity];
    
    
    cell.lab7.text = [NSString stringWithFormat:@"%@",model.receiveArea];
    
    
    cell.lab8.text = [NSString stringWithFormat:@"%@",model.receiveAddress];
    
    cell.lab9.text = [NSString stringWithFormat:@"%@",model.zip];
    
    
    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delebtn addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)clickadd{
    JXS_6_Add_Edit_ViewController *add = [[JXS_6_Add_Edit_ViewController alloc]init];
    add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
}


- (void)clickeditbtn:(UIButton *)sender{
    JXS_6_Cell *cell = (JXS_6_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    paymodel *model = [self.dataArray objectAtIndex:indexpath.row];

    JXS_6_Add_Edit_ViewController *edit = [[JXS_6_Add_Edit_ViewController alloc]init];
    edit.navigationItem.title = @"编辑";
    edit.idstr = model.id;

    edit.str1   = model.dealerInfomodel.companyName;
    edit.str1id = model.dealerId;
    
    edit.str2   = model.configAddrTypemodel.typeCn;
    edit.str2id = model.configAddrTypemodel.id;
    
    edit.str3   = model.dealerInfomodel.configAreamodel.chineseName;
    edit.str3id = model.dealerInfomodel.configAreamodel.id;
    
    edit.str4   = model.dealerInfomodel.configCountrymodel.chineseName;
    edit.str4id = model.dealerInfomodel.configCountrymodel.id;
    
    edit.str5   = model.receiveProvince;
    edit.str6   = model.receiveCity;
    edit.str7   = model.receiveArea;
    edit.str8   = model.receiveAddress;
    edit.str9   = model.zip;
    
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)clickdelebtn:(UIButton *)sender{
    
    JXS_6_Cell *cell = (JXS_6_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    paymodel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":model.id,
            };
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress",@"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"删除成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                [weakSelf.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"删除失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                           NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model2 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
            
            Conaddrmodel *model5 = [Conaddrmodel mj_objectWithKeyValues:model.configAddrType];
            model.configAddrTypemodel = model5;
            
            
            configArea_Model *model1 = [configArea_Model mj_objectWithKeyValues:model.dealerInfomodel.configArea];
            model.dealerInfomodel.configAreamodel = model1;
            
            configCountry_Model *model3 = [configCountry_Model mj_objectWithKeyValues:model.dealerInfomodel.configCountry];
            model.dealerInfomodel.configCountrymodel = model3;
            
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model2 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model2;
            
            
            Conaddrmodel *model5 = [Conaddrmodel mj_objectWithKeyValues:model.configAddrType];
            model.configAddrTypemodel = model5;
            
            
            configArea_Model *model1 = [configArea_Model mj_objectWithKeyValues:model.dealerInfomodel.configArea];
            model.dealerInfomodel.configAreamodel = model1;
            
            configCountry_Model *model3 = [configCountry_Model mj_objectWithKeyValues:model.dealerInfomodel.configCountry];
            model.dealerInfomodel.configCountrymodel = model3;
            
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
