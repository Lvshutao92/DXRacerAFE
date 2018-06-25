//
//  JXS_6_Add_Edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_6_Add_Edit_ViewController.h"
#import "jxs1model.h"
#import "model1.h"
#import "model2.h"
#import "model3.h"
#import "model4.h"
#import "model5.h"
#import "Conaddrmodel.h"
#import "configCountry_Model.h"
@interface JXS_6_Add_Edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
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
    
    
    
    
    NSString *ids1;
    NSString *ids2;
    NSString *ids3;
    NSString *ids4;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableview1;


@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)UITableView *tableview2;
@end

@implementation JXS_6_Add_Edit_ViewController


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
        ids1 = self.str1id;
        ids2 = self.str2id;
        ids3 = self.str3id;
        ids4 = self.str4id;
        
        text1.text = self.str1;
        text2.text = self.str2;
        text3.text = self.str3;
        text4.text = self.str4;
        text5.text = self.str5;
        text6.text = self.str6;
        text7.text = self.str7;
        text8.text = self.str8;
        text9.text = self.str9;
        
    }
    
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(85, 40, SCREEN_WIDTH-100, 250)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(85, 90, SCREEN_WIDTH-100, 200)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [scrollview addSubview:self.tableview1];
    
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(85, 190, SCREEN_WIDTH-100, 200)];
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
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        
        if (ids1.length != 0 && ids2.length != 0 && ids3.length != 0 && ids4.length != 0) {
            [self lodadd];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"公司名称不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }else{
        
        if (ids1.length != 0 && ids2.length != 0 && ids3.length != 0 && ids4.length != 0) {
             [self lodedit];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"公司名称不能为空" preferredStyle:1];
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
            @"typeId":ids2,
            @"areaId":ids3,
            @"countryId":ids4,
            
            @"receiveProvince":text5.text,
            @"receiveCity":text6.text,
            @"receiveArea":text7.text,
            @"receiveAddress":text8.text,
            @"zip":text9.text,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"typeId":ids2,
            @"areaId":ids3,
            @"countryId":ids4,
            
            @"receiveProvince":text5.text,
            @"receiveCity":text6.text,
            @"receiveArea":text7.text,
            @"receiveAddress":text8.text,
            @"zip":text9.text,
            
            @"id":self.idstr,
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
        jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
        text1.text = model.companyName;
        ids1 = model.id;
        
        
        text3.text = model.model1.chineseName;
        ids3 = model.model1.id;
        
        [self lodcountry:model.model1.id];
        
    }else if ([tableView isEqual:self.tableview1]){
        Conaddrmodel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        text2.text = model.typeCn;
        ids2 = model.id;
    }else if ([tableView isEqual:self.tableview2]){
        configCountry_Model *model = self.dataArray2[indexPath.row];
        text4.text = model.chineseName;
        ids4 = model.id;
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.companyName;
        return cell;
    }
    else if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Conaddrmodel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.typeCn;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    configCountry_Model *model = [self.dataArray2 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.chineseName;
    return cell;
}


- (void)lodcountry:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"areaId":str,
            };
    [session POST:KURLNSString2(@"servlet", @"config",@"configcountry",@"all") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"----%@",dic);
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        [weakSelf.dataArray2 removeAllObjects];
        
        for (NSDictionary *dic in array) {
            configCountry_Model *model = [configCountry_Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray2 addObject:model];
        }
        
        
        configCountry_Model *model = weakSelf.dataArray2.firstObject;
        text4.text = model.chineseName;
        ids4 = model.id;
        
        
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"dealer/manager",@"dealeraddress",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        NSMutableArray *array1  = [[dic objectForKey:@"rows"] objectForKey:@"configAddrTypeList"];
        NSMutableArray *array2  = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray1 removeAllObjects];
        
        for (NSDictionary *dic in array2) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            
            model1 *models1 = [model1 mj_objectWithKeyValues:model.configArea];
            model.model1 = models1;
            
            model2 *models2 = [model2 mj_objectWithKeyValues:model.configCountry];
            model.model2 = models2;
            
            [weakSelf.dataArray addObject:model];
        }
        
        for (NSDictionary *dic in array1) {
            Conaddrmodel *model = [Conaddrmodel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model];
        }
        
        if ([weakSelf.navigationItem.title isEqualToString:@"新增"]) {
            Conaddrmodel *model = weakSelf.dataArray1.firstObject;
            text2.text = model.typeCn;
            ids2 = model.id;
        }
        
        [weakSelf.tableview reloadData];
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}














- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        if ([textField isEqual:text1]) {
            return NO;
        }
        if ([textField isEqual:text2]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            self.tableview.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text3]) {
            return NO;
        }
        if ([textField isEqual:text4]) {
            return NO;
        }
    }else{
        if ([textField isEqual:text1]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            self.tableview1.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview.hidden == YES) {
                self.tableview.hidden = NO;
            }else{
                self.tableview.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text2]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            self.tableview.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:text3]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            return NO;
        }
        if ([textField isEqual:text4]) {
            [text5 resignFirstResponder];
            [text6 resignFirstResponder];
            [text7 resignFirstResponder];
            [text8 resignFirstResponder];
            [text9 resignFirstResponder];
            self.tableview.hidden  = YES;
            self.tableview1.hidden = YES;
            
            if (self.tableview2.hidden == YES) {
                self.tableview2.hidden = NO;
            }else{
                self.tableview2.hidden = YES;
            }
            return NO;
        }
    }
    
    
    
    
    
    
    
    
    
    
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
}




- (void)setUpRightTextfield{
    for (int i = 0; i<9; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(85, 10+50*i, SCREEN_WIDTH-100, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                text1.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                text1.placeholder = @"请选择";
                break;
            case 1:
                text2 = lable;
                text2.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 2:
                text3 = lable;
                text3.placeholder = @"请选择公司";
                text3.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
                break;
            case 3:
                text4 = lable;
                text4.placeholder = @"请选择";
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
            case 7:
                text8 = lable;
                break;
            case 8:
                text9 = lable;
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
    NSMutableArray *arr = [@[@"公司名称",@"地址类型",@"地区",@"国家",@"省份",@"城市",@"区县",@"地址",@"邮编"]mutableCopy];
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
- (NSMutableArray *)dataArray1{
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}- (NSMutableArray *)dataArray2{
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}


@end
