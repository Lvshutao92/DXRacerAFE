//
//  JXS_13_add_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/9.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_13_add_ViewController.h"
#import "systemRoleModel.h"
#import "jxs1model.h"
@interface JXS_13_add_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *ids1;
    NSString *ids2;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *selectedArray;
@property(nonatomic, strong)NSMutableArray *selectedIdArray;

@end

@implementation JXS_13_add_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 115, SCREEN_WIDTH-100, 150)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(90, 180, SCREEN_WIDTH-100, 150)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    
    [self.view bringSubviewToFront:self.tableview];
    [self.view bringSubviewToFront:self.tableview1];
    
    [self lodinfor];
}
- (void)clickSave{
    if (ids2.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":ids1,
                @"instructIds":ids2,
                };
        [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerinstruct", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"%@",[dic objectForKey:@"result_msg"]);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新增成功" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新增失败" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"说明书不能为空" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview]) {
        return self.dataArray.count;
    }
    return self.dataArray1.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
        _text1.text = model.companyName;
        ids1 = model.id;
    }else{
        //判断该行原先是否选中
        NSString *str = [self.dataArray1 objectAtIndex:indexPath.row];
        if ([self.selectedArray containsObject:str] == YES) {
            [self.selectedArray removeObject:str];
        }else{
            [self.selectedArray addObject:str];
        }
        self.text2.text = [self.selectedArray componentsJoinedByString:@" "];
        
        
        NSString *str1 = [self.dataArray2 objectAtIndex:indexPath.row];
        if ([self.selectedIdArray containsObject:str1] == YES) {
            [self.selectedIdArray removeObject:str1];
        }else{
            [self.selectedIdArray addObject:str1];
        }
        ids2 = [self.selectedIdArray componentsJoinedByString:@","];
        ////刷新该行
        [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     }
    self.tableview.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.companyName;
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataArray1 objectAtIndex:indexPath.row];
    if ([self.selectedArray containsObject:self.dataArray1[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}


- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerinstruct",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                  NSLog(@"----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr  = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        for (NSDictionary *dic in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        jxs1model *model = [weakSelf.dataArray firstObject];
        weakSelf.text1.text = model.companyName;
        ids1 = model.id;
        
        [weakSelf.dataArray1 removeAllObjects];
        [weakSelf.dataArray2 removeAllObjects];
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"configInstructList"];
        for (NSDictionary *dic in array) {
            systemRoleModel *model = [systemRoleModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model.chineseName];
            [weakSelf.dataArray2 addObject:model.id];
        }
        [weakSelf.selectedArray removeAllObjects];
        [weakSelf.selectedIdArray removeAllObjects];
        
        [weakSelf.selectedArray addObject:weakSelf.dataArray1.firstObject];
        [weakSelf.selectedIdArray addObject:weakSelf.dataArray2.firstObject];
        
        
        weakSelf.text2.text = [weakSelf.dataArray1 firstObject];
        ids2 = [weakSelf.dataArray2 firstObject];
         NSLog(@"%@--%@",weakSelf.text2.text,ids2);
        [weakSelf.tableview reloadData];
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}












- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_text1]) {
        self.tableview1.hidden = YES;
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:_text2]) {
        self.tableview.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    self.tableview.hidden  = YES;
    self.tableview1.hidden = YES;
    return NO;
}




- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray1{
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray2{
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        self.selectedArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectedArray;
}
- (NSMutableArray *)selectedIdArray {
    if (_selectedIdArray == nil) {
        self.selectedIdArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectedIdArray;
}




@end
