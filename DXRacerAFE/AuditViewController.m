//
//  AuditViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "AuditViewController.h"

@interface AuditViewController ()<UITextFieldDelegate>
{
    UIScrollView *scrollview;
    UILabel *lable1;
    UILabel *lable2;
    UILabel *lable3;
    UILabel *lable4;
    UILabel *lable5;
    UILabel *lable6;
    UILabel *lable7;
    UILabel *lable8;
    
    UITextField *text;
    
    UITextField *text1;
}


@end

@implementation AuditViewController



- (void)clickSave{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"username":[Manager redingwenjianming:@"userName.text"],
            @"transactionNo":text.text,
            @"paidFee":text1.text,
            @"id":self.strid,
            };
    
    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"audit") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        //        NSLog(@"dic = %@",dic);
       
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"审核成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}








- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    // Do any additional setup after loading the view.
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    scrollview.contentSize = CGSizeMake(0, 600);
    scrollview.userInteractionEnabled = YES;
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    // Do any additional setup after loading the view.
    
    lable1.text  = self.str1;
    lable2.text  = [Manager jinegeshi:self.str2];
    lable3.text  = self.str3;
    lable4.text  = self.str4;
    lable5.text  = self.str5;
    lable6.text  = self.str6;
}
- (void)setUpRightTextfield{
    for (int i = 0; i<6; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(125, 10+50*i, SCREEN_WIDTH-130, 30)];
        switch (i) {
            case 0:
                lable1 = lable;
                break;
            case 1:
                lable2 = lable;
                lable2.textColor = [UIColor redColor];
                break;
            case 2:
                lable3 = lable;
                break;
            case 3:
                lable4 = lable;
                break;
            case 4:
                lable5 = lable;
                break;
            case 5:
                lable6 = lable;
                break;
            default:
                break;
        }
        lable.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lable];
    }
    
    
    text = [[UITextField alloc]initWithFrame:CGRectMake(125, 320, SCREEN_WIDTH-140, 30)];
    text.delegate = self;
    text.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text];
    
    
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(125, 370, SCREEN_WIDTH-140, 30)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
}


- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"付款单号",@"应付金额",@"付款银行",@"付款银行账号",@"收款银行",@"收款银行账号",@"收款交易流水号",@"到账金额"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+50*i, 120, 30)];
        lable.text = arr[i];
        lable.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lable];
    }
}



@end
