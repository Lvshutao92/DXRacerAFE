//
//  JXS_2_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_2_ViewController.h"
#import "paymodel.h"
#import "Pay_One_model.h"
#import "JXS_2_Cell.h"
#import "JXS_2_add_edit_ViewController.h"
@interface JXS_2_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation JXS_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableview registerNib:[UINib nibWithNibName:@"JXS_2_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    button.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [button setTitle:@"新增" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self loddeList];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    JXS_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[JXS_2_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    paymodel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.dealerInfomodel.companyName;
    
    cell.lab2.text = model.paymentType;
    
    
    if ([model.paymentType isEqualToString:@"T/T"]) {
        
        if ([model.retainageType isEqualToString:@"before"]) {
            cell.lab3.text = [NSString stringWithFormat:@"出货前"];
        }else if ([model.retainageType isEqualToString:@"after"]){
            cell.lab3.text = [NSString stringWithFormat:@"出货后%@天",model.lcday];
        }
        
        
        
        
        if (model.proportion != nil) {
            cell.lab4.text = [NSString stringWithFormat:@"%@%%",model.proportion];
        }else{
            cell.lab4.text = @"-";
        }
        
        
        if (model.proportion != nil) {
            cell.lab5.text = [NSString stringWithFormat:@"%.00f%%",100-[model.proportion floatValue]];
        }else{
            cell.lab5.text = @"-";
        }
        
        
    }else if ([model.paymentType isEqualToString:@"L/C"]){
        cell.lab3.text = [NSString stringWithFormat:@"-"];
        cell.lab4.text = @"-";
        cell.lab5.text = @"-";
    }
    
    
    
    
    
    
    
    
   
    
    
    
    [cell.delebtn addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



- (void)clickadd{
    JXS_2_add_edit_ViewController *add = [[JXS_2_add_edit_ViewController alloc]init];
    add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
}


- (void)clickeditbtn:(UIButton *)sender{
    
    
    JXS_2_Cell *cell = (JXS_2_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    paymodel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    JXS_2_add_edit_ViewController *jxs_add = [[JXS_2_add_edit_ViewController alloc]init];
    jxs_add.navigationItem.title = @"编辑";
    jxs_add.idstr = model.id;
    
    
    jxs_add.str1   = model.dealerInfomodel.companyName;
    jxs_add.str1id = model.dealerId;

    jxs_add.str2   = model.paymentType;

    
    
    if ([model.retainageType isEqualToString:@"before"]) {
        jxs_add.str3   = @"出货前";
    }else if ([model.retainageType isEqualToString:@"after"]){
        jxs_add.str3   = @"出货后";
    }
    
    
    jxs_add.str3id = model.retainageType;
    
    jxs_add.str4 = model.proportion;
    
    jxs_add.str5 = model.lcday;
    
    [self.navigationController pushViewController:jxs_add animated:YES];
    
    
    
}



- (void)clickdelebtn:(UIButton *)sender{
    
    JXS_2_Cell *cell = (JXS_2_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    paymodel *model = [self.dataArray objectAtIndex:indexpath.row];
    
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString2(@"servlet", @"dealer", @"manager",@"dealerpayment/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
   
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}





- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    
    [session POST:KURLNSString3(@"servlet", @"dealer",@"manager",@"dealerpayment",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
                                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            paymodel *model = [paymodel mj_objectWithKeyValues:dict];
            
            Pay_One_model *model01 = [Pay_One_model mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfomodel = model01;
            
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
