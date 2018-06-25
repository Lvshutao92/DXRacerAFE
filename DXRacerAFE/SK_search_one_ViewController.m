//
//  SK_search_one_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SK_search_one_ViewController.h"
#import "KSDatePicker.h"
#import "jxs1model.h"
#import "configCurrency_Model.h"
#import "SK1ViewController.h"
@interface SK_search_one_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *ids1;
    NSString *ids2;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *selectedArray;


@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableview1;

@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)UITableView *tableview2;



@end

@implementation SK_search_one_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    self.text6.delegate = self;
    
    self.dataArray2 = [@[@"待确认订单",@"已确认订单",@"生产中订单",@"待发货订单",@"已发货订单",@"已取消订单"]mutableCopy];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 260, SCREEN_WIDTH-100, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:self.tableview];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(90, 310, SCREEN_WIDTH-100, 100)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(90, 360, SCREEN_WIDTH-100, 150)];
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
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        for (NSDictionary *dic in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *arr1 = [[dic objectForKey:@"rows"] objectForKey:@"configCurrencyList"];
        for (NSDictionary *dic in arr1) {
            configCurrency_Model *model = [configCurrency_Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model];
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
        jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.companyName;
        //判断是否选中（选中单元格尾部打勾）
        if ([self.selectedArray containsObject:self.dataArray[indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    
    else if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        configCurrency_Model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.currencyCode;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray2[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        //判断该行原先是否选中
        jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *idarr = [NSMutableArray arrayWithCapacity:1];
        if ([self.selectedArray containsObject:model] == YES) {
            [self.selectedArray removeObject:model];
        }else{
            [self.selectedArray addObject:model];
        }
        [arr removeAllObjects];
        [idarr removeAllObjects];
        for (jxs1model *model in self.selectedArray) {
            [arr addObject:model.companyName];
            [idarr addObject:model.id];
        }
        self.text4.text = [arr componentsJoinedByString:@" "];
        ids1 = [idarr componentsJoinedByString:@","];
        ////刷新该行
        [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else if ([tableView isEqual:self.tableview1]) {
        configCurrency_Model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        self.text5.text = model.currencyCode;
        ids2 = model.id;
    }else if ([tableView isEqual:self.tableview2]) {
        self.text6.text = self.dataArray2[indexPath.row];
    }
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
}



- (IBAction)clicksearch:(id)sender {
    
    SK1ViewController *ploi = [[SK1ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.str1 = @"";
    }else{
        ploi.str1 = self.text1.text;
    }
    
    if (self.text2.text.length == 0) {
        ploi.str2 = @"";
    }else{
        ploi.str2 = self.text2.text;
    }
    
    if (self.text3.text.length == 0) {
        ploi.str3 = @"";
    }else{
        ploi.str3 = self.text3.text;
    }
    
    if (self.text4.text.length == 0) {
        ploi.str4 = @"";
    }else{
        ploi.str4 = ids1;
    }
    
    if (self.text5.text.length == 0) {
        ploi.str5 = @"";
    }else{
        ploi.str5 = ids2;
    }
    
    
    if (self.text6.text.length == 0) {
        ploi.str6 = @"";
    }else{
        if ([self.text6.text isEqualToString:@"待确认订单"]) {
            ploi.str6 = @"confirm";
        }else if ([self.text6.text isEqualToString:@"已确认订单"]){
            ploi.str6 = @"confirmed";
        }else if ([self.text6.text isEqualToString:@"生产中订单"]){
            ploi.str6 = @"production";
        }else if ([self.text6.text isEqualToString:@"待发货订单"]){
            ploi.str6 = @"undelivery";
        }else if ([self.text6.text isEqualToString:@"已发货订单"]){
            ploi.str6 = @"delivery";
        }else if ([self.text6.text isEqualToString:@"已取消订单"]){
            ploi.str6 = @"cancel";
        }
    }
    
    [self.navigationController pushViewController:ploi animated:YES];
    
}







- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text2]) {
        [self.text1 resignFirstResponder];
        self.tableview.hidden  = YES;
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                self.text2.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        self.tableview.hidden  = YES;
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                self.text3.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text4]) {
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
    if ([textField isEqual:self.text5]) {
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
    if ([textField isEqual:self.text6]) {
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
- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        self.selectedArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectedArray;
}
@end
