//
//  JXS_5_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_5_add_edit_ViewController.h"
#import "Pay_One_model.h"
#import "paymodel.h"
#import "ConfigDutyModel.h"
@interface JXS_5_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    
    
    NSString *ids;
    NSString *ids1;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableview1;

@end

@implementation JXS_5_add_edit_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    scrollview.contentSize = CGSizeMake(0, 600);
    scrollview.userInteractionEnabled = YES;
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        ids  = self.str1id;
        ids1 = self.str3id;
        
        
        text1.text = self.str1;
        text2.text = self.str2;
        text3.text = self.str3;
        text4.text = self.str4;
        text5.text = self.str5;
        text6.text = self.str6;
        text7.text = self.str7;
        
    }
    
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(105, 40, SCREEN_WIDTH-115, 250)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(105, 140, SCREEN_WIDTH-115, 100)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [scrollview addSubview:self.tableview1];
    
    [self lodinfor];
}

- (void)clickSave{
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        [self lodadd];
    }else{
        [self lodedit];
    }
}

- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":ids,
            @"person":text2.text,
            @"dutyId":ids1,
            @"qq":text4.text,
            @"wechat":text5.text,
            @"telephone":text6.text,
            @"email":text7.text,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealercontact", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
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
            @"dealerId":ids,
            @"person":text2.text,
            @"dutyId":ids1,
            @"qq":text4.text,
            @"wechat":text5.text,
            @"telephone":text6.text,
            @"email":text7.text,
            @"id":self.strid,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealercontact", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
    }
    return self.dataArray1.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        Pay_One_model *model = [self.dataArray objectAtIndex:indexPath.row];
        text1.text = model.companyName;
        ids = model.id;
    }else{
        ConfigDutyModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        text1.text = model.chineseName;
        ids1 = model.id;
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Pay_One_model *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.companyName;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ConfigDutyModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.chineseName;
    return cell;
}






- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealercontact",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                  NSLog(@"----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *array1  = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        
        NSMutableArray *array2  = [[dic objectForKey:@"rows"] objectForKey:@"configDutyList"];
        
        for (NSDictionary *dic in array1) {
            Pay_One_model *model = [Pay_One_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        for (NSDictionary *dict in array2) {
            ConfigDutyModel *model = [ConfigDutyModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        
        if ([weakSelf.navigationItem.title isEqualToString:@"新增"]) {
            Pay_One_model *model = weakSelf.dataArray.firstObject;
            text1.text = model.companyName;
            ids = model.id;
            
            
            ConfigDutyModel *model1 = weakSelf.dataArray1.firstObject;
            text3.text = model1.chineseName;
            ids1 = model1.id;
        }
        [weakSelf.tableview reloadData];
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}














- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        if ([textField isEqual:text1]) {
            [text2 resignFirstResponder];
            [text4 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            self.tableview1.hidden = YES;
            if (self.tableview.hidden == YES) {
                self.tableview.hidden = NO;
            }else{
                self.tableview.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text3]) {
            [text2 resignFirstResponder];
            [text4 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            
            self.tableview.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
    }else{
        if ([textField isEqual:text1]) {
            return NO;
        }
        if ([textField isEqual:text3]) {
            [text2 resignFirstResponder];
            [text4 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            
            self.tableview.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
    }
    
    
    
    
    
    
    
    
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    return YES;
}




- (void)setUpRightTextfield{
    for (int i = 0; i<7; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(105, 10+50*i, SCREEN_WIDTH-115, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                text1.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 1:
                text2 = lable;
                break;
            case 2:
                text3 = lable;
                text3.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 3:
                text4 = lable;
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
        lable.delegate = self;
        lable.font = [UIFont systemFontOfSize:16];
        lable.borderStyle=UITextBorderStyleRoundedRect;
        [scrollview addSubview:lable];
    }
    
    
    
}

- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"公司名称",@"联系人姓名",@"联系人职务",@"QQ",@"Skype",@"固定电话",@"Email"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 90, 30)];
        lable.text = arr[i];
        lable.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lable];
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


@end
