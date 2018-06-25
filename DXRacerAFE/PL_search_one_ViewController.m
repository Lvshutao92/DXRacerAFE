//
//  PL_search_one_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PL_search_one_ViewController.h"
#import "PL_01_ViewController.h"
@interface PL_search_one_ViewController ()<UITextFieldDelegate>

@end

@implementation PL_search_one_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.btn.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    [self.btn setTitle:NSLocalizedString(@"x8", nil) forState:UIControlStateNormal];
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 5;
}


- (IBAction)clickbtnsearch:(id)sender {
    
    PL_01_ViewController *ploi = [[PL_01_ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.model = @"";
    }else{
        ploi.model = self.text1.text;
    }
    
    if (self.text2.text.length == 0) {
        ploi.item = @"";
    }else{
        ploi.item = self.text2.text;
    }
    
    if (self.text3.text.length == 0) {
        ploi.fcno = @"";
    }else{
        ploi.fcno = self.text3.text;
    }
    [self.navigationController pushViewController:ploi animated:YES];
    
}







@end
