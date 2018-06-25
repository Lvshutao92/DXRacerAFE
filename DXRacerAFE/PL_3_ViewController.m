//
//  PL_3_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PL_3_ViewController.h"
#import "OrderListCell.h"
#import "PL_____model.h"
#import "PL___2__model.h"
#import "PL__1__model.h"
@interface PL_3_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;


@end

@implementation PL_3_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"OrderListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.btn.hidden = YES;
    
    PL_____model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a1", nil),model.orderNo];
//    cell.lab2.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a2", nil),[Manager jinegeshi:model.orderTotalFee]];;
//
//    if ([model.orderStatus isEqualToString:@"confirm"]) {
//        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl2", nil)];
//    }else if ([model.orderStatus isEqualToString:@"confirmed"]) {
//        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl3", nil)];
//    }else if ([model.orderStatus isEqualToString:@"production"]) {
//        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl4", nil)];
//    }else if ([model.orderStatus isEqualToString:@"undelivery"]) {
//        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl5", nil)];
//    }else if ([model.orderStatus isEqualToString:@"delivery"]) {
//        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl6", nil)];
//    }else if ([model.orderStatus isEqualToString:@"cancel"]) {
//        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl7", nil)];
//    }
    cell.lab2.textColor = [UIColor redColor];
    
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a2", nil),[Manager jinegeshi:model.orderTotalFee]]];
    // 需要改变的区间
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
        NSRange range1 = NSMakeRange(0, 10);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [cell.lab2 setAttributedText:noteStr];
    }else{
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab2 setAttributedText:noteStr];
    }
    
    
    
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.lab3.textColor = RGBACOLOR(227, 154, 70, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl2", nil)]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            NSRange range1 = NSMakeRange(0, 13);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            [cell.lab3 setAttributedText:noteStr];
        }else{
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab3 setAttributedText:noteStr];
        }
    }else if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab3.textColor = RGBACOLOR(55, 154, 254, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl3", nil)]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            NSRange range1 = NSMakeRange(0, 13);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            [cell.lab3 setAttributedText:noteStr];
        }else{
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab3 setAttributedText:noteStr];
        }
    }else if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab3.textColor = RGBACOLOR(0, 157, 147, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl4", nil)]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            NSRange range1 = NSMakeRange(0, 13);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            [cell.lab3 setAttributedText:noteStr];
        }else{
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab3 setAttributedText:noteStr];
        }
    }else if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab3.textColor = RGBACOLOR(162, 133, 233, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl5", nil)]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            NSRange range1 = NSMakeRange(0, 13);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            [cell.lab3 setAttributedText:noteStr];
        }else{
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab3 setAttributedText:noteStr];
        }
    }else if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab3.textColor = RGBACOLOR(249, 76, 82, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl6", nil)]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            NSRange range1 = NSMakeRange(0, 13);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            [cell.lab3 setAttributedText:noteStr];
        }else{
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab3 setAttributedText:noteStr];
        }
    }else if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab3.textColor = RGBACOLOR(113, 113, 113, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl7", nil)]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            NSRange range1 = NSMakeRange(0, 13);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            [cell.lab3 setAttributedText:noteStr];
        }else{
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab3 setAttributedText:noteStr];
        }
    }
    
    
    
    
    
    
    
    cell.lab4.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a4", nil),model.model1.companyName];
    
    cell.lab5.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a5", nil),model.model2.containerCode];;
    if (model.planDeliveryDate == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a6", nil),@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a6", nil),[Manager TimeCuoToTime:model.planDeliveryDate]];
    }
    return cell;
}








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XH_PL_details_TableViewController *details = [[XH_PL_details_TableViewController alloc]init];
    details.navigationItem.title = @"详情";
    PL_____model *model = [self.dataArray objectAtIndex:indexPath.row];
    details.idstr = model.id;
    [self.navigationController pushViewController:details animated:YES];
}





//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"orderStatus":@"confirmed",
            @"orderType":@"batchOrder",
            };
    
    
    [session POST:KURLNSString3(@"servlet", @"order",@"manager",@"confirmed",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        //        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            PL_____model *model = [PL_____model mj_objectWithKeyValues:dict];
            
            PL__1__model *model1 = [PL__1__model mj_objectWithKeyValues:model.dealerInfo];
            model.model1 = model1;
            
            PL___2__model *model2 = [PL___2__model mj_objectWithKeyValues:model.configContainer];
            model.model2 = model2;
            
            [weakSelf.dataArray addObject:model];
        }
        
        
        page=2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"orderStatus":@"confirmed",
            @"orderType":@"batchOrder",
            };
    
    
    [session POST:KURLNSString3(@"servlet", @"order",@"manager",@"confirmed",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            PL_____model *model = [PL_____model mj_objectWithKeyValues:dict];
            
            PL__1__model *model1 = [PL__1__model mj_objectWithKeyValues:model.dealerInfo];
            model.model1 = model1;
            
            PL___2__model *model2 = [PL___2__model mj_objectWithKeyValues:model.configContainer];
            model.model2 = model2;
            
            [weakSelf.dataArray addObject:model];
        }
        
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}



- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}



@end
