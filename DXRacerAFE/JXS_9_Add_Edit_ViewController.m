//
//  JXS_9_Add_Edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_9_Add_Edit_ViewController.h"
#import "jxs1model.h"
@interface JXS_9_Add_Edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UITextField *text9;
    UITextField *text10;
    UITextField *text11;
    UITextField *text12;
    UITextField *text13;
    
    NSString *ids1;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@end

@implementation JXS_9_Add_Edit_ViewController


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
    scrollview.contentSize = CGSizeMake(0, 800);
    scrollview.userInteractionEnabled = YES;
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        ids1 = self.str1id;
        
        text1.text = self.str1;
        text2.text = self.str2;
        text3.text = self.str3;
        text4.text = self.str4;
        text5.text = self.str5;
        text6.text = self.str6;
        
        text7.text = self.str7;
        text8.text = self.str8;
        text9.text = self.str9;
        text10.text = self.str10;
        text11.text = self.str11;
        text12.text = self.str12;
        
        text13.text = self.str13;
    }
    
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(110, 40, SCREEN_WIDTH-120, 250)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    
    [self lodinfor];
}

- (void)clickSave{
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    if (text9.text.length == 0) {
        text9.text = @"";
    }
    if (text10.text.length == 0) {
        text10.text = @"";
    }
    
    if (text11.text.length == 0) {
        text11.text = @"";
    }
    if (text12.text.length == 0) {
        text12.text = @"";
    }
    if (text13.text.length == 0) {
        text13.text = @"";
    }
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        
        if (ids1.length != 0 && text2.text.length != 0 ) {
            [self lodadd];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"订舱代理不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }else{
        
        if (ids1.length != 0 && text2.text.length != 0 ) {
            [self lodedit];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"订舱代理不能为空" preferredStyle:1];
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
            @"dealerId":ids1,
            @"bookingAgent":text2.text,
            @"province":text3.text,
            @"city":text4.text,
            @"county":text5.text,
            @"detailAddress":text6.text,
            @"telephone":text7.text,
            @"contactPerson":text8.text,
            @"mobilePhone":text9.text,
            @"mailbox":text10.text,
            @"openBank":text11.text,
            @"bankAccount":text12.text,
            @"bankNumber":text13.text,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerforward", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"dealerId":ids1,
            @"bookingAgent":text2.text,
            @"province":text3.text,
            @"city":text4.text,
            @"county":text5.text,
            @"detailAddress":text6.text,
            @"telephone":text7.text,
            @"contactPerson":text8.text,
            @"mobilePhone":text9.text,
            @"mailbox":text10.text,
            @"openBank":text11.text,
            @"bankAccount":text12.text,
            @"bankNumber":text13.text,
            
            @"id":self.idstr,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerforward", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
    text1.text = model.companyName;
    ids1 = model.id;
    self.tableview.hidden = YES;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.companyName;
    return cell;
    
}






- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealerforward",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                                NSLog(@"----%@",dic);
        
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
       
        if ([weakSelf.navigationItem.title isEqualToString:@"新增"]) {
            jxs1model *model = weakSelf.dataArray.firstObject;
            text1.text = model.companyName;
            ids1 = model.id;
        }
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        if ([textField isEqual:text1]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text3 resignFirstResponder];
            [text4 resignFirstResponder];
            [text2 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            [text10 resignFirstResponder];
            [text11 resignFirstResponder];
            [text12 resignFirstResponder];
            [text13 resignFirstResponder];
            
            return NO;
        }
        
    }else{
        if ([textField isEqual:text1]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text3 resignFirstResponder];
            [text4 resignFirstResponder];
            [text2 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            [text10 resignFirstResponder];
            [text11 resignFirstResponder];
            [text12 resignFirstResponder];
            [text13 resignFirstResponder];
            if (self.tableview.hidden == YES) {
                self.tableview.hidden = NO;
            }else{
                self.tableview.hidden = YES;
            }
            return NO;
        }
        
    }
    
    
    
    self.tableview.hidden = YES;
    return YES;
}




- (void)setUpRightTextfield{
    for (int i = 0; i<13; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(110, 10+50*i, SCREEN_WIDTH-120, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                text1.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 1:
                text2 = lable;
                text2.placeholder = @"必填";
                break;
            case 2:
                text3 = lable;
                
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
            case 7:
                text8 = lable;
                break;
            case 8:
                text9 = lable;
                break;
            case 9:
                text10 = lable;
                break;
            case 10:
                text11 = lable;
                break;
            case 11:
                text12 = lable;
                break;
            case 12:
                text13 = lable;
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
    NSMutableArray *arr = [@[@"公司名称",@"订舱代理",@"省份",@"城市",@"区县",@"详细地址",@"固定电话",@"联系人",@"手机号",@"邮箱",@"开户行",@"银行账户",@"银行账号"]mutableCopy];
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
@end
