//
//  JXS_3_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_3_add_edit_ViewController.h"
#import "jxs1model.h"
#import "model3.h"
@interface JXS_3_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    
    NSString *ids1;
    NSString *ids2;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;



@end

@implementation JXS_3_add_edit_ViewController

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
    
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]){
        text1.text = self.str1;
        text2.text = self.str2;
        text3.text = self.str3;
        text4.text = self.str4;
        text5.text = self.str5;
        text6.text = self.str6;
        
        ids1 = self.str1id;
        ids2 = self.str2id;
        
    }
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(85, 40, SCREEN_WIDTH-100, 250)];
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
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    
    
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        if (text3.text.length != 0 && text4.text.length != 0 && text5.text.length != 0) {
            [self lodadd];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"银行信息均不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        if (text3.text.length != 0 && text4.text.length != 0 && text5.text.length != 0) {
            [self lodedit];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"银行信息均不能为空" preferredStyle:1];
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
            @"currencyId":ids2,
            @"bankName":text3.text,
            @"bankAccount":text4.text,
            @"bankNo":text5.text,
            @"swift":text6.text,
            
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager", @"dealerbank", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新增失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
            @"id":self.idstr,
            @"dealerId":ids1,
            @"currencyId":ids2,
            @"bankName":text3.text,
            @"bankAccount":text4.text,
            @"bankNo":text5.text,
            @"swift":text6.text,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager", @"dealerbank", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑失败" preferredStyle:1];
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
   
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];

    text1.text = model.companyName;
    ids1 = model.id;
    
    text2.text = model.model3.currencyCode;
    ids2 = model.model3.id;
    

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
    [session POST:KURLNSString2(@"servlet", @"dealer/manager", @"dealerbank",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//       NSLog(@"----%@",dic);
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            
            model3 *model1 = [model3 mj_objectWithKeyValues:model.configCurrency];
            model.model3 = model1;
            
            [weakSelf.dataArray addObject:model];
        }
        
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            jxs1model *model = weakSelf.dataArray.firstObject;
            text1.text = model.companyName;
            ids1 = model.id;
            
            text2.text = model.model3.currencyCode;
            ids2 = model.model3.id;
        }
        [weakSelf.tableview  reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}














- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        if ([textField isEqual:text1]) {
            [text3 resignFirstResponder];
            [text4 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            if (self.tableview.hidden == YES) {
                self.tableview.hidden = NO;
            }else{
                self.tableview.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text2]) {
            self.tableview.hidden = YES;
            [text3 resignFirstResponder];
            [text4 resignFirstResponder];
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            return NO;
        }
    }else{
        if ([textField isEqual:text1]) {
            return NO;
        }
        if ([textField isEqual:text2]) {
            return NO;
        }
    }
    
    
    
    self.tableview.hidden = YES;
    return YES;
}




- (void)setUpRightTextfield{
    for (int i = 0; i<6; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(85, 10+50*i, SCREEN_WIDTH-100, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                text1.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 1:
                text2 = lable;
                text2.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                text2.placeholder = @"请先选择公司";
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
    NSMutableArray *arr = [@[@"公司名称",@"货币类型",@"开户银行",@"银行账户",@"银行账号",@"SWIFT"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 70, 30)];
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
