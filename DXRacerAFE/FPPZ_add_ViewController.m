//
//  FPPZ_add_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FPPZ_add_ViewController.h"
#import "jxs1model.h"
@interface FPPZ_add_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *ids;
}
@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FPPZ_add_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textfield.delegate = self;
    self.textfield.borderStyle = UITextBorderStyleRoundedRect;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 114, SCREEN_WIDTH-100, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    self.tableview.layer.borderColor = [UIColor blackColor].CGColor;
    self.tableview.layer.borderWidth = 1;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
    
    [self.view bringSubviewToFront:self.tableview];
    [self lodinformation];
}


- (void)clickSave{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":ids,
            };
    [session POST:KURLNSString2(@"servlet",@"invoice",@"invoiceconfig", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",[dic objectForKey:@"result_msg"]);
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









- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
   
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.companyName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    jxs1model *model = [self.dataArray objectAtIndex:indexPath.row];
    self.textfield.text = model.companyName;
    ids = model.id;
    
    self.tableview.hidden = YES;
}



- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet",@"invoice",@"invoiceconfig",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
        
        [weakSelf.dataArray removeAllObjects];

        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        for (NSDictionary *dic in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        jxs1model *model = weakSelf.dataArray.firstObject;
        weakSelf.textfield.text = model.companyName;
        ids = model.id;
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}











- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.tableview.hidden == YES) {
        self.tableview.hidden = NO;
    }else{
        self.tableview.hidden = YES;
    }
    return NO;
}






- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
