//
//  PL_search_two_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PL_search_two_ViewController.h"
#import "PL_04_ViewController.h"
#import "XH_04_ViewController.h"
#import "JXS_SH_4_ViewController.h"
@interface PL_search_two_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@property(nonatomic, strong)NSMutableArray *idArray;
@end

@implementation PL_search_two_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.btn.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    [self.btn setTitle:NSLocalizedString(@"x8", nil) forState:UIControlStateNormal];
    self.lab1.text = NSLocalizedString(@"a1", nil);
    self.lab2.text = NSLocalizedString(@"a3", nil);
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 5;
    self.text2.placeholder = NSLocalizedString(@"x19", nil);
    
    self.dataArray = [@[NSLocalizedString(@"pl2", nil),NSLocalizedString(@"pl3", nil),NSLocalizedString(@"pl4", nil),NSLocalizedString(@"pl5", nil),NSLocalizedString(@"pl6", nil),NSLocalizedString(@"pl7", nil)]mutableCopy];
    
   
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(120, 170, SCREEN_WIDTH-130, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:self.tableview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.text2.text = self.dataArray[indexPath.row];
    self.tableview.hidden = YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text2]) {
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;;
        }
        return NO;
    }
    self.tableview.hidden = YES;
    return YES;
}







- (IBAction)clicksearch:(id)sender {
    
    if ([self.biaoshi isEqualToString:@"biaoshi"]) {
        
        
        XH_04_ViewController *ploi = [[XH_04_ViewController alloc]init];
        ploi.navigationItem.title = @"检索信息";
        if (self.text1.text.length == 0) {
            ploi.orderno = @"";
        }else{
            ploi.orderno = self.text1.text;
        }
        
        if (self.text2.text.length == 0) {
            ploi.orderstatus = @"";
        }else{
            if ([self.text2.text isEqualToString:NSLocalizedString(@"pl2", nil)]) {
                ploi.orderstatus = @"confirm";
            }else if ([self.text2.text isEqualToString:NSLocalizedString(@"pl3", nil)]){
                ploi.orderstatus = @"confirmed";
            }else if ([self.text2.text isEqualToString:NSLocalizedString(@"pl4", nil)]){
                ploi.orderstatus = @"production";
            }else if ([self.text2.text isEqualToString:NSLocalizedString(@"pl5", nil)]){
                ploi.orderstatus = @"undelivery";
            }else if ([self.text2.text isEqualToString:NSLocalizedString(@"pl6", nil)]){
                ploi.orderstatus = @"delivery";
            }else if ([self.text2.text isEqualToString:NSLocalizedString(@"pl7", nil)]){
                ploi.orderstatus = @"cancel";
            }
        }
        
        [self.navigationController pushViewController:ploi animated:YES];
        
     
        
        
    }else if ([self.biaoshi isEqualToString:@"SH_jxs"]) {
        
        
        JXS_SH_4_ViewController *ploi = [[JXS_SH_4_ViewController alloc]init];
        ploi.navigationItem.title = @"检索信息";
        if (self.text1.text.length == 0) {
            ploi.orderno = @"";
        }else{
            ploi.orderno = self.text1.text;
        }
        
        if (self.text2.text.length == 0) {
            ploi.orderstatus = @"";
        }else{
            if ([self.text2.text isEqualToString:@"待确认订单"]) {
                ploi.orderstatus = @"confirm";
            }else if ([self.text2.text isEqualToString:@"已确认订单"]){
                ploi.orderstatus = @"confirmed";
            }else if ([self.text2.text isEqualToString:@"生产中订单"]){
                ploi.orderstatus = @"production";
            }else if ([self.text2.text isEqualToString:@"待发货订单"]){
                ploi.orderstatus = @"undelivery";
            }else if ([self.text2.text isEqualToString:@"已发货订单"]){
                ploi.orderstatus = @"delivery";
            }else if ([self.text2.text isEqualToString:@"已取消订单"]){
                ploi.orderstatus = @"cancel";
            }
        }
        
        [self.navigationController pushViewController:ploi animated:YES];
        
        
        
        
        
    }else{
        PL_04_ViewController *ploi = [[PL_04_ViewController alloc]init];
        ploi.navigationItem.title = @"检索信息";
        if (self.text1.text.length == 0) {
            ploi.orderno = @"";
        }else{
            ploi.orderno = self.text1.text;
        }
        
        if (self.text2.text.length == 0) {
            ploi.orderstatus = @"";
        }else{
            if ([self.text2.text isEqualToString:@"待确认订单"]) {
                ploi.orderstatus = @"confirm";
            }else if ([self.text2.text isEqualToString:@"已确认订单"]){
                ploi.orderstatus = @"confirmed";
            }else if ([self.text2.text isEqualToString:@"生产中订单"]){
                ploi.orderstatus = @"production";
            }else if ([self.text2.text isEqualToString:@"待发货订单"]){
                ploi.orderstatus = @"undelivery";
            }else if ([self.text2.text isEqualToString:@"已发货订单"]){
                ploi.orderstatus = @"delivery";
            }else if ([self.text2.text isEqualToString:@"已取消订单"]){
                ploi.orderstatus = @"cancel";
            }
        }
        [self.navigationController pushViewController:ploi animated:YES];
    }
    
    
    
}

@end
