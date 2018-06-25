//
//  Add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Add_edit_ViewController.h"
#import "WD4_arr1_model.h"
#import "WD4_arr2_model.h"
@interface Add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
     UIScrollView *scrollview;
    
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    UITextField *textfield7;
    
    NSString *strid1;
    NSString *strid2;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@end

@implementation Add_edit_ViewController

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
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    
    strid1 = self.str1id;
    strid2 = self.str2id;
    
    textfield1.text = self.str1;
    textfield2.text = self.str2;
    textfield3.text = self.str3;
    textfield4.text = self.str4;
    textfield5.text = self.str5;
    textfield6.text = self.str6;
    textfield7.text = self.str7;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(100, 40, SCREEN_WIDTH-110, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(100, 90, SCREEN_WIDTH-110, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [scrollview addSubview:self.tableview1];
    
    
    
    [self lodinfor];
    
}
- (void)clickSave{
    if ([self.navigationItem.title isEqualToString:@"新增"]){
        if (textfield3.text.length == 0) {
            textfield3.text = @"";
        }
        if (textfield4.text.length == 0) {
            textfield4.text = @"";
        }
        if (textfield5.text.length == 0) {
            textfield5.text = @"";
        }
        if (textfield6.text.length == 0) {
            textfield6.text = @"";
        }
        if (textfield7.text.length == 0) {
            textfield7.text = @"";
        }
        [self lodadd];
    }else{
        [self lodedit];
    }
}


- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"typeId":strid1,
            @"countryId":strid2,
            @"receiveProvince":textfield3.text,
            @"receiveCity":textfield4.text,
            @"receiveArea":textfield5.text,
            @"receiveAddress":textfield6.text,
            @"zip":textfield7.text,
            @"id":self.strid
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealeraddress",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"----%@",dic);
        
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}







- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"typeId":strid1,
            @"countryId":strid2,
            @"receiveProvince":textfield3.text,
            @"receiveCity":textfield4.text,
            @"receiveArea":textfield5.text,
            @"receiveAddress":textfield6.text,
            @"zip":textfield7.text,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealeraddress",@"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        
        
                if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功😊" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
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
        WD4_arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        textfield1.text = model.typeCn;
        strid1 = model.id;
    }
    if ([tableView isEqual:self.tableview1]) {
        WD4_arr2_model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        
        textfield2.text = model.chineseName;
        strid2 = model.id;
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WD4_arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.typeCn;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WD4_arr2_model *model = [self.dataArray1 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.chineseName;
    return cell;
}




- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealeraddress",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        
        

        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"configAddrTypeList"];
        NSMutableArray *array1 = [[dic objectForKey:@"rows"] objectForKey:@"configCountryList"];
        
        
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray1 removeAllObjects];
        
        for (NSDictionary *dic in array) {
            WD4_arr1_model *model = [WD4_arr1_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        
        for (NSDictionary *dic in array1) {
            WD4_arr2_model *model = [WD4_arr2_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model];
        }
        
        
        if ([weakSelf.navigationItem.title isEqualToString:@"新增"]) {
            WD4_arr1_model *model = weakSelf.dataArray.firstObject;
            textfield1.text = model.typeCn;
            strid1 = model.id;
            WD4_arr2_model *model1 = weakSelf.dataArray1.firstObject;
            textfield2.text = model1.chineseName;
            strid2 = model1.id;
        }
        
        
        [weakSelf.tableview  reloadData];
        [weakSelf.tableview1 reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:textfield1]) {
        [textfield3 resignFirstResponder];
        [textfield4 resignFirstResponder];
        self.tableview1.hidden = YES;
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:textfield2]) {
        [textfield3 resignFirstResponder];
        [textfield4 resignFirstResponder];
        self.tableview.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    return YES;
}




- (void)setUpRightTextfield{
    for (int i = 0; i<7; i++) {
        UITextField *textf = [[UITextField alloc]initWithFrame:CGRectMake(100, 10+50*i, SCREEN_WIDTH-110, 30)];
        switch (i) {
            case 0:
                textfield1 = textf;
                break;
            case 1:
                textfield2 = textf;
                break;
            case 2:
                textfield3 = textf;
                break;
            case 3:
                textfield4 = textf;
                break;
            case 4:
                textfield5 = textf;
                break;
            case 5:
                textfield6 = textf;
                break;
            case 6:
                textfield7 = textf;
                break;
            default:
                break;
        }
        textf.borderStyle = UITextBorderStyleRoundedRect;
        textf.delegate = self;
        [scrollview addSubview:textf];
    }
}


- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"地址类型",@"国家",@"省份",@"城市",@"区县",@"地址",@"邮编"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 80, 30)];
        lable.text = arr[i];
        [scrollview addSubview:lable];
    }
}




- (NSMutableArray *)dataArray1{
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}



@end
