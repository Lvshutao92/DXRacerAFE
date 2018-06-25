//
//  Companydetails_1_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Companydetails_1_TableViewController.h"
#import "Company1Cell.h"

#import "Pay_One_model.h"
#import "paymodel.h"
@interface Companydetails_1_TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *Array1;


@property(nonatomic,strong)UITableView *tableview;

@end

@implementation Companydetails_1_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate   = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"Company1Cell" bundle:nil] forCellReuseIdentifier:@"cella"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:self.tableview];
//    [self loddeList];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"----%ld",[Manager sharedManager].Array1.count);
    return [Manager sharedManager].Array1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"cella";
    Company1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Company1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    paymodel *model = [[Manager sharedManager].Array1 objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"公司名称：%@",model.dealerInfomodel.companyName];
    
    cell.lab2.text = [NSString stringWithFormat:@"付款方式：%@",model.paymentType];
    
    if ([model.retainageType isEqualToString:@"before"]) {
        cell.lab3.text = [NSString stringWithFormat:@"尾款：出货前%@天",model.lcday];
    }else{
        cell.lab3.text = [NSString stringWithFormat:@"尾款：出货后%@天",model.lcday];
    }
    
    
    cell.lab4.text = [NSString stringWithFormat:@"定金比例：%@%%",model.proportion];
    
    cell.lab5.text = [NSString stringWithFormat:@"尾款比例：%@%%",model.proportion];
    
    return cell;
    
    
}




- (NSMutableArray *)Array1 {
    if (_Array1 == nil) {
        self.Array1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array1;
}

@end
