//
//  FP_details_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FP_details_TableViewController.h"
#import "WDFP_Cell.h"
#import "WDFP_Xq_Cell.h"
#import "kkfp_1_model.h"
#import "searchResultmodel.h"
@interface FP_details_TableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FP_details_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"WDFP_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WDFP_Xq_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [self lodDetailsList];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 390;
    }
    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifierCell = @"cell1";
        WDFP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[WDFP_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.telephonelab.text = @"收货地址";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailsbtn.hidden = YES;
        cell.selectbtn.hidden = YES;
        cell.line.hidden = YES;
        
        cell.lab1.text = self.str1;
        cell.lab2.text = self.str2;
        cell.lab3.text = self.str3;
        cell.lab4.text = self.str4;
        cell.lab5.text = self.str5;
        cell.lab6.text = self.str6;
        cell.lab7.text = self.str7;
        cell.lab8.text = self.str8;
        cell.lab9.text = self.str9;
        cell.lab10.text = self.str10;
        cell.lab11.text = self.str11;
        cell.lab12.text = self.str12;
        
        return cell;
    }
    
    
    static NSString *identifierCell = @"cell2";
    WDFP_Xq_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[WDFP_Xq_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    kkfp_1_model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.productCode;
    cell.lab2.text = model.model1.product;
    cell.lab3.text = model.model1.chineseName;
    
    cell.lab4.text = [Manager jinegeshi:[NSString stringWithFormat:@"%.02f",[model.productFee floatValue]/[model.quantity floatValue]]];
    cell.lab5.text = model.quantity;
    cell.lab6.text = [Manager jinegeshi:model.productFee];
    return cell;
}




-(void)lodDetailsList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"orderId":self.orderId,
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"order",@"dealer/item",@"list")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
         // NSLog(@"%@",dic);
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










- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
