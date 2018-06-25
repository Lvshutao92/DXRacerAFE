//
//  XH_PL_details_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XH_PL_details_TableViewController.h"
#import "PL_XH__detailsCell.h"
#import "PLXHdetails1model.h"
#import "PLXHDetailsModel.h"
#import "PaymentStyleCell.h"
#import "LookPictureViewController.h"
#import "PLXHPaymentModel.h"

#import "ShouHou_Wuchang_details_Cell.h"
@interface XH_PL_details_TableViewController ()
{
    CGFloat height;
    
    CGFloat height1;
    CGFloat height2;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@end

@implementation XH_PL_details_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHou_Wuchang_details_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PaymentStyleCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self lodlist];
    
    [self lodpaymentlist];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 105+height2+height1;
    }
    return 210;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }
    return self.dataArray1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifierCell = @"cell";
        ShouHou_Wuchang_details_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[ShouHou_Wuchang_details_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PLXHDetailsModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.model1.image)]placeholderImage:[UIImage imageNamed:@"bgview"]];
        
        if (model.model1.englishName == nil || [model.model1.englishName isEqual:[NSNull null]]  || model.model1.englishName.length == 0) {
            model.model1.englishName = @"-";
        }
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
            cell.lab1.text = [NSString stringWithFormat:@"%@",model.model1.englishName];
        }else{
            cell.lab1.text = [NSString stringWithFormat:@"%@",model.model1.chineseName];
       }
       cell.lab2.text = [NSString stringWithFormat:@"%@",model.model1.product];
       cell.lab3.text = [NSString stringWithFormat:@"%@",model.productCode];
       
    cell.lab4.text = [NSString stringWithFormat:@"%@%.2f",self.fuhao,[model.unitPrice floatValue]];
    cell.lab5.text = [NSString stringWithFormat:@"x%@",model.quantity];
        
        
   
        
    cell.lab6.text = [NSString stringWithFormat:@"%@%@",self.fuhao,[Manager jinegeshi111:[NSString stringWithFormat:@"%.02f",[model.quantity floatValue]*[model.unitPrice floatValue]]]];
       
        
        
        cell.lab1.numberOfLines = 0;
        cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        cell.lab1height.constant = size.height;
        height1 = size.height;
        
        cell.lab2.numberOfLines = 0;
        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        cell.lab2height.constant = size2.height;
        height2 = size2.height;
        
        if (height1 > 20 && height2 >20) {
            cell.imgtop.constant = (height1+height2-40)/2+10;
        }else if(height1 > 20 && height2 <= 20){
            cell.imgtop.constant = (height1-20)/2+10;
        }else if(height1 <= 20 && height2 > 20){
            cell.imgtop.constant = (height2-20)/2+10;
        }else{
            cell.imgtop.constant = 10;
        }
        
        
        return cell;
    }
    
    static NSString *identifierCell = @"cell1";
    PaymentStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[PaymentStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PLXHPaymentModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
    
    if (model.paymentType != nil && [model.paymentType isEqualToString:@"L/C"]) {
        cell.lookbtn.hidden = NO;
        cell.lab1.hidden = YES;
        [cell.lookbtn addTarget:self action:@selector(clicklooc:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.lookbtn.hidden = YES;
        cell.lab1.hidden = NO;
        cell.lab1.text = model.field1;
    }
    
    
    cell.lab2.text = [Manager jinegeshi:model.totalFee];
    cell.lab2.textColor = [UIColor redColor];
    
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
 
    
    
    if (model.estimatedDate == nil) {
        cell.lab6.text = @"-";
    }else{
        cell.lab6.text = [Manager TimeCuoToTime:model.estimatedDate];
    }
    cell.label1.text = NSLocalizedString(@"d11", nil);
    cell.label2.text = NSLocalizedString(@"d12", nil);
    cell.label3.text = NSLocalizedString(@"d13", nil);
    cell.label4.text = NSLocalizedString(@"d14", nil);
    cell.label5.text = NSLocalizedString(@"d15", nil);
    cell.label6.text = NSLocalizedString(@"d16", nil);
    return cell;
}



- (void)clicklooc:(UIButton *)sender{
    PaymentStyleCell *cell = (PaymentStyleCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    PLXHPaymentModel *model = [self.dataArray1 objectAtIndex:indexpath.row];
    
    
    LookPictureViewController *look = [[LookPictureViewController alloc]init];
    look.imgStr  = model.field1;
    [self.navigationController pushViewController:look animated:YES];
}








- (void)lodpaymentlist{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.idstr,
            };
    
    [session POST:KURLNSString3(@"servlet", @"order",@"dealer",@"payment",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                        NSLog(@"%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PLXHPaymentModel *model = [PLXHPaymentModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)lodlist{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"orderId":self.idstr,
            };
    
    [session POST:KURLNSString3(@"servlet", @"order",@"dealer",@"item",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"orderItemResult"];
        for (NSDictionary *dict in arr) {
            PLXHDetailsModel *model = [PLXHDetailsModel mj_objectWithKeyValues:dict];
            
            PLXHdetails1model *model1 = [PLXHdetails1model mj_objectWithKeyValues:model.searchResult];
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

- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
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
    label.font = [UIFont systemFontOfSize:16];
    
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



@end
