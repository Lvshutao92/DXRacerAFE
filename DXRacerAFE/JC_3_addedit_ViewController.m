//
//  JC_3_addedit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JC_3_addedit_ViewController.h"

@interface JC_3_addedit_ViewController ()<UITextFieldDelegate>
{
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    UILabel *lab6;
   
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    
}
@property(nonatomic,strong)UIScrollView *scrollview;

@end

@implementation JC_3_addedit_ViewController
- (void)clickSave{
    
    if ([self.navigationItem.title isEqualToString:@"新增" ]) {
        if (textfield6.text.length == 0) {
            textfield6.text = @"";
        }
        if ( textfield1.text.length != 0 &&textfield2.text.length != 0 &&
            textfield3.text.length != 0 &&textfield4.text.length != 0 &&
            textfield5.text.length != 0 ) {
            [self lodAdd];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"除描述外，其余不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        if (textfield6.text.length == 0) {
            textfield6.text = @"";
        }
        if ( textfield1.text.length != 0 &&textfield2.text.length != 0 &&
            textfield3.text.length != 0 &&textfield4.text.length != 0 &&
            textfield5.text.length != 0 ) {
            [self lodedit];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"除描述外，其余不能为空" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
}




- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"containerCode":textfield1.text,
            @"containerLong":textfield2.text,
            @"containerWidth":textfield3.text,
            @"containerHeight":textfield4.text,
            @"containerCapacity":textfield5.text,
            @"description":textfield6.text,
            @"id":self.strid,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcontainer", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}














- (void)lodAdd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"containerCode":textfield1.text,
            @"containerLong":textfield2.text,
            @"containerWidth":textfield3.text,
            @"containerHeight":textfield4.text,
            @"containerCapacity":textfield5.text,
            @"description":textfield6.text,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcontainer", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
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
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-10)];
    self.scrollview.contentSize = CGSizeMake(0, 750);
    [self.view addSubview:self.scrollview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
    
    [self setUpView];
    
    textfield1.text = self.str1;
    textfield2.text = self.str2;
    textfield3.text = self.str3;
    textfield4.text = self.str4;
    textfield5.text = self.str5;
    textfield6.text = self.str6;
    
}

- (void)setUpView{
    
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 40)];
    lab1.text = @"集装箱名称";
    [self.scrollview addSubview:lab1];
    textfield1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-120, 40)];
    textfield1.delegate = self;
    textfield1.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 90, 40)];
    lab2.text = @"长(CM)";
    [self.scrollview addSubview:lab2];
    textfield2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 70, SCREEN_WIDTH-120, 40)];
    textfield2.delegate = self;
    textfield2.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 40)];
    lab3.text = @"宽(CM)";
    [self.scrollview addSubview:lab3];
    textfield3 = [[UITextField alloc]initWithFrame:CGRectMake(100, 130, SCREEN_WIDTH-120, 40)];
    textfield3.delegate = self;
    textfield3.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield3];
    
    lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, 90, 40)];
    lab4.text = @"高(CM)";
    [self.scrollview addSubview:lab4];
    textfield4 = [[UITextField alloc]initWithFrame:CGRectMake(100, 190, SCREEN_WIDTH-120, 40)];
    textfield4.delegate = self;
    textfield4.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield4];
    
    lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 90, 40)];
    lab5.text = @"容积(m³)";
    [self.scrollview addSubview:lab5];
    textfield5 = [[UITextField alloc]initWithFrame:CGRectMake(100, 250, SCREEN_WIDTH-120, 40)];
    textfield5.delegate = self;
    textfield5.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield5];
    
    
    lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, 90, 40)];
    lab6.text = @"描述";
    [self.scrollview addSubview:lab6];
    textfield6 = [[UITextField alloc]initWithFrame:CGRectMake(100, 310, SCREEN_WIDTH-120, 40)];
    textfield6.delegate = self;
    textfield6.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield6];
    
}









- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
