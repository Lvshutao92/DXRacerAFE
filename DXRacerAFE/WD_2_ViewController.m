//
//  WD_2_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WD_2_ViewController.h"

@interface WD_2_ViewController ()
{
    UILabel *lab1;
    UILabel *lab2;
}
@end

@implementation WD_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 69, SCREEN_WIDTH-10, 110)];
    view.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.view addSubview:view];
    
    UILabel *la1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 75, 30)];
    la1.text = @"公司名称:";
    [view addSubview:la1];
    
    UILabel *la2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 75, 30)];
    la2.text = @"付款方式:";
    [view addSubview:la2];
    
    
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, SCREEN_WIDTH-95, 30)];
    [view addSubview:lab1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(85, 60,  SCREEN_WIDTH-95, 30)];
    [view addSubview:lab2];
    
    
    
    [self loddata];
}

- (void)loddata{
    AFHTTPSessionManager *session = [Manager returnsession];
    //__weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerpayment",@"initpage") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        lab1.text = [[[[dic objectForKey:@"rows"] objectForKey:@"dealerPayment"] objectForKey:@"dealerInfo"] objectForKey:@"companyName"];
        lab2.text = [[[dic objectForKey:@"rows"] objectForKey:@"dealerPayment"] objectForKey:@"paymentType"];
//        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"修改成功😊" preferredStyle:1];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            [alert addAction:cancel];
//            [weakSelf presentViewController:alert animated:YES completion:nil];
//        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}













@end
