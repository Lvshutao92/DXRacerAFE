//
//  CP_search_three_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CP_search_three_ViewController.h"
#import "CP_3_ViewController.h"
@interface CP_search_three_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@end

@implementation CP_search_three_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    
    self.dataArray = [@[@"是",@"否"]mutableCopy];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 260, SCREEN_WIDTH-100, 100)];
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
    self.text4.text = self.dataArray[indexPath.row];
    self.tableview.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text4]) {
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
    CP_3_ViewController *ploi = [[CP_3_ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.str1 = @"";
    }else{
        ploi.str1 = self.text1.text;
    }
    
    if (self.text2.text.length == 0) {
        ploi.str2 = @"";
    }else{
        ploi.str2 = self.text2.text;
    }
    
    if (self.text3.text.length == 0) {
        ploi.str3 = @"";
    }else{
        ploi.str3 = self.text3.text;
    }
    
    
    if (self.text4.text.length == 0) {
        ploi.str4 = @"";
    }else{
        if ([self.text4.text isEqualToString:@"否"]) {
            ploi.str4 = @"N";
        }else if ([self.text4.text isEqualToString:@"是"]){
            ploi.str4 = @"Y";
        }
    }
    
    
    
    
    
    [self.navigationController pushViewController:ploi animated:YES];
}

@end
