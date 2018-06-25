//
//  FP_addr_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FP_addr_ViewController.h"
#import "WDFPModel.h"
@interface FP_addr_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FP_addr_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text1.borderStyle = UITextBorderStyleRoundedRect;
    self.text2.borderStyle = UITextBorderStyleRoundedRect;
    self.text3.borderStyle = UITextBorderStyleRoundedRect;
    
    
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
    
    if (self.text1.text.length != 0 && self.text2.text.length != 0 && self.text3.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"receiveAddress":self.text1.text,
                @"receivePerson":self.text2.text,
                @"telephone":self.text3.text,
                @"id":self.strid,
                };
//        NSLog(@"%@",dic);
        [session POST:KURLNSString2(@"servlet",@"invoice",@"edit", @"receiver") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"添加成功" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"添加失败" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"信息均不能为空" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}









- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
    WDFPModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",model.receiveProvince,model.receiveCity,model.receiveArea,model.receiveAddress,model.zip];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WDFPModel *model = [self.dataArray objectAtIndex:indexPath.row];
    self.text1.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",model.receiveProvince,model.receiveCity,model.receiveArea,model.receiveAddress,model.zip];
    
    self.tableview.hidden = YES;
}



- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            };
    [session POST:KURLNSString2(@"servlet",@"invoice",@"edit",@"receivertext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                        NSLog(@"%@",dic);
        
        [weakSelf.dataArray removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dic in arr) {
            WDFPModel *model = [WDFPModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text1]) {
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    return YES;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
