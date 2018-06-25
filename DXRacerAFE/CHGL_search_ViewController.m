//
//  CHGL_search_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CHGL_search_ViewController.h"
#import "CHQD_ViewController.h"
@interface CHGL_search_ViewController ()<UITextFieldDelegate>

@end

@implementation CHGL_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    
    self.text4.delegate = self;
    self.text5.delegate = self;
    
}
- (IBAction)clicksearch:(id)sender {
    
    
    CHQD_ViewController *ploi = [[CHQD_ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.str1 = @"";
    }else{
        ploi.str1 = self.text1.text;
    }
    if (self.text4.text.length == 0) {
        ploi.str4 = @"";
    }else{
        ploi.str4 = self.text4.text;
    }
    if (self.text5.text.length == 0) {
        ploi.str5 = @"";
    }else{
        if ([self.text5.text isEqualToString:@"已申请"]) {
            ploi.str5 = @"create";
        }else if ([self.text5.text isEqualToString:@"待出货"]){
            ploi.str5 = @"pending";
        }else if ([self.text5.text isEqualToString:@"已完成"]){
            ploi.str5 = @"finish";
        }
    }
    
    
    [self.navigationController pushViewController:ploi animated:YES];
    
    
}

@end
