//
//  CP_3_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CP_3_ViewController.h"
#import "CP3TableViewCell.h"
#import "cp3model.h"
#import "CP3detailsTableViewController.h"
#import "CP_search_three_ViewController.h"
@interface CP_3_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation CP_3_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"CP3TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    CP_search_three_ViewController *search = [[CP_search_three_ViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 480;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    CP3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[CP3TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    cp3model *model = [self.dataArray objectAtIndex:indexPath.row];

    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)] placeholderImage:[UIImage imageNamed:@"bgview"]];

    cell.lab1.text = model.partNo;
    cell.lab2.text = model.name;
    cell.lab3.text = model.classifyCn;
    
    cell.lab4.text = model.storageSafe;
    cell.lab5.text = [NSString stringWithFormat:@"%@*%@*%@",model.packageLength,model.packageWidth,model.packageHeight];
    cell.lab6.text = model.weight;
    cell.lab7.text = [NSString stringWithFormat:@"%@%%",model.aftersalePercent];
    cell.lab8.text = [Manager jinegeshi:model.aftersale_price];
    cell.lab9.text = [Manager jinegeshi:model.adjust_price];
    
    
    
    if ([model.audit_status isEqualToString:@"1"]) {
        cell.lab10.text = @"待审核";
        [cell.auditbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if ([model.audit_status isEqualToString:@"2"]) {
        cell.lab10.text = @"已审核";
        [cell.auditbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else {
        cell.lab10.text = @"无";
        [cell.auditbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    
    
    
    if ([model.stop isEqualToString:@"Y"]) {
        cell.lab11.text = @"是";
    }else if ([model.stop isEqualToString:@"N"]) {
        cell.lab11.text = @"否";
    }
    
    [cell.editbtn addTarget:self action:@selector(clickedit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [cell.auditbtn addTarget:self action:@selector(clickaudit:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



- (void)clickedit:(UIButton *)sender{
    CP3TableViewCell *cell = (CP3TableViewCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    cp3model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"编辑窗口" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *TextField = alertController.textFields.firstObject;
        [self lodedit:TextField.text idstr:model.id];
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"现价调整价";
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}


- (void)lodedit:(NSString *)str idstr:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"adjust_price":str,
            @"id":idstr,
            };
    [session POST:KURLNSString1(@"servlet", @"parts",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cp3model *model = [self.dataArray objectAtIndex:indexPath.row];
    CP3detailsTableViewController *details = [[CP3detailsTableViewController alloc]init];
    details.navigationItem.title = @"详情";
    details.idstr = model.id;
    [self.navigationController pushViewController:details animated:YES];
}







- (void)clickaudit:(UIButton *)sender{
    CP3TableViewCell *cell = (CP3TableViewCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    cp3model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    if ([model.audit_status isEqualToString:@"1"]) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        page = 1;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"username":[Manager redingwenjianming:@"userName.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString1(@"servlet", @"parts",@"audit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"%@",dic);
            
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"审核成功" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"审核失败" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    
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
            
            @"partNo":self.str1,
            @"englishName":self.str2,
            @"name":self.str3,
            @"stop":self.str4,
            };

    [session POST:KURLNSString1(@"servlet", @"parts",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            cp3model *model = [cp3model mj_objectWithKeyValues:dict];
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
            
            @"partNo":self.str1,
            @"englishName":self.str2,
            @"name":self.str3,
            @"stop":self.str4,
            };
    
    [session POST:KURLNSString1(@"servlet", @"parts",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            cp3model *model = [cp3model mj_objectWithKeyValues:dict];
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
