//
//  JXS_12_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_12_add_edit_ViewController.h"
#import "systemRoleModel.h"
#import "jxs1model.h"
@interface JXS_12_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    
    NSString *ids1;
    NSString *ids2;
    NSString *ids3;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableview1;

@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)UITableView *tableview2;
@end

@implementation JXS_12_add_edit_ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    self.dataArray2 = [@[@"正常",@"停用"]mutableCopy];
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    scrollview.contentSize = CGSizeMake(0, 600);
    scrollview.userInteractionEnabled = YES;
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    
    
    
    
    
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        ids1 = self.roleid;
        ids2 = self.companyid;

        ids3 = self.str5;
        
        text1.text = self.str1;
        text2.text = self.str2;
        text3.text = self.str3;
        text5.text = self.str4;
        
        if ([self.str5 isEqualToString:@"Y"]) {
            text4.text = @"正常";
        }else{
            text4.text = @"停用";
        }
        
        
    }else{
         text4.text = @"正常";
         ids3 = @"Y";
    }
    
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(110, 90, SCREEN_WIDTH-120, 150)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(110, 140, SCREEN_WIDTH-120, 250)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [scrollview addSubview:self.tableview1];
    
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(110, 190, SCREEN_WIDTH-120, 100)];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [scrollview addSubview:self.tableview2];
    
    
    [self lodinfor];
}

- (void)clickSave{
    
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
    }
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        
        if (text1.text.length != 0 && ids1.length != 0 && ids2.length != 0 && ids3.length != 0 && text5.text.length != 0) {
            
            [self lodadd];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"角色／用户名／公司名称／密码均不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }else{
        
        if (text1.text.length != 0 && ids1.length != 0 && ids2.length != 0 && ids3.length != 0 && text5.text.length != 0) {
            [self lodedit];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"角色／用户名／公司名称／密码均不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }
}

- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"username":text1.text,
            @"roleId":ids1,
            @"dealerId":ids2,
            @"status":ids3,
            @"password":text5.text,
            @"realName":text6.text,
            @"mobile":text7.text,
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeruser", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",[dic objectForKey:@"result_msg"]);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"username":text1.text,
            @"roleId":ids1,
            @"dealerId":ids2,
            @"status":ids3,
            @"password":text5.text,
            @"id":self.idstr,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeruser", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}









- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview]) {
        return self.dataArray.count;
    }else if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray2.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        systemRoleModel *model = [self.dataArray objectAtIndex:indexPath.row];
        text2.text = model.roleName;
        ids1 = model.id;
    }else if ([tableView isEqual:self.tableview1]){
        jxs1model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        text3.text = model.companyName;
        ids2 = model.id;
    }else{
        text4.text = self.dataArray2[indexPath.row];
        if ([text4.text isEqualToString:@"正常"]) {
            ids3 = @"Y";
        }else{
            ids3 = @"N";
        }
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        systemRoleModel *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.roleName;
        return cell;
    }else if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        jxs1model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.companyName;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray2[indexPath.row];
    return cell;
    
}






- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeruser",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//
        
//        NSLog(@"----%@",dic);
        NSMutableArray *array1  = [[dic objectForKey:@"rows"] objectForKey:@"roles"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array1) {
            systemRoleModel *model = [systemRoleModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        [weakSelf.dataArray1 removeAllObjects];
        for (NSDictionary *dic in array) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model];
        }
        
        [weakSelf.tableview reloadData];
        [weakSelf.tableview1 reloadData];
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}












- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        if ([textField isEqual:text1]) {
            self.tableview.hidden = YES;
            [text5 resignFirstResponder];
            self.tableview1.hidden = YES;
            self.tableview2.hidden = YES;
            return NO;
        }
        if ([textField isEqual:text2]) {
            [text5 resignFirstResponder];
            self.tableview1.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview.hidden == YES) {
                self.tableview.hidden = NO;
            }else{
                self.tableview.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text3]) {
            [text5 resignFirstResponder];
            self.tableview2.hidden = YES;
            self.tableview.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text4]) {
            [text5 resignFirstResponder];
            self.tableview1.hidden = YES;
            self.tableview.hidden = YES;
            if (self.tableview2.hidden == YES) {
                self.tableview2.hidden = NO;
            }else{
                self.tableview2.hidden = YES;
            }
            return NO;
        }
        
    }else if ([self.navigationItem.title isEqualToString:@"新增"]){
        if ([textField isEqual:text2]) {
            [text1 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            self.tableview1.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview.hidden == YES) {
                self.tableview.hidden = NO;
            }else{
                self.tableview.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text3]) {
            [text1 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            self.tableview2.hidden = YES;
            self.tableview.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text4]) {
            [text1 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            self.tableview1.hidden = YES;
            self.tableview.hidden = YES;
            if (self.tableview2.hidden == YES) {
                self.tableview2.hidden = NO;
            }else{
                self.tableview2.hidden = YES;
            }
            return NO;
        }
        
    }
    
    
    
    self.tableview.hidden  = YES;
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
}









- (void)setUpRightTextfield{
    
    for (int i = 0; i<7; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(110, 10+50*i, SCREEN_WIDTH-120, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                
                break;
            case 1:
                text2 = lable;
                text2.placeholder = @"请选择";
                text2.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 2:
                text3 = lable;
                text3.placeholder = @"请选择";
                text3.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 3:
                text4 = lable;
                text4.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 4:
                text5 = lable;
                break;
            case 5:
                text6 = lable;
                break;
            case 6:
                text7 = lable;
                break;
            default:
                break;
        }
        if ([self.navigationItem.title isEqualToString:@"编辑"]){
            text6.hidden = YES;
            text7.hidden = YES;
            text1.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
        }else{
            text6.hidden = NO;
            text7.hidden = NO;
        }
        lable.delegate = self;
        lable.font = [UIFont systemFontOfSize:16];
        lable.borderStyle=UITextBorderStyleRoundedRect;
        [scrollview addSubview:lable];
    }
    
    
    
}

- (void)setUpLeftLable{
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        NSMutableArray *arr = [@[@"用户名",@"角色",@"公司名称",@"状态",@"密码"]mutableCopy];
        for (int i = 0; i<arr.count; i++) {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 90, 30)];
            lable.text = arr[i];
            lable.font = [UIFont systemFontOfSize:16];
            [scrollview addSubview:lable];
        }
    }else{
        NSMutableArray *arr = [@[@"用户名",@"角色",@"公司名称",@"状态",@"密码",@"姓名",@"手机号"]mutableCopy];
        for (int i = 0; i<arr.count; i++) {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 90, 30)];
            lable.text = arr[i];
            lable.font = [UIFont systemFontOfSize:16];
            [scrollview addSubview:lable];
        }
    }
    
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


@end
