//
//  Order_details_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Order_details_ViewController.h"
#import "OrderDetails_1_Cell.h"
#import "OrderDetails_2_Cell.h"

#import "resultmodel.h"
#import "MXModel.h"
#import "PayMentModel.h"

#import "Piliang_Orderlist_details_Cell.h"


#import "ShouHou_Wuchang_details_Cell.h"
@interface Order_details_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height1;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;


@property(nonatomic, strong)NSMutableArray *dataArray1;
@end

@implementation Order_details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"x17", nil);
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"ShouHou_Wuchang_details_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"OrderDetails_2_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview];
    
    [self lodMingXi];
    [self lodPaymentTtpe];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105+height1;
    }
    return 205;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }
    return self.dataArray1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        Piliang_Orderlist_details_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        MXModel *model = [self.dataArray objectAtIndex:indexPath.row];
//
        
        
       
        static NSString *identifierCell = @"cell";
        ShouHou_Wuchang_details_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[ShouHou_Wuchang_details_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MXModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        if (model.searchResultmodel.image == nil) {
            cell.img.image = [UIImage imageNamed:@"未标题-2"];
        }else{
            [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.searchResultmodel.image)] placeholderImage:[UIImage imageNamed:@"未标题-2"]];
        }
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
            cell.lab1.text = [NSString stringWithFormat:@"%@",model.searchResultmodel.englishName];
        }else{
            cell.lab1.text = [NSString stringWithFormat:@"%@",model.searchResultmodel.chineseName];
        }
        cell.lab1.numberOfLines = 0;
        cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        cell.lab1height.constant = size.height;
        height1 = size.height;
        
        if (height1 > 20) {
            cell.imgtop.constant = (height1-20)/2+5;
        }else{
            cell.imgtop.constant = 5;
        }
        cell.lab2.text = [NSString stringWithFormat:@"%@",model.productCode];
        
        cell.lab3.text = [NSString stringWithFormat:@"%@",model.searchResultmodel.product];
        
        cell.lab4.text = [NSString stringWithFormat:@"%@%.2f",self.fuhao,[model.unitPrice floatValue]];
        cell.lab5.text = [NSString stringWithFormat:@"x%@",model.quantity];
        
        
        
        
        cell.lab6.text = [NSString stringWithFormat:@"%@%@",self.fuhao,[Manager jinegeshi111:[NSString stringWithFormat:@"%.2lf",[model.quantity floatValue]*[model.unitPrice floatValue]]]];
        
//        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.model1.image)]placeholderImage:[UIImage imageNamed:@"bgview"]];
//
//        if (model.model1.englishName == nil || [model.model1.englishName isEqual:[NSNull null]]  || model.model1.englishName.length == 0) {
//            model.model1.englishName = @"-";
//        }
//
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
//            cell.lab1.text = [NSString stringWithFormat:@"%@",model.model1.englishName];
//        }else{
//            cell.lab1.text = [NSString stringWithFormat:@"%@",model.model1.chineseName];
//        }
//        cell.lab2.text = [NSString stringWithFormat:@"%@",model.model1.product];
//        cell.lab3.text = [NSString stringWithFormat:@"%@",model.productCode];
//
//        cell.lab4.text = [NSString stringWithFormat:@"%@%.2f",self.fuhao,[model.unitPrice floatValue]];
//        cell.lab5.text = [NSString stringWithFormat:@"x%@",model.quantity];
//        cell.lab6.text = [NSString stringWithFormat:@"%@%.02f",self.fuhao,[model.quantity floatValue]*[model.unitPrice floatValue]];
//
//
//
//        cell.lab1.numberOfLines = 0;
//        cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
//        cell.lab1height.constant = size.height;
//        height1 = size.height;
//
//        cell.lab2.numberOfLines = 0;
//        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size2 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
//        cell.lab2height.constant = size2.height;
//        height2 = size2.height;
//
//        if (height1 > 20 && height2 >20) {
//            cell.imgtop.constant = (height1+height2-40)/2+10;
//        }else if(height1 > 20 && height2 <= 20){
//            cell.imgtop.constant = (height1-20)/2+10;
//        }else if(height1 <= 20 && height2 > 20){
//            cell.imgtop.constant = (height2-20)/2+10;
//        }else{
//            cell.imgtop.constant = 10;
//        }
        
        return cell;
    }
    OrderDetails_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PayMentModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
    if (model.field1 == nil) {
        cell.lab1.text = @"-";
    }else{
        cell.lab1.text = model.field1;
    }
    
    cell.lab2.text = [NSString stringWithFormat:@"%@%.2f",self.fuhao,[model.totalFee floatValue]];
    cell.lab3.text = model.paymentType;
    
    
    if ([model.paymentStatus isEqualToString:@"N"]) {
         cell.lab4.text = NSLocalizedString(@"e1", nil);
    }else if ([model.paymentStatus isEqualToString:@"A"]) {
        cell.lab4.text = NSLocalizedString(@"e2", nil);
    }else if ([model.paymentStatus isEqualToString:@"Y"]) {
        cell.lab4.text = NSLocalizedString(@"e3", nil);
    }else if ([model.paymentStatus isEqualToString:@"C"]) {
        cell.lab4.text = NSLocalizedString(@"e4", nil);
    }
    
   
    if ([model.ttType isEqualToString:@"Deposit"]) {
        cell.lab5.text = NSLocalizedString(@"e5", nil);
    }else if ([model.ttType isEqualToString:@"Retainage"]) {
        cell.lab5.text = NSLocalizedString(@"e6", nil);
    }
    
    if ([model.estimatedDate isEqual:[NSNull null]] || model.estimatedDate.length==0){
        cell.lab6.text = @"-";
    }else{
        cell.lab6.text = [Manager TimeCuoToTime:model.estimatedDate];
    }
    
    
    
    cell.label1.text = NSLocalizedString(@"d11", nil);
    cell.label2.text = NSLocalizedString(@"d12", nil);
    cell.label3.text = NSLocalizedString(@"d13", nil);
    cell.label4.text = NSLocalizedString(@"d14", nil);
    cell.label6.text = NSLocalizedString(@"d15", nil);
    cell.label7.text = NSLocalizedString(@"d16", nil);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *line0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line0.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line0];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];
    [view addSubview:label];
    
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"  %@",NSLocalizedString(@"x17", nil)];
        return view;
    }
    label.text = [NSString stringWithFormat:@"  %@",NSLocalizedString(@"x12", nil)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}



- (void)lodMingXi{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"orderId":self.orderid,
            };
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer",@"item",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"orderItemResult"];
        for (NSDictionary *dict in arr) {
            MXModel *model = [MXModel mj_objectWithKeyValues:dict];
            
            resultmodel *model1 = [resultmodel mj_objectWithKeyValues:model.searchResult];
            model.searchResultmodel = model1;
            
            
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)lodPaymentTtpe{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.orderid,
            };
    
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer",@"payment",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"=====%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PayMentModel *model = [PayMentModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



























- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}




@end
