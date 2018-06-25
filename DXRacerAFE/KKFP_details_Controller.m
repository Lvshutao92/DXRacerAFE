//
//  KKFP_details_Controller.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "KKFP_details_Controller.h"
#import "OrderDetails_2_Cell.h"
#import "DDMX_Cell.h"

#import "kkfp_1_model.h"
#import "searchResultmodel.h"
#import "kkfp_2_model.h"
@interface KKFP_details_Controller ()
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@end

@implementation KKFP_details_Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"DDMX_Cell" bundle:nil] forCellReuseIdentifier:@"cella"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderDetails_2_Cell" bundle:nil] forCellReuseIdentifier:@"cellb"];
    
    [self lodMingXi];
    [self lodPaymentTtpe];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }
    return self.dataArray1.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 290;
    }
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifierCell = @"cella";
        DDMX_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[DDMX_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        kkfp_1_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.model1.image)]placeholderImage:[UIImage imageNamed:@"bgview"]];
        cell.lab1.text = model.productCode;
        
        cell.lab2.text = model.model1.product;
        cell.lab3.text = model.model1.chineseName;
        cell.lab5.text = [Manager jinegeshi:model.unitPrice];
        cell.lab6.text = model.quantity;
        cell.lab7.text = [Manager jinegeshi:model.productFee];
        
         
        return cell;
    }
    
    static NSString *identifierCell = @"cellb";
    OrderDetails_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[OrderDetails_2_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    kkfp_2_model *model = [self.dataArray1 objectAtIndex:indexPath.row];
    
    
    
    
    
    cell.lab2.text = [Manager jinegeshi:model.totalFee];
    cell.lab3.text = model.paymentType;
    

    if ([model.paymentStatus isEqualToString:@"N"]) {
        cell.lab4.text = @"未付款";
    }else if ([model.paymentStatus isEqualToString:@"A"]) {
        cell.lab4.text = @"待审核";
    }else if ([model.paymentStatus isEqualToString:@"Y"]) {
        cell.lab4.text = @"已付款";
    }else if ([model.paymentStatus isEqualToString:@"C"]) {
        cell.lab4.text = @"已取消";
    }
    
    
    if ([model.ttType isEqualToString:@"Deposit"]) {
        cell.lab5.text = @"定金";
    }else if ([model.ttType isEqualToString:@"Retainage"]) {
        cell.lab5.text = @"尾款";
    }
    
    
    cell.lab6.text = [Manager TimeCuoToTime:model.estimatedDate];
    
    
    
    if ([model.paymentType isEqualToString:@"T/T"]) {
        cell.lab1.text = model.field1;
        cell.lookbtn.hidden = YES;
    }else if ([model.paymentType isEqualToString:@"C/L"]){
        if (model.field1 == nil) {
            cell.lab1.hidden = YES;
            cell.lookbtn.hidden = NO;
        }else{
            cell.lab1.text = model.field1;
            cell.lookbtn.hidden = YES;
        }
    }
    
    
    
    
    
    return cell;
}















- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    
    [view addSubview:label];
    
    if (section == 0) {
        label.text = @"   订单明细";
        return view;
    }
    label.text = @"   付款方式";
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}



- (void)lodMingXi{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"orderId":self.ids,
            };
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer",@"item",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"orderItemResult"];
        for (NSDictionary *dict in arr) {
            kkfp_1_model *model = [kkfp_1_model mj_objectWithKeyValues:dict];
            
            searchResultmodel *model1 = [searchResultmodel mj_objectWithKeyValues:model.searchResult];
            model.model1 = model1;
            
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)lodPaymentTtpe{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.ids,
            };
    
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer",@"payment",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"=====%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            kkfp_2_model *model = [kkfp_2_model mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        
        [weakSelf.tableView reloadData];
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
