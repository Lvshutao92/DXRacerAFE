//
//  WD_5_Add_Edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WD_5_Add_Edit_ViewController.h"

@interface WD_5_Add_Edit_ViewController ()<UITextFieldDelegate>
{
    UIScrollView *scrollview;
    
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    
    UITextField *textfield7;
    UITextField *textfield8;
    UITextField *textfield9;
    UITextField *textfield10;
    UITextField *textfield11;
    UITextField *textfield12;
    
}
@end

@implementation WD_5_Add_Edit_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    scrollview.contentSize = CGSizeMake(0, 800);
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    
  
    
    textfield1.text = self.str1;
    textfield2.text = self.str2;
    textfield3.text = self.str3;
    textfield4.text = self.str4;
    textfield5.text = self.str5;
    textfield6.text = self.str6;
    
    
    textfield7.text  = self.str7;
    textfield8.text  = self.str8;
    textfield9.text  = self.str9;
    textfield10.text = self.str10;
    textfield11.text = self.str11;
    textfield12.text = self.str12;
    
    
    
    
}
- (void)clickSave{
    if ([self.navigationItem.title isEqualToString:@"新增"]){
        if (textfield2.text.length == 0) {
            textfield2.text = @"";
        }
        if (textfield3.text.length == 0) {
            textfield3.text = @"";
        }
        if (textfield4.text.length == 0) {
            textfield4.text = @"";
        }
        if (textfield5.text.length == 0) {
            textfield5.text = @"";
        }
        if (textfield6.text.length == 0) {
            textfield6.text = @"";
        }
        if (textfield7.text.length == 0) {
            textfield7.text = @"";
        }
        if (textfield8.text.length == 0) {
            textfield8.text = @"";
        }
        if (textfield9.text.length == 0) {
            textfield9.text = @"";
        }
        if (textfield10.text.length == 0) {
            textfield10.text = @"";
        }
        if (textfield11.text.length == 0) {
            textfield11.text = @"";
        }
        if (textfield12.text.length == 0) {
            textfield12.text = @"";
        }
        
        
        if (textfield1.text.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"订舱代理不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [self lodadd];
        }
        
        
    }else{
        if (textfield2.text.length == 0) {
            textfield2.text = @"";
        }
        if (textfield3.text.length == 0) {
            textfield3.text = @"";
        }
        if (textfield4.text.length == 0) {
            textfield4.text = @"";
        }
        if (textfield5.text.length == 0) {
            textfield5.text = @"";
        }
        if (textfield6.text.length == 0) {
            textfield6.text = @"";
        }
        if (textfield7.text.length == 0) {
            textfield7.text = @"";
        }
        if (textfield8.text.length == 0) {
            textfield8.text = @"";
        }
        if (textfield9.text.length == 0) {
            textfield9.text = @"";
        }
        if (textfield10.text.length == 0) {
            textfield10.text = @"";
        }
        if (textfield11.text.length == 0) {
            textfield11.text = @"";
        }
        if (textfield12.text.length == 0) {
            textfield12.text = @"";
        }
        
        
        if (textfield1.text.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"订舱代理不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
           [self lodedit];
        }
        
    }
}


- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"bookingAgent":textfield1.text,
            @"province":textfield2.text,
            @"city":textfield3.text,
            @"county":textfield4.text,
            @"detailAddress":textfield5.text,
            
            @"telephone":textfield6.text,
            
            @"contactPerson":textfield7.text,
            
            @"mobilePhone":textfield8.text,
            @"mailbox":textfield9.text,
            @"openBank":textfield10.text,
            @"bankAccount":textfield11.text,
            @"bankNumber":textfield12.text,
            @"id":self.strid,
            };
         NSLog(@"----%@",textfield7.text);
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerforward",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //                NSLog(@"----%@",dic);
        
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"bookingAgent":textfield1.text,
            @"province":textfield2.text,
            @"city":textfield3.text,
            @"county":textfield4.text,
            @"detailAddress":textfield5.text,
            @"telephone":textfield6.text,
            @"contactPerson":textfield7.text,
            @"mobilePhone":textfield8.text,
            @"mailbox":textfield9.text,
            @"openBank":textfield10.text,
            @"bankAccount":textfield11.text,
            @"bankNumber":textfield12.text,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerforward",@"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"----%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (void)setUpRightTextfield{
    for (int i = 0; i<12; i++) {
        UITextField *textf = [[UITextField alloc]initWithFrame:CGRectMake(110, 10+50*i, SCREEN_WIDTH-125, 30)];
        switch (i) {
            case 0:
                textfield1 = textf;
                textfield1.placeholder = @"必填";
                break;
            case 1:
                textfield2 = textf;
                break;
            case 2:
                textfield3 = textf;
                break;
            case 3:
                textfield4 = textf;
                break;
            case 4:
                textfield5 = textf;
                break;
            case 5:
                textfield6 = textf;
                break;
            case 6:
                textfield7 = textf;
                break;
            case 7:
                textfield8 = textf;
                break;
            case 8:
                textfield9 = textf;
                break;
            case 9:
                textfield10 = textf;
                break;
            case 10:
                textfield11 = textf;
                break;
            case 11:
                textfield12 = textf;
                break;
            default:
                break;
        }
        textf.borderStyle = UITextBorderStyleRoundedRect;
        textf.delegate = self;
        [scrollview addSubview:textf];
    }
}


- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"订舱代理",@"省份",@"城市",@"区县",@"地址",@"固定电话",@"联系人姓名",@"移动电话",@"Email",@"开户银行",@"银行账户",@"银行账号"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 90, 30)];
        lable.text = arr[i];
        [scrollview addSubview:lable];
    }
}


@end
