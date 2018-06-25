//
//  WD_1_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WD_1_ViewController.h"
#import "WD1_arr1_model.h"
#import "WD1_arr2_model.h"
@interface WD_1_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    
    NSString *idstr1;
    NSString *idstr2;
}


@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;

@end



@implementation WD_1_ViewController

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
    
    [self setUpRightLable];
    
    [self setUpRightTextfield];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(100, 290, SCREEN_WIDTH-110, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(100, 340, SCREEN_WIDTH-110, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [scrollview addSubview:self.tableview1];
    
    [self lodData];
}

- (void)clickSave{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"scaleId":idstr1,
            @"durationId":idstr2,
            @"telephone":textfield3.text,
            @"website":textfield4.text,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerinfo",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"----%@",dic);
        
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"修改成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf lodData];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


















- (void)lodData{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerinfo",@"initpage") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        NSDictionary *dict = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfo"];
        
        lab1.text = [dict objectForKey:@"companyCode"];
        lab2.text = [dict objectForKey:@"companyName"];
        
        
        lab3.text = [[dict objectForKey:@"configCurrency"] objectForKey:@"currencyName"];
        lab4.text = [[dict objectForKey:@"configArea"] objectForKey:@"chineseName"];
        lab5.text = [[dict objectForKey:@"configCountry"] objectForKey:@"chineseName"];
        
        
        textfield3.text = [dict objectForKey:@"telephone"];
        textfield4.text = [dict objectForKey:@"website"];
        
        
        textfield1.text = [[dict objectForKey:@"configScale"] objectForKey:@"nameCn"];
        idstr1 = [[dict objectForKey:@"configScale"] objectForKey:@"id"];

        textfield2.text = [[dict objectForKey:@"configDuration"] objectForKey:@"nameCn"];
        idstr2 = [[dict objectForKey:@"configDuration"] objectForKey:@"id"];
        
        
        
        
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"configDurationList"];
        NSMutableArray *array1 = [[dic objectForKey:@"rows"] objectForKey:@"configScaleList"];
        
        
        [weakSelf.dataArray1 removeAllObjects];
        for (NSDictionary *dic in array) {
            WD1_arr1_model *model = [WD1_arr1_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model];
        }

        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array1) {
            WD1_arr2_model *model = [WD1_arr2_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.tableview  reloadData];
        [weakSelf.tableview1 reloadData];
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
        WD1_arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        textfield1.text = model.nameCn;
        idstr1 = model.id;
    }
    if ([tableView isEqual:self.tableview1]) {
        WD1_arr2_model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        
        textfield2.text = model.nameCn;
        idstr2 = model.id;
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WD1_arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.nameCn;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WD1_arr2_model *model = [self.dataArray1 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.nameCn;
    return cell;
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
    for (int i = 0; i<4; i++) {
        UITextField *textf = [[UITextField alloc]initWithFrame:CGRectMake(100, 260+50*i, SCREEN_WIDTH-110, 30)];
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
            default:
                break;
        }
        textf.borderStyle = UITextBorderStyleRoundedRect;
        textf.delegate = self;
        [scrollview addSubview:textf];
    }
}




- (void)setUpRightLable{
    for (int i = 0; i<5; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(100, 10+50*i, SCREEN_WIDTH-110, 30)];
        switch (i) {
            case 0:
                lab1 = lable;
                break;
            case 1:
                lab2 = lable;
                break;
            case 2:
                lab3 = lable;
                break;
            case 3:
                lab4 = lable;
                break;
            case 4:
                lab5 = lable;
                break;
            default:
                break;
        }
        [scrollview addSubview:lable];
    }
}







- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"公司编号",@"公司名称",@"货币类型",@"地区",@"国家",@"企业规模",@"经营年限",@"固定电话",@"网址"]mutableCopy];
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
