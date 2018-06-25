//
//  JXS_Add_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/6.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_Add_ViewController.h"
#import "configArea_Model.h"

#import "configCurrency_Model.h"
#import "configDuration_Model.h"
#import "configScale_Model.h"
@interface JXS_Add_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    UILabel *lab6;
    UILabel *lab7;
    UILabel *lab8;
    UILabel *lab9;
    UILabel *lab10;
    
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    UITextField *textfield7;
    UITextField *textfield8;
    UITextField *textfield9;
    UITextField *textfield10;
    
    
    NSString *idstr1;
    NSString *idstr2;
    NSString *idstr3;
    NSString *idstr4;
    NSString *idstr5;
}
@property(nonatomic,strong)UIScrollView *scrollview;

@property(nonatomic,strong)NSMutableArray *Array1;
@property(nonatomic,strong)NSMutableArray *Array2;
@property(nonatomic,strong)NSMutableArray *Array3;
@property(nonatomic,strong)NSMutableArray *Array4;
@property(nonatomic,strong)NSMutableArray *Array5;

@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)UITableView *tableview2;
@property(nonatomic,strong)UITableView *tableview3;
@property(nonatomic,strong)UITableView *tableview4;
@property(nonatomic,strong)UITableView *tableview5;

@end

@implementation JXS_Add_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-10)];
    self.scrollview.contentSize = CGSizeMake(0, 750);
    [self.view addSubview:self.scrollview];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    
    
//    self.Array1 = [@[@"亚洲",@"中美洲",@"CIS",@"欧洲",@"中东",@"北美洲",@"大洋洲",@"南美洲",@"东南亚"]mutableCopy];
    
//    self.Array3 = [@[@"RMB",@"USD"]mutableCopy];
//    self.Array4 = [@[@"1-49",@"50-99",@"100-199",@"200-299",@"300-"]mutableCopy];
//    self.Array5 = [@[@"1-3",@"4-9",@"10-19",@"20-29",@"30-39",@"40-99",@"100-"]mutableCopy];
    
    [self setUpView];
    
    textfield1.text  = self.str1;
    textfield2.text  = self.str2;
    textfield3.text  = self.str3;
    textfield4.text  = self.str4;
    textfield5.text  = self.str5;
    
    textfield6.text  = self.str6;
    textfield7.text  = self.str7;
    textfield8.text  = self.str8;
    textfield9.text  = self.str9;
    textfield10.text = self.str10;
    
    
    idstr1 = self.str3id;
    idstr2 = self.str4id;
    idstr3 = self.str5id;
    idstr4 = self.str8id;
    idstr5 = self.str9id;
    
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(100, 170, SCREEN_WIDTH-120, 250)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    self.tableview1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview1.layer.borderWidth = 1.0;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.scrollview addSubview:self.tableview1];
    [self.scrollview bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]init];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    self.tableview2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview2.layer.borderWidth = 1.0;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.scrollview addSubview:self.tableview2];
    [self.scrollview bringSubviewToFront:self.tableview2];
    
    
    self.tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(100, 290, SCREEN_WIDTH-120, 100)];
    self.tableview3.delegate = self;
    self.tableview3.dataSource = self;
    self.tableview3.hidden = YES;
    self.tableview3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview3.layer.borderWidth = 1.0;
    [self.tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.scrollview addSubview:self.tableview3];
    [self.scrollview bringSubviewToFront:self.tableview3];
    
    self.tableview4 = [[UITableView alloc]initWithFrame:CGRectMake(100, 470, SCREEN_WIDTH-120, 120)];
    self.tableview4.delegate = self;
    self.tableview4.dataSource = self;
    self.tableview4.hidden = YES;
    self.tableview4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview4.layer.borderWidth = 1.0;
    [self.tableview4 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell4"];
    [self.scrollview addSubview:self.tableview4];
    [self.scrollview bringSubviewToFront:self.tableview4];
    
    self.tableview5 = [[UITableView alloc]initWithFrame:CGRectMake(100, 530, SCREEN_WIDTH-120, 120)];
    self.tableview5.delegate = self;
    self.tableview5.dataSource = self;
    self.tableview5.hidden = YES;
    self.tableview5.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview5.layer.borderWidth = 1.0;
    [self.tableview5 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell5"];
    [self.scrollview addSubview:self.tableview5];
    [self.scrollview bringSubviewToFront:self.tableview5];
    
    
    [self lodinformation];
   
}



- (void)clickSave{
    if (textfield6.text == nil) {
        textfield6.text = @"";
    }
    if (textfield7.text == nil) {
        textfield7.text = @"";
    }
    if (textfield10.text == nil) {
        textfield10.text = @"";
    }
    
    if (idstr1 == nil) {
        idstr1 = @"";
    }
    if (idstr2 == nil) {
        idstr2 = @"";
    }
    if (idstr3 == nil) {
        idstr3 = @"";
    }
    if (idstr4 == nil) {
        idstr4 = @"";
    }
    if (idstr5 == nil) {
        idstr5 = @"";
    }
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
       
        if (textfield1.text.length != 0 && textfield2.text.length != 0) {
            [self lodadd];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"公司名称及编号不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        if (textfield1.text.length != 0 && textfield2.text.length != 0) {
            [self lopdedit];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"公司名称及编号不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    
}






- (void)lopdedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"status":@"created",
            
            @"companyCode":textfield1.text,
            @"companyName":textfield2.text,
            @"areaId":idstr1,
            @"countryId":idstr2,
            @"currencyId":idstr3,
            
            @"rememberCode":textfield6.text,
            @"website":textfield7.text,
            @"scaleId":idstr4,
            @"durationId":idstr5,
            @"telephone":textfield10.text,
            
            @"id":self.idstr,
            };
    //    NSLog(@"%@--%@",textfield4.text,idstr2);
    [session POST:KURLNSString2(@"servlet", @"dealer",@"manager",@"dealerinfo/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑成功😊" preferredStyle:1];
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
            @"status":@"created",
            
            @"companyCode":textfield1.text,
            @"companyName":textfield2.text,
            @"areaId":idstr1,
            @"countryId":idstr2,
            @"currencyId":idstr3,
            
            @"rememberCode":textfield6.text,
            @"website":textfield7.text,
            @"scaleId":idstr4,
            @"durationId":idstr5,
            @"telephone":textfield10.text,
            };
//    NSLog(@"%@--%@",textfield4.text,idstr2);
    [session POST:KURLNSString2(@"servlet", @"dealer",@"manager",@"dealerinfo/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新增成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

















- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.Array1.count;
    }
    if ([tableView isEqual:self.tableview2]) {
        return self.Array2.count;
    }
    if ([tableView isEqual:self.tableview3]) {
        return self.Array3.count;
    }
    if ([tableView isEqual:self.tableview4]) {
        return self.Array4.count;
    }
    
    return self.Array5.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        configArea_Model *model = [self.Array1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.chineseName;
        return cell;
    }
    if ([tableView isEqual:self.tableview2]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        configArea_Model *model = [self.Array2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.chineseName;
        return cell;
    }
    if ([tableView isEqual:self.tableview3]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        configCurrency_Model *model = [self.Array3 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.currencyCode;
        return cell;
    }
    if ([tableView isEqual:self.tableview4]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        configDuration_Model *model = [self.Array4 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.nameCn;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
    configScale_Model *model = [self.Array5 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.nameCn;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview1]) {
        
        textfield4.text = nil;
        idstr2 = nil;
        
        
        configArea_Model *model = [self.Array1 objectAtIndex:indexPath.row];
        textfield3.text = model.chineseName;
        idstr1 = model.id;
        [self lodcountry:model.id];

    }
    else if ([tableView isEqual:self.tableview2]) {
        configArea_Model *model = [self.Array2 objectAtIndex:indexPath.row];
        textfield4.text = model.chineseName;
        idstr2 = model.id;
    }
    else if ([tableView isEqual:self.tableview3]) {
        configCurrency_Model *model = [self.Array3 objectAtIndex:indexPath.row];
        textfield5.text = model.currencyCode;
        idstr3 = model.id;
    }
    else if ([tableView isEqual:self.tableview4]) {
        configDuration_Model *model = [self.Array4 objectAtIndex:indexPath.row];
        textfield8.text = model.nameCn;
        idstr4 = model.id;
    }
    else if ([tableView isEqual:self.tableview5]) {
        configScale_Model *model = [self.Array5 objectAtIndex:indexPath.row];
        textfield9.text = model.nameCn;
        idstr5 = model.id;
    }
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    self.tableview4.hidden = YES;
    self.tableview5.hidden = YES;
}





- (void)lodcountry:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"areaId":idstr,
            };
    [session POST:KURLNSString2(@"servlet", @"config",@"configcountry",@"all") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
        [weakSelf.Array2 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dic in arr) {
            configArea_Model *model = [configArea_Model mj_objectWithKeyValues:dic];
            [weakSelf.Array2 addObject:model];
            
        }
                CGFloat height;
                height = weakSelf.Array2.count * 44;
                if (200 < height) {
                    height = 200;
                }else{
                    height = weakSelf.Array2.count * 44;
                }
                weakSelf.tableview2.frame = CGRectMake(100, 230, SCREEN_WIDTH-120, height);
                [weakSelf.tableview2 reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}







- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer",@"manager",@"dealerinfo",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        
         [weakSelf.Array1 removeAllObjects];
         [weakSelf.Array3 removeAllObjects];
         [weakSelf.Array4 removeAllObjects];
         [weakSelf.Array5 removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"configAreaList"];
        for (NSDictionary *dic in arr) {
            configArea_Model *model = [configArea_Model mj_objectWithKeyValues:dic];
            [weakSelf.Array1 addObject:model];
        }
        
        NSMutableArray *arr3 = [[dic objectForKey:@"rows"] objectForKey:@"configCurrencyList"];
        for (NSDictionary *dic in arr3) {
            configCurrency_Model *model = [configCurrency_Model mj_objectWithKeyValues:dic];
            [weakSelf.Array3 addObject:model];
        }
        
        NSMutableArray *arr4 = [[dic objectForKey:@"rows"] objectForKey:@"configDurationList"];
        for (NSDictionary *dic in arr4) {
            configDuration_Model *model = [configDuration_Model mj_objectWithKeyValues:dic];
            [weakSelf.Array4 addObject:model];
        }
        
        NSMutableArray *arr5 = [[dic objectForKey:@"rows"] objectForKey:@"configScaleList"];
        for (NSDictionary *dic in arr5) {
            configScale_Model *model = [configScale_Model mj_objectWithKeyValues:dic];
            [weakSelf.Array5 addObject:model];
        }
        
        
        [weakSelf.tableview1 reloadData];
        [weakSelf.tableview3 reloadData];
        [weakSelf.tableview4 reloadData];
        [weakSelf.tableview5 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:textfield3]) {
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        self.tableview5.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:textfield4]) {
        self.tableview1.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        self.tableview5.hidden = YES;
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:textfield5]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        self.tableview4.hidden = YES;
        self.tableview5.hidden = YES;
        if (self.tableview3.hidden == YES) {
            self.tableview3.hidden = NO;
        }else{
            self.tableview3.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:textfield8]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview5.hidden = YES;
        if (self.tableview4.hidden == YES) {
            self.tableview4.hidden = NO;
        }else{
            self.tableview4.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:textfield9]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        if (self.tableview5.hidden == YES) {
            self.tableview5.hidden = NO;
        }else{
            self.tableview5.hidden = YES;
        }
        return NO;
    }
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    self.tableview4.hidden = YES;
    self.tableview5.hidden = YES;
    return YES;
}


- (void)setUpView{
    
    
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 40)];
    lab1.text = @"公司编号";
    [self.scrollview addSubview:lab1];
    textfield1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-120, 40)];
    textfield1.delegate = self;
    textfield1.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 90, 40)];
    lab2.text = @"公司名称";
    [self.scrollview addSubview:lab2];
    textfield2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 70, SCREEN_WIDTH-120, 40)];
    textfield2.delegate = self;
    textfield2.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 40)];
    lab3.text = @"区域";
    [self.scrollview addSubview:lab3];
    textfield3 = [[UITextField alloc]initWithFrame:CGRectMake(100, 130, SCREEN_WIDTH-120, 40)];
    textfield3.delegate = self;
    textfield3.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield3.placeholder = @"请选择";
    textfield3.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield3];

    lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, 90, 40)];
    lab4.text = @"国家";
    [self.scrollview addSubview:lab4];
    textfield4 = [[UITextField alloc]initWithFrame:CGRectMake(100, 190, SCREEN_WIDTH-120, 40)];
    textfield4.delegate = self;
    textfield4.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield4.placeholder = @"请选择";
    textfield4.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield4];
    
    lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 90, 40)];
    lab5.text = @"货币类型";
    [self.scrollview addSubview:lab5];
    textfield5 = [[UITextField alloc]initWithFrame:CGRectMake(100, 250, SCREEN_WIDTH-120, 40)];
    textfield5.delegate = self;
    textfield5.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield5.placeholder = @"请选择";
    textfield5.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield5];
    
    
    lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, 90, 40)];
    lab6.text = @"助记码";
    [self.scrollview addSubview:lab6];
    textfield6 = [[UITextField alloc]initWithFrame:CGRectMake(100, 310, SCREEN_WIDTH-120, 40)];
    textfield6.delegate = self;
    textfield6.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield6];
    
    lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 370, 90, 40)];
    lab7.text = @"网址";
    [self.scrollview addSubview:lab7];
    textfield7 = [[UITextField alloc]initWithFrame:CGRectMake(100, 370, SCREEN_WIDTH-120, 40)];
    textfield7.delegate = self;
    textfield7.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield7];
    
    lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 430, 90, 40)];
    lab8.text = @"企业规模";
    [self.scrollview addSubview:lab8];
    textfield8 = [[UITextField alloc]initWithFrame:CGRectMake(100, 430, SCREEN_WIDTH-120, 40)];
    textfield8.delegate = self;
    textfield8.placeholder = @"请选择";
    textfield8.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield8.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield8];
    
    lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 490, 90, 40)];
    lab9.text = @"经营年限";
    [self.scrollview addSubview:lab9];
    textfield9 = [[UITextField alloc]initWithFrame:CGRectMake(100, 490, SCREEN_WIDTH-120, 40)];
    textfield9.delegate = self;
    
    textfield9.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield9.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield9];
    textfield9.placeholder = @"请选择";
    lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 550, 90, 40)];
    lab10.text = @"固定电话";
    [self.scrollview addSubview:lab10];
    textfield10 = [[UITextField alloc]initWithFrame:CGRectMake(100, 550, SCREEN_WIDTH-120, 40)];
    textfield10.delegate = self;
    textfield10.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield10];
    
}

- (NSMutableArray *)Array1{
    if (_Array1 == nil) {
        self.Array1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array1;
}
- (NSMutableArray *)Array2{
    if (_Array2 == nil) {
        self.Array2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array2;
}
- (NSMutableArray *)Array3{
    if (_Array3 == nil) {
        self.Array3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array3;
}
- (NSMutableArray *)Array4{
    if (_Array4 == nil) {
        self.Array4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array4;
}
- (NSMutableArray *)Array5{
    if (_Array5 == nil) {
        self.Array5 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array5;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
