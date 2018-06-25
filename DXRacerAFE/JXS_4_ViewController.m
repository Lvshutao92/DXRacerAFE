//
//  JXS_4_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_4_ViewController.h"
#import "JXS_4_Cell.h"
#import "JXS4model.h"
#import "JXS4_change_ViewController.h"
@interface JXS_4_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation JXS_4_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"JXS_4_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
   
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    JXS_4_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[JXS_4_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    JXS4model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.image_url)]placeholderImage:[UIImage imageNamed:@"bgview"]];
    
    cell.lab1.text = model.company_name;
    cell.lab2.text = model.fcno;
    
    cell.lab3.text = [NSString stringWithFormat:@"%@ %@",model.model,model.itemno];
    cell.lab4.text = model.fcno_name_chinese;
    
    cell.lab5.text = [Manager jinegeshi:model.unit_price];
    
    
    if ([model.use_type isEqualToString:@"batchOrder"]) {
        cell.lab6.text = @"PIA";
    }else if ([model.use_type isEqualToString:@"afterSale"]) {
        cell.lab6.text = @"PID";
    }else if ([model.use_type isEqualToString:@"tradOrder"]) {
        cell.lab6.text = @"PIC";
    }
    
    
    if ([model.dealer_use_status isEqualToString:@"A"]) {
        cell.lab7.text = @"已申请";
        [cell.stopbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        
        if (model.unit_price != nil) {
            [cell.auditbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell.auditbtn addTarget:self action:@selector(clickauditbtn:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [cell.auditbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }else if ([model.dealer_use_status isEqualToString:@"Y"]) {
        cell.lab7.text = @"已可买";
        [cell.stopbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.stopbtn addTarget:self action:@selector(clickstopbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.auditbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else if ([model.dealer_use_status isEqualToString:@"N"]) {
        cell.lab7.text = @"已取消";
        [cell.stopbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        if (model.unit_price != nil) {
            [cell.auditbtn addTarget:self action:@selector(clickauditbtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.auditbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [cell.auditbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    
    [cell.changbtn addTarget:self action:@selector(clickchangebtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delebtn addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    return cell;
}


//change
- (void)clickchangebtn:(UIButton *)sender{
    JXS_4_Cell *cell = (JXS_4_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    JXS4model *model = [self.dataArray objectAtIndex:indexpath.row];
    JXS4_change_ViewController *change = [[JXS4_change_ViewController alloc]init];
    change.navigationItem.title = @"修改价格";
    change.idstr = model.id;
    change.str1 = model.company_name;
    change.str2 = model.fcno;
    
    
    if ([model.use_type isEqualToString:@"batchOrder"]) {
        change.str3 = @"批量订单";
    }else if ([model.use_type isEqualToString:@"tradOrder"]) {
        change.str3 = @"现货订单";
    }
    
    change.str4 = model.unit_price;
    
    [self.navigationController pushViewController:change animated:YES];
}

//delete
- (void)clickdelebtn:(UIButton *)sender{
    JXS_4_Cell *cell = (JXS_4_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    JXS4model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":model.id,
            };
    
    [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
//audit
- (void)clickauditbtn:(UIButton *)sender{
    JXS_4_Cell *cell = (JXS_4_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    JXS4model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    if ([model.dealer_use_status isEqualToString:@"A"] || [model.dealer_use_status isEqualToString:@"N"]){
        if (model.unit_price != nil){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定审核吗？" preferredStyle:1];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self lodaudit:model.id];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
   
}




- (void)lodaudit:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":str,
            @"status":@"Y",
            };
    
    [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"audit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"审核成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"审核失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}







//stop
- (void)clickstopbtn:(UIButton *)sender{
    JXS_4_Cell *cell = (JXS_4_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    JXS4model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    if ([model.dealer_use_status isEqualToString:@"Y"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定停用吗？" preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            AFHTTPSessionManager *session = [Manager returnsession];
            __weak typeof(self) weakSelf = self;
            NSDictionary *dic = [[NSDictionary alloc]init];
            dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                    @"id":model.id,
                    @"status":@"N",
                    };
            
            [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"audit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [Manager returndictiondata:responseObject];
                //NSLog(@"%@",dic);
                if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"停用成功" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"停用失败" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }
                [weakSelf.tableview reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
            
            
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
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
            };
    
    [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//           NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            JXS4model *model = [JXS4model mj_objectWithKeyValues:dict];
            
            
            
            
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
    
    [session POST:KURLNSString2(@"servlet", @"dealer",@"dealergoods",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            JXS4model *model = [JXS4model mj_objectWithKeyValues:dict];
            
         
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
