//
//  SK_search_two_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SK_search_two_ViewController.h"
#import "SK2ViewController.h"
@interface SK_search_two_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@end

@implementation SK_search_two_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    
    self.dataArray = [@[@"定金",@"尾款"]mutableCopy];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 170, SCREEN_WIDTH-100, 100)];
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
    SK2ViewController *ploi = [[SK2ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.str1 = @"";
    }else{
        ploi.str2 = self.text1.text;
    }
    
    if (self.text2.text.length == 0) {
        ploi.str2 = @"";
    }else{
        if ([self.text2.text isEqualToString:@"定金"]) {
            ploi.str2 = @"Deposit";
        }else if ([self.text2.text isEqualToString:@"尾款"]){
            ploi.str2 = @"Retainage";
        }
    }
    
    [self.navigationController pushViewController:ploi animated:YES];

}


@end
