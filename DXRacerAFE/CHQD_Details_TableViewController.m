//
//  CHQD_Details_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/9.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CHQD_Details_TableViewController.h"
#import "CHGL_details_Cell.h"
#import "CHGL_Model.h"
#import "resultmodel.h"

#import "KSDatePicker.h"
@interface CHQD_Details_TableViewController ()<UITextFieldDelegate>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
}
@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;

@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UITableView *tableView2;
@end

@implementation CHQD_Details_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"CHGL_details_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
    self.tableView.tableHeaderView = view;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 208, SCREEN_WIDTH, 2)];
    line.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [view addSubview:line];
    
    NSMutableArray *arr = [@[@"收货信息",@"承运信息",@"提货车牌号",@"申请出货日期"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, (i+1)*10+40*i, 115, 40)];
        lab.text = arr[i];
        [view addSubview:lab];
    }
    for (int i=0; i<4; i++) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(125, (i+1)*10+40*i, SCREEN_WIDTH-135, 40)];
        switch (i) {
            case 0:
                text1 = textfield;
                textfield.placeholder = @"请选择";
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 1:
                text2 = textfield;
                textfield.placeholder = @"请选择";
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 2:
                text3 = textfield;
                textfield.placeholder = @"请填写车牌号";
                break;
            case 3:
                text4 = textfield;
                textfield.placeholder = @"请选择";
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            default:
                break;
        }
        textfield.delegate = self;
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [view addSubview:textfield];
    }
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(125, 50, SCREEN_WIDTH-135, 200)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.hidden = YES;
    [self.tableView1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableView1.layer setBorderWidth:1];
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView1];
    
    
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(125, 100, SCREEN_WIDTH-135, 200)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.hidden = YES;
    [self.tableView2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableView2.layer setBorderWidth:1];
    [self.tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableView2];
    
    
    [self lodTopDetail];
    
    
    [self lodDetailsList];
}

- (void)lodTopDetail{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"shipment/zh_cn",@"apply",@"previewtext")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerAddressList"];
        for (NSDictionary *dict in arr) {
            CHGL_Model *model = [CHGL_Model mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        
        [weakSelf.dataArray2 removeAllObjects];
        NSMutableArray *arr2 = [[dic objectForKey:@"rows"] objectForKey:@"dealerLogisticList"];
        for (NSDictionary *dict in arr2) {
            CHGL_Model *model = [CHGL_Model mj_objectWithKeyValues:dict];
            resultmodel *model1 = [resultmodel mj_objectWithKeyValues:model.configLogistic];
            model.configLogisticmodel = model1;
            [weakSelf.dataArray2 addObject:model];
        }
        
        [weakSelf.tableView1 reloadData];
        [weakSelf.tableView2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}







- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:text1]) {
        self.tableView2.hidden = YES;
        [text3 resignFirstResponder];
        if (self.tableView1.hidden == YES) {
            self.tableView1.hidden = NO;
        }else{
            self.tableView1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:text2]) {
        self.tableView1.hidden = YES;
        [text3 resignFirstResponder];
        if (self.tableView2.hidden == YES) {
            self.tableView2.hidden = NO;
        }else{
            self.tableView2.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:text4]) {
        self.tableView1.hidden = YES;
        self.tableView2.hidden = YES;
        [text3 resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                text4.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    self.tableView1.hidden = YES;
    self.tableView2.hidden = YES;
    return YES;
}

//提交
- (void)clickSave{
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"orderIds":self.orderId,
                @"address":text1.text,
                @"logistics":text2.text,
                @"cardNo":text3.text,
                @"planShipmentDate":text4.text,
                };
        [session POST:KURLNSString2(@"servlet", @"shipment", @"zh_cn",@"apply/submit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //NSLog(@"%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"提交成功" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"提交失败" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
   
    
}









- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView1]) {
        CHGL_Model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        text1.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",model.receiveProvince,model.receiveCity,model.receiveArea,model.receiveAddress,model.zip];
    }else if ([tableView isEqual:self.tableView2]){
        CHGL_Model *model = [self.dataArray2 objectAtIndex:indexPath.row];
        text2.text = [NSString stringWithFormat:@"%@ %@ %@",model.configLogisticmodel.logisticName,model.person,model.mobile];
    }
    self.tableView1.hidden = YES;
    self.tableView2.hidden = YES;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableView1]) {
        return self.dataArray1.count;
    }else if ([tableView isEqual:self.tableView2]){
        return self.dataArray2.count;
    }
    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView1]) {
        return 70;
    }else if ([tableView isEqual:self.tableView2]){
        return 60;
    }
    return 175;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView1]) {
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CHGL_Model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",model.receiveProvince,model.receiveCity,model.receiveArea,model.receiveAddress,model.zip];
        cell.textLabel.numberOfLines = 0;
        return cell;
    }else if ([tableView isEqual:self.tableView2]){
        static NSString *identifierCell = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CHGL_Model *model = [self.dataArray2 objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.configLogisticmodel.logisticName,model.person,model.mobile];
        cell.textLabel.numberOfLines = 0;
        return cell;
    }
    
    static NSString *identifierCell = @"cell";
    CHGL_details_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[CHGL_details_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CHGL_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.searchOrderNo;
    cell.lab2.text = model.productCode;
    cell.lab3.text = model.searchResultmodel.product;
    cell.lab4.text = model.searchResultmodel.chineseName;
    cell.lab5.text = model.quantity;
    return cell;
}
-(void)lodDetailsList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"ids":self.orderId,
            };
    [session POST:KURLNSString2(@"servlet", @"shipment",@"zh_cn",@"apply/detail")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//         NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"orderItemResult"];
        for (NSDictionary *dict in arr) {
            CHGL_Model *model = [CHGL_Model mj_objectWithKeyValues:dict];
            
            resultmodel *model1 = [resultmodel mj_objectWithKeyValues:model.searchResult];
            model.searchResultmodel = model1;
            
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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
