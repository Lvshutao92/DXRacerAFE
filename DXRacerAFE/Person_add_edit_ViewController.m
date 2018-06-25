//
//  Person_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Person_add_edit_ViewController.h"
#import "ConfigDutyModel.h"
@interface Person_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    
    NSString *strid2;
   
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation Person_add_edit_ViewController


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
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
    
    strid2 = self.str2id;
    
    textfield1.text = self.str1;
    textfield2.text = self.str2;
    textfield3.text = self.str3;
    textfield4.text = self.str4;
    textfield5.text = self.str5;
    textfield6.text = self.str6;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(110, 90, SCREEN_WIDTH-120, 200)];
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
        if (textfield1.text.length == 0) {
            textfield1.text = @"";
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
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"person":textfield1.text,
            @"dutyId":strid2,
            @"qq":textfield3.text,
            @"wechat":textfield4.text,
            @"telephone":textfield5.text,
            @"email":textfield6.text,
            @"id":self.strid,
            };
//     NSLog(@"----%@",textfield1.text);
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealercontact",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"person":textfield1.text,
            @"dutyId":strid2,
            @"qq":textfield3.text,
            @"wechat":textfield4.text,
            @"telephone":textfield5.text,
            @"email":textfield6.text,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealercontact",@"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
    ConfigDutyModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
    textfield2.text = model.chineseName;
    strid2 = model.id;
   
    self.tableview.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ConfigDutyModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.chineseName;
    return cell;
}




- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealercontact",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"----%@",dic);
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"configDutyList"];

        [weakSelf.dataArray removeAllObjects];

        for (NSDictionary *dic in array) {
            ConfigDutyModel *model = [ConfigDutyModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        if ([weakSelf.navigationItem.title isEqualToString:@"新增"]) {
           
            ConfigDutyModel *model = weakSelf.dataArray.firstObject;
            textfield2.text = model.chineseName;
            strid2 = model.id;
        }
        
        
        [weakSelf.tableview  reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:textfield2]) {
        [textfield3 resignFirstResponder];
        [textfield4 resignFirstResponder];
        [textfield5 resignFirstResponder];
        [textfield6 resignFirstResponder];
        [textfield1 resignFirstResponder];
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
    for (int i = 0; i<6; i++) {
        UITextField *textf = [[UITextField alloc]initWithFrame:CGRectMake(110, 10+50*i, SCREEN_WIDTH-120, 30)];
        switch (i) {
            case 0:
                textfield1 = textf;
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
    NSMutableArray *arr = [@[@"联系人姓名",@"联系人职务",@"QQ",@"Skype",@"固定电话",@"Email"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 90, 30)];
        lable.text = arr[i];
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
