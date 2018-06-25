//
//  SH_search_one_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SH_search_one_ViewController.h"
#import "JXS_SH_2_ViewController.h"
@interface SH_search_one_ViewController ()<UITextFieldDelegate>

@end

@implementation SH_search_one_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.btn.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    [self.btn setTitle:NSLocalizedString(@"x8", nil) forState:UIControlStateNormal];
    self.lab1.text = NSLocalizedString(@"d2", nil);
    self.lab2.text = NSLocalizedString(@"d3", nil);
    
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)clicksearch:(id)sender {
    JXS_SH_2_ViewController *ploi = [[JXS_SH_2_ViewController alloc]init];
    ploi.navigationItem.title = @"检索信息";
    if (self.text1.text.length == 0) {
        ploi.fcno = @"";
    }else{
        ploi.fcno = self.text1.text;
    }
    
    if (self.text2.text.length == 0) {
        ploi.model = @"";
    }else{
        ploi.model = self.text2.text;
    }
    
    [self.navigationController pushViewController:ploi animated:YES];
}

@end
