//
//  XHQD_Lookdetails_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XHQD_Lookdetails_TableViewController.h"
#import "CHGL_details_Cell.h"
#import "CHGL_Model.h"
#import "resultmodel.h"
#import "Pic_Cell.h"
#import "KSDatePicker.h"

@interface XHQD_Lookdetails_TableViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UITextField *lab1;
    UITextField *lab2;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    
    UILabel *label;
}
@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;

@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UITableView *tableView2;


@property(nonatomic, strong)UICollectionView *collectionview;
@property(nonatomic, strong)NSMutableArray *imgdataArray;

@property(nonatomic, strong)NSMutableArray *orderArray;
@end

@implementation XHQD_Lookdetails_TableViewController
- (NSMutableArray *)imgdataArray {
    if (_imgdataArray == nil) {
        self.imgdataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgdataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"CHGL_details_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIView *view = [[UIView alloc]init];
    if ([self.str2 isEqualToString:@"已完成"]) {
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 420);
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 418, SCREEN_WIDTH, 2)];
        line.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
        [view addSubview:line];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 305, SCREEN_WIDTH-10, 20)];
        lab.text = @"出货照片";
        [view addSubview:lab];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(80, 90);
        //最小行间距(默认为10)
        layout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        layout.minimumInteritemSpacing = 10;
        //设置senction的内边距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        // 设置滚动方向（默认垂直滚动）
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 325, SCREEN_WIDTH, 90) collectionViewLayout:layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor colorWithWhite:.9 alpha:.15];
        [_collectionview registerClass:[Pic_Cell class] forCellWithReuseIdentifier:@"cella"];
        [view addSubview:_collectionview];
       
    }else if ([self.str2 isEqualToString:@"已申请"]) {
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 500);
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 498, SCREEN_WIDTH, 2)];
        line.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
        [view addSubview:line];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 398, SCREEN_WIDTH, 2)];
        line1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
        [view addSubview:line1];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 305, SCREEN_WIDTH-20, 60)];
        lab.text = @"待付款订单(温馨提示：请于申请出货日期之前及时支付剩余货款，以免影响出货)";
        lab.numberOfLines = 0;
        [view addSubview:lab];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 365, SCREEN_WIDTH-20, 30)];
//        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor redColor];
        [view addSubview:label];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(300, 90);
        //最小行间距(默认为10)
        layout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        layout.minimumInteritemSpacing = 10;
        //设置senction的内边距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        // 设置滚动方向（默认垂直滚动）
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 90) collectionViewLayout:layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor colorWithWhite:.9 alpha:.15];
        [_collectionview registerClass:[Pic_Cell class] forCellWithReuseIdentifier:@"cellb"];
        [view addSubview:_collectionview];
        
        
    }else{
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 315);
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 313, SCREEN_WIDTH, 2)];
        line.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
        [view addSubview:line];
    }
    self.tableView.tableHeaderView = view;
    
    
    NSMutableArray *arr = [@[@"出货单号",@"单据状态",@"收货信息",@"承运信息",@"提货车牌号",@"申请出货日期"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, (i+1)*10+40*i, 115, 40)];
        lab.text = arr[i];
        [view addSubview:lab];
    }
    
    for (int i=0; i<6; i++) {
        UITextField *textfield = [[UITextField alloc]init];
        if (i>1) {
            textfield.frame = CGRectMake(125, (i+1)*10+40*i, SCREEN_WIDTH-175, 40);
        }else{
            textfield.frame = CGRectMake(125, (i+1)*10+40*i, SCREEN_WIDTH-135, 40);
        }
        switch (i) {
            case 0:
                lab1 = textfield;
                lab1.text = self.str1;
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 1:
                lab2 = textfield;
                lab2.text = self.str2;
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
                
            case 2:
                text1 = textfield;
                textfield.text = self.string1;
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 3:
                text2 = textfield;
                textfield.text = self.string2;
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 4:
                text3 = textfield;
                textfield.text = self.string3;
                break;
            case 5:
                text4 = textfield;
                textfield.text = self.string4;
                textfield.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            default:
                break;
        }
        textfield.delegate = self;
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [view addSubview:textfield];
    }
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(SCREEN_WIDTH-40, 120, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click_one_btn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(SCREEN_WIDTH-40, 170, 30, 30);
    [btn2 setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click_two_btn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(SCREEN_WIDTH-40, 220, 30, 30);
    [btn3 setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(click_three_btn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(SCREEN_WIDTH-40, 270, 30, 30);
    [btn4 setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(click_four_btn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn4];
    
    
    
    
    
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(125, 150, SCREEN_WIDTH-135, 200)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.hidden = YES;
    [self.tableView1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableView1.layer setBorderWidth:1];
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView1];
    
    
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(125, 200, SCREEN_WIDTH-135, 200)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.hidden = YES;
    [self.tableView2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableView2.layer setBorderWidth:1];
    [self.tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableView2];
    
    
    [self lodTopDetail];
    
    
    
    
    
    
    
}


#pragma mark---------UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark---------UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.str2 isEqualToString:@"已完成"]){
        return self.imgdataArray.count;
    }
    return self.orderArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.str2 isEqualToString:@"已申请"]){
        Pic_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellb" forIndexPath:indexPath];
        cell.imageView.hidden = YES;
        cell.label2.hidden = NO;
        cell.label1.hidden = NO;
        resultmodel *model = [self.orderArray objectAtIndex:indexPath.row];
        cell.label1.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
        cell.label2.text = [NSString stringWithFormat:@"金额：%@%.02f",model.currencyPoint,[model.totalFee floatValue]];
        return cell;
    }

    Pic_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cella" forIndexPath:indexPath];
    NSString *str = self.imgdataArray[indexPath.row];
    cell.imageView.hidden = NO;
    cell.label2.hidden = YES;
    cell.label1.hidden = YES;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:NSString(str)]];
    return cell;
}




- (NSMutableArray *)orderArray{
    if (_orderArray == nil) {
        self.orderArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _orderArray;
}



































- (void)lodTopDetail{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":self.orderId,
            };
    [session POST:KURLNSString2(@"servlet", @"shipment/zh_cn",@"all/detail",@"pagetext")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
        
        
        [weakSelf.orderArray removeAllObjects];
        NSMutableArray *arrpay = [[dic objectForKey:@"rows"] objectForKey:@"paymentList"];
        for (NSDictionary *dict in arrpay) {
            resultmodel *model = [resultmodel mj_objectWithKeyValues:dict];
            [weakSelf.orderArray addObject:model];
        }
        label.text = [[dic objectForKey:@"rows"]objectForKey:@"totalFee"];
        
        NSMutableArray *arr3 = [[dic objectForKey:@"rows"] objectForKey:@"orderList"];
        if (arr3.count != 0) {
            NSString  *ids = @"";
            for (NSDictionary *dict in arr3) {
                resultmodel *model = [resultmodel mj_objectWithKeyValues:dict];
                ids = [ids stringByAppendingString:[NSString stringWithFormat:@",%@",model.id]];
            }
            [weakSelf lodDetailsList:[ids substringFromIndex:1]];
        }
        
        
        weakSelf.imgdataArray = [[dic objectForKey:@"rows"] objectForKey:@"picArray"];
//        NSLog(@"++++++++++%ld",self.imgdataArray.count);
        [weakSelf.collectionview reloadData];
        [weakSelf.tableView1 reloadData];
        [weakSelf.tableView2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}







- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:lab1]){
        return NO;
    }
    if ([textField isEqual:lab2]){
        return NO;
    }
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
- (void)click_one_btn{
    if (text1.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"id":self.orderId,
                @"attrName":@"address",
                @"attrValue":text1.text,
                };
        [session POST:KURLNSString2(@"servlet", @"shipment", @"zh_cn",@"all/detail/edit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
}

- (void)click_two_btn{
    if (text2.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"id":self.orderId,
                @"attrName":@"logistics",
                @"attrValue":text2.text,
                };
        [session POST:KURLNSString2(@"servlet", @"shipment", @"zh_cn",@"all/detail/edit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
}
- (void)click_three_btn{
    if (text3.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"id":self.orderId,
                @"attrName":@"cardNo",
                @"attrValue":text3.text,
                };
        [session POST:KURLNSString2(@"servlet", @"shipment", @"zh_cn",@"all/detail/edit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
}
- (void)click_four_btn{
    if (text4.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"id":self.orderId,
                @"attrName":@"shipmentDate",
                @"attrValue":text4.text,
                };
        [session POST:KURLNSString2(@"servlet", @"shipment", @"zh_cn",@"all/detail/edit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
-(void)lodDetailsList:(NSString *)ids{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"ids":ids,
            };
    [session POST:KURLNSString2(@"servlet", @"shipment",@"zh_cn",@"apply/detail")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
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
