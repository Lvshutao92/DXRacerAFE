//
//  DX2_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "DX2_add_edit_ViewController.h"
#import "WD4_arr1_model.h"
#import "WD4_arr2_model.h"
@interface DX2_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
  
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    
    NSString *ids;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;
@end

@implementation DX2_add_edit_ViewController

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
    scrollview.contentSize = CGSizeMake(0, 600);
    scrollview.userInteractionEnabled = YES;
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    text1.text = self.str1;
    text2.text = self.str2;
    text3.text = self.str3;
    text4.text = self.str4;
    ids        = self.str1id;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 40, SCREEN_WIDTH-105, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    [self lodinfor];
}


- (void)clickSave{
    if ([self.navigationItem.title isEqualToString:@"新增"]){
        if (text2.text.length == 0) {
            text2.text = @"";
        }
        if (text3.text.length == 0) {
            text3.text = @"";
        }
        if (text4.text.length == 0) {
            text4.text = @"";
        }
        [self lodadd];
    }else{
        [self lodedit];
    }
}


- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"addressType":ids,
            @"addressEn":text2.text,
            @"addressCn":text3.text,
            @"zip":text4.text,
            @"id":self.idstr,
            };
    [session POST:KURLNSString2(@"servlet", @"server", @"dxraceraddress",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"addressType":ids,
            @"addressEn":text2.text,
            @"addressCn":text3.text,
            @"zip":text4.text,
            };
    [session POST:KURLNSString2(@"servlet", @"server", @"dxraceraddress",@"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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













- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WD4_arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
    text1.text = model.typeCn;
    ids = model.id;
    self.tableview.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WD4_arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.typeCn;
        return cell;
}




- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"server", @"dxraceraddress",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"----%@",dic);
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"configAddrTypeList"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            WD4_arr1_model *model = [WD4_arr1_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        
        if ([weakSelf.navigationItem.title isEqualToString:@"新增"]) {
            WD4_arr1_model *model = weakSelf.dataArray.firstObject;
            text1.text = model.typeCn;
            ids = model.id;
        }
        [weakSelf.tableview  reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text4 resignFirstResponder];
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    self.tableview.hidden = YES;
    return YES;
}






- (void)setUpRightTextfield{
    for (int i = 0; i<4; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(90, 10+50*i, SCREEN_WIDTH-105, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                break;
            case 1:
                text2 = lable;
                break;
            case 2:
                text3 = lable;
                break;
            case 3:
                text4 = lable;
                break;
            default:
                break;
        }
        lable.delegate = self;
        lable.font = [UIFont systemFontOfSize:16];
        lable.borderStyle=UITextBorderStyleRoundedRect;
        [scrollview addSubview:lable];
    }
}


- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"地址类型",@"英文名",@"中文名",@"邮编"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 70, 30)];
        lable.text = arr[i];
        lable.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lable];
    }
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
