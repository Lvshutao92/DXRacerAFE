//
//  SK_search_threeViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SK_search_threeViewController.h"
#import "SK3ViewController.h"
#import "jxs1model.h"
#import "configCurrency_Model.h"
@interface SK_search_threeViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *ids1;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *selectedArray;


@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableview1;

@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)UITableView *tableview2;

@end

@implementation SK_search_threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.dataArray  = [@[@"定金",@"尾款"]mutableCopy];
    self.dataArray1 = [@[@"创建成功",@"确认支付",@"支付成功",@"支付失败",@"取消成功"]mutableCopy];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 170, SCREEN_WIDTH-100, 100)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:self.tableview];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(90, 230, SCREEN_WIDTH-100, 180)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(90, 290, SCREEN_WIDTH-100, 200)];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
    
    [self loddetails];
}


- (void)loddetails{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"order") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        // NSLog(@"dic = %@",dic);
        [weakSelf.dataArray2 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        for (NSDictionary *dic in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray2 addObject:model];
        }
        
        [weakSelf.tableview  reloadData];
        [weakSelf.tableview1 reloadData];
        [weakSelf.tableview2 reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = self.dataArray[indexPath.row];
        return cell;
    }
    
    else if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.textLabel.text = self.dataArray1[indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    jxs1model *model = [self.dataArray2 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.companyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        self.text2.text = self.dataArray[indexPath.row];
    }else if ([tableView isEqual:self.tableview1]) {
        self.text3.text = self.dataArray1[indexPath.row];
    }else if ([tableView isEqual:self.tableview2]) {
        jxs1model *model = [self.dataArray2 objectAtIndex:indexPath.row];
        self.text4.text = model.companyName;
        ids1 = model.id;
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
}





- (IBAction)clickBtnSearch:(id)sender {
    
    SK3ViewController *ploi = [[SK3ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.str1 = @"";
    }else{
        ploi.str1 = self.text1.text;
    }
    
    if (self.text2.text.length == 0) {
        ploi.str2 = @"";
    }else{
        if ([self.text2.text isEqualToString:@"定金"]) {
            ploi.str2 = @"Deposit";
        }else if ([self.text2.text isEqualToString:@"尾款"]){
            ploi.str2 = @"Retainage";
        }
    }
    
    
    if (self.text3.text.length == 0) {
        ploi.str3 = @"";
    }else{
        if ([self.text3.text isEqualToString:@"创建成功"]) {
            ploi.str3 = @"create";
        }else if ([self.text3.text isEqualToString:@"确认支付"]){
            ploi.str3 = @"confirm";
        }else if ([self.text3.text isEqualToString:@"支付成功"]){
            ploi.str3 = @"paysuccess";
        }else if ([self.text3.text isEqualToString:@"支付失败"]){
            ploi.str3 = @"payfail";
        }else if ([self.text3.text isEqualToString:@"取消成功"]){
            ploi.str3 = @"canceled";
        }
    }
    
    
    if (self.text4.text.length == 0) {
        ploi.str4 = @"";
    }else{
        ploi.str4 = ids1;
    }
    [self.navigationController pushViewController:ploi animated:YES];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.text2]) {
        [self.text1 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        self.tableview.hidden  = YES;
        self.tableview2.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text4]) {
        [self.text1 resignFirstResponder];
        self.tableview.hidden  = YES;
        self.tableview1.hidden = YES;
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
        return NO;
    }
    
    self.tableview.hidden  = YES;
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
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
- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}
@end
