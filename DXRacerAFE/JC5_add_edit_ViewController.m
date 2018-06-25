//
//  JC5_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JC5_add_edit_ViewController.h"
#import "JC_5_Model.h"
@interface JC5_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    
    NSString *ids;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@end

@implementation JC5_add_edit_ViewController

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
    
    
    ids = self.str3id;
    
    
    text1.text = self.str1;
    text2.text = self.str2;
    
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(85, 140, SCREEN_WIDTH-100, 250)];
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
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        [self lodadd];
    }else{
        [self lodedit];
    }
}

- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"englishName":text1.text,
            @"chineseName":text2.text,
            @"areaId":ids,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcountry", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"englishName":text1.text,
            @"chineseName":text2.text,
            @"areaId":ids,
            @"id":self.strid,
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcountry", @"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
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
    JC_5_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    text3.text = model.chineseName;
    ids = model.id;
    self.tableview.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JC_5_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.chineseName;
    return cell;
}






- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"config", @"configcountry",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                                NSLog(@"----%@",dic);
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"areas"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            JC_5_Model *model = [JC_5_Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        JC_5_Model *model = weakSelf.dataArray.firstObject;
        text3.text = model.chineseName;
        ids = model.id;
        
        [weakSelf.tableview  reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}














- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text3]) {
        [text2 resignFirstResponder];
        [text1 resignFirstResponder];
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
    for (int i = 0; i<3; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(85, 10+50*i, SCREEN_WIDTH-100, 30)];
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
    NSMutableArray *arr = [@[@"英文名",@"中文名",@"区域列表"]mutableCopy];
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
