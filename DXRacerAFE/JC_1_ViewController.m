//
//  JC_1_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JC_1_ViewController.h"
#import "JC_1_Cell.h"
#import "JC_1_Model.h"
@interface JC_1_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation JC_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"JC_1_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
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

- (void)lodAdd:(NSString *)str1 str2:(NSString *)str2 str3:(NSString *)str3{
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"currencyCode":str1,
            @"currencyName":str2,
            @"field1":str3,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcurrency", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)clickadd{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"新增窗口" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *TextField1 = alertController.textFields.firstObject;
        UITextField *TextField2 = alertController.textFields[1];
        UITextField *TextField3 = alertController.textFields[2];
        [self lodAdd:TextField1.text str2:TextField2.text str3:TextField3.text];
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"货币编号";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"货币名称";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"货币符号";
    }];
    [self presentViewController:alertController animated:true completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JC_1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JC_1_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.currencyCode;
    cell.lab2.text = model.currencyName;
    cell.lab3.text = model.field1;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (void)lodEdit:(NSString *)str1 str2:(NSString *)str2 str3:(NSString *)str3 idStr:(NSString *)idStr IndexPath:(NSIndexPath *)IndexPath{
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"currencyCode":str1,
            @"id":idStr,
            @"currencyName":str2,
            @"field1":str3,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcurrency", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        [weakSelf.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:IndexPath.row inSection:IndexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *suer = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull sure, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JC_1_Model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"编辑窗口" preferredStyle:UIAlertControllerStyleAlert];
        //增加取消按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *TextField1 = alertController.textFields.firstObject;
            UITextField *TextField2 = alertController.textFields[1];
            UITextField *TextField3 = alertController.textFields.lastObject;
            
            [self lodEdit:TextField1.text str2:TextField2.text str3:TextField3.text idStr:model.id IndexPath:indexPath];
        }]];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.text = model.currencyCode;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = model.currencyName;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = model.field1;
        }];
        [self presentViewController:alertController animated:true completion:nil];
        
    }];
    suer.backgroundColor = RGBACOLOR(254, 91, 91, 1.0);
    
    
    UITableViewRowAction *deleate = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull kaipiao, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JC_1_Model *model = [self.dataArray objectAtIndex:indexPath.row];
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
    [session POST:KURLNSString2(@"servlet", @"config", @"configcurrency", @"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
       
//        NSLog(@"---%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.dataArray removeObjectAtIndex:IndexPath.row];  //删除_data数组里的数据
                [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:IndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
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
    [session POST:KURLNSString2(@"servlet", @"config", @"configcurrency", @"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        //NSLog(@"---%@",dic);
        
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dic in arr) {
            JC_1_Model *model = [JC_1_Model mj_objectWithKeyValues:dic];
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
    
    [session POST:KURLNSString2(@"servlet", @"config", @"configcurrency", @"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dic in arr) {
            JC_1_Model *model = [JC_1_Model mj_objectWithKeyValues:dic];
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
