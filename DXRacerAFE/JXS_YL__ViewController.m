//
//  JXS_YL__ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_YL__ViewController.h"
#import "OR_YL_Cell.h"

#import "JXS_SH3model.h"
#import "JXSCartmodel.h"
#import "JXSCurrencymodel.h"
#import "JXSGoodsExchangeRatemodel.h"
#import "JXSPartsmodel.h"

#import "TopinformationModel.h"

#import "JXS_SH_4_ViewController.h"

#import "Piliang_Yulan_Cell.h"

@interface JXS_YL__ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    UIButton *btn1;
    
    float hhhhh;
    UILabel *llll;
    TYAlertView *alertView;
    
    NSString *idstring;
    
    
    NSString *str;
    UIButton *button;
    
    UILabel *bglab;
    UIImageView *imagev;
    UILabel *labels;
}

@property(nonatomic, strong)NSMutableArray *idarray;

@property(nonatomic,strong)UITableView *tableview;


@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;

@property(nonatomic, strong)NSMutableArray *weightArray;


@end

@implementation JXS_YL__ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"f6", nil);
    
   
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"Piliang_Yulan_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    str = @"";
    for (JXS_SH3model *model in self.dataArray) {
        if (model.model4.weight.length == 0 || [model.model4.weight isEqual:[NSNull null]]) {
            model.model4.weight = @"0";
        }
        [self.idarray addObject:[NSString stringWithFormat:@"%@",model.id]];
        
        
        str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",model.id]];
        [self.weightArray addObject:model.model4.weight];
    }
    
    
    
    
    for (NSString *str in self.weightArray) {
        float weight = [str floatValue];
        hhhhh = hhhhh + weight;
    }
    

    
    
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    if (![[Manager redingwenjianming:@"dealerType.text"] isEqualToString:@"IN"]) {
        self.tableview.tableHeaderView = vie;
    }
    
    
    
    bglab  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    bglab.backgroundColor = RGBACOLOR(251, 111, 110, 1);
    [vie addSubview:bglab];
    
    
    imagev = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    imagev.image = [UIImage imageNamed:@"gong"];
    imagev.contentMode = UIViewContentModeScaleAspectFit;
    [vie addSubview:imagev];
    
    labels = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, SCREEN_WIDTH-70, 60)];
    labels.textColor = [UIColor whiteColor];
    labels.font = [UIFont systemFontOfSize:12];
    labels.numberOfLines = 0;
    labels.text = [NSString stringWithFormat:@"%@%.02f%@",NSLocalizedString(@"x10", nil),hhhhh,NSLocalizedString(@"x11", nil)];
    [vie addSubview:labels];
    
    
    UIImageView *imagevie = [[UIImageView alloc]initWithFrame:CGRectMake(10, 72.5, 45, 45)];
    imagevie.image = [UIImage imageNamed:@"jzx"];
    imagevie.contentMode = UIViewContentModeScaleAspectFit;
    [vie addSubview:imagevie];
    
    
   
    
    self.textfield  = [[UITextField alloc]initWithFrame:CGRectMake(60, 70, SCREEN_WIDTH-60, 50)];
    self.textfield.delegate = self;
    self.textfield.borderStyle = UITextBorderStyleNone;
    [vie addSubview:self.textfield];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 80, 30, 30)];
    imageview.image = [UIImage imageNamed:@"jiantou"];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [vie addSubview:imageview];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableview addSubview:self.tableview1];
    [self.tableview bringSubviewToFront:self.tableview1];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 119, SCREEN_WIDTH, 1)];
    lab.backgroundColor = [UIColor colorWithWhite:.55 alpha:.5];
    [vie addSubview:lab];
    
    
    
    [self lodtopinformation];
    [self setuobotuminformation];
    
    llll = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH-100, 50)];
    
    llll.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    llll.font = [UIFont systemFontOfSize:12];
    llll.numberOfLines = 0;
    llll.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:llll];
    [self.view bringSubviewToFront:llll];
    
    
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-50, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:NSLocalizedString(@"submit", nil) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cliccommitorder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
}
- (void)setuobotuminformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    //    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"loginId":[Manager redingwenjianming:@"loginId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"batch", @"batchshoppingcart",@"preview") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [[Manager returndictiondata:responseObject] objectForKey:@"dealerPayment"];
        NSString *str1 = [dic objectForKey:@"paymentType"];
        if ([str1 isEqualToString:@"T/T"]) {
            NSString *str2 = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"proportion"]];
            NSString *str3 = [NSString stringWithFormat:@"%.02f%%",100 - [str2 floatValue]];
            NSString *str4 = [dic objectForKey:@"retainageType"];
            NSString *str5;
            if ([str4 isEqualToString:@"after"]) {
                str5 = NSLocalizedString(@"x16", nil);
            }else{
                str5 = NSLocalizedString(@"x15", nil);
            }
            llll.text = [NSString stringWithFormat:@"%@:T/T, %@:%@, %@:%@  %@",NSLocalizedString(@"x12", nil),NSLocalizedString(@"x13", nil),str2,NSLocalizedString(@"x14", nil),str3,str5];
        }else if ([str1 isEqualToString:@"L/C"]){
            llll.text = [NSString stringWithFormat:@"%@:L/C",NSLocalizedString(@"x12", nil)];
        }else{
            llll.text = @"无设置付款方式，无法提交订单";
            llll.textAlignment = NSTextAlignmentLeft;
            button.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)cliccommitorder{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"submit", nil) preferredStyle:1];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"userId":[Manager redingwenjianming:@"loginId.text"],
                @"dealerType":[Manager redingwenjianming:@"dealerType.text"],
                @"id1":[str substringFromIndex:1],
                };
        if (![[Manager redingwenjianming:@"dealerType.text"] isEqualToString:@"IN"]){
            [dic setValue:idstring forKey:@"containerId"];
        }
        [session POST:KURLNSString3(@"servlet", @"order", @"dealer",@"aftersale",@"create") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//                   NSLog(@"%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"f11", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [weakSelf.dataArray removeAllObjects];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                    JXS_SH_4_ViewController *pl04 = [[JXS_SH_4_ViewController alloc]init];
//                    [weakSelf.navigationController pushViewController:pl04 animated:YES];
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:[dic objectForKey:@"result_msg"] preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 135;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        TopinformationModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        self.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
        idstring = model.id;
    }
    self.tableview1.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TopinformationModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
        return cell;
    }
    
    Piliang_Yulan_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    JXS_SH3model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    

    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.model4.picture)] placeholderImage:[UIImage imageNamed:@"bgview"]];
    
    cell.lab5.layer.masksToBounds = YES;
    cell.lab5.layer.cornerRadius = 3;
    
    cell.lab6.layer.masksToBounds = YES;
    cell.lab6.layer.cornerRadius = 3;
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.model4.name];
    cell.lab1.numberOfLines = 0;
    
    if ([model.model2.id isEqualToString:model.model3.fromCurrency]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@%.2f",model.model2.field1,[model.model4.aftersale_price floatValue]];
        ;
        
        cell.lab7.text = [NSString stringWithFormat:@"%@%@",model.model2.field1,[Manager jinegeshi111:[NSString stringWithFormat:@"%.2f",[model.model1.quantity floatValue]*[model.model4.aftersale_price floatValue]]]];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"%@%.2f",model.model2.field1,[model.model4.aftersale_price floatValue]*[model.model3.rate floatValue]];
        ;
        
        
        cell.lab7.text = [NSString stringWithFormat:@"%@%@",model.model2.field1,[Manager jinegeshi111:[NSString stringWithFormat:@"%.2lf",[model.model1.quantity floatValue]*[model.model4.aftersale_price floatValue]*[model.model3.rate floatValue]]]];
    }
    
    
//    cell.lab1.numberOfLines = 0;
//    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
//    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
//    cell.lab1height.constant = size.height;
//    height1 = size.height;
//
//    cell.lab2.numberOfLines = 0;
//    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
//    CGSize size2 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
//    cell.lab2height.constant = size2.height;
//    height2 = size2.height;
//
//    if (height1 > 20 && height2 >20) {
//        cell.imgtop.constant = height1+height2-20;
//    }else if(height1 > 20 && height2 <= 20){
//        cell.imgtop.constant = height1+height2-10;
//    }else if(height1 <= 20 && height2 > 20){
//        cell.imgtop.constant = height1+height2-10;
//    }else{
//        cell.imgtop.constant = height1+height2;
//    }
    
    
    
    
    
    cell.lab3.text = [NSString stringWithFormat:@"%@",model.model4.partNo];
    cell.lab4.text = [NSString stringWithFormat:@"x%@",model.model1.quantity];
    
    
    
    
    
    cell.lab5.text = [NSString stringWithFormat:@"%.2lfm³",[model.model4.packageLength floatValue]*[model.model4.packageWidth floatValue]*[model.model4.packageHeight floatValue]/1000000*[model.model1.quantity floatValue]];
    cell.lab6.text = [NSString stringWithFormat:@"%.2lfkg",[model.model4.weight floatValue]*[model.model1.quantity floatValue]];
    
    
    return cell;
}




- (void)lodtopinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcontainer",@"all") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)dic;
        [weakSelf.dataArray1 removeAllObjects];
        for (NSDictionary *dict in arr) {
            TopinformationModel *model = [TopinformationModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        
        
        
        
        if (hhhhh == 0) {
            TopinformationModel *model = [self.dataArray1 objectAtIndex:0];
            weakSelf.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
            idstring = model.id;
        }else if (hhhhh < 29.62 && hhhhh > 0) {
            TopinformationModel *model = [self.dataArray1 objectAtIndex:1];
            weakSelf.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
            idstring = model.id;
        }else if (hhhhh > 29.62 && hhhhh < 63.48){
            TopinformationModel *model = [self.dataArray1 objectAtIndex:2];
            weakSelf.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
            idstring = model.id;
        }else if (hhhhh > 63.48 && hhhhh < 74.52){
            TopinformationModel *model = [self.dataArray1 objectAtIndex:3];
            weakSelf.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
            idstring = model.id;
        }
        
        
        else if (hhhhh > 74.52 && hhhhh < 232){
            TopinformationModel *model = [self.dataArray1 objectAtIndex:4];
            weakSelf.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
            idstring = model.id;
        }else if (hhhhh > 232 && hhhhh < 255){
            TopinformationModel *model = [self.dataArray1 objectAtIndex:5];
            weakSelf.textfield.text = [NSString stringWithFormat:@"%@  %@m³",model.containerCode,model.containerCapacity];
            idstring = model.id;
        }
        
        
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}






- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.tableview1.hidden == NO) {
        self.tableview1.hidden = YES;
    }else{
        self.tableview1.hidden = NO;
    }
    return NO;
}



- (NSMutableArray *)idarray {
    if (_idarray == nil) {
        self.idarray = [NSMutableArray arrayWithCapacity:1];
    }
    return _idarray;
}

- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)weightArray{
    if (_weightArray == nil) {
        self.weightArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _weightArray;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
