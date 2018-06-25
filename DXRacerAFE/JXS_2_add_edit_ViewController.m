//
//  JXS_2_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_2_add_edit_ViewController.h"
#import "jxs1model.h"
@interface JXS_2_add_edit_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    
    NSString *idstr1;
    
    NSString *idstr3;
  
}
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)NSMutableArray *idarr;
@property(nonatomic,strong)NSMutableArray *Array1;
@property(nonatomic,strong)NSMutableArray *Array2;
@property(nonatomic,strong)NSMutableArray *Array3;


@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)UITableView *tableview2;
@property(nonatomic,strong)UITableView *tableview3;


@end

@implementation JXS_2_add_edit_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-10)];
    self.scrollview.contentSize = CGSizeMake(0, 750);
    [self.view addSubview:self.scrollview];
    
    
    
    self.Array2 = [@[@"T/T",@"L/C"]mutableCopy];
    self.Array3 = [@[@"出货前",@"出货后"]mutableCopy];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
    
    [self setUpView];
    
    
    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        textfield2.text = self.Array2[0];
        textfield3.text = self.Array3[0];
        idstr3 = @"before";
    }else{
        
        textfield1.text = self.str1;
        idstr1 = self.str1id;
        
        textfield2.text = self.str2;
        textfield3.text = self.str3;
        idstr3 = self.str3id;
        
        textfield4.text = self.str4;
        textfield5.text = self.str5;
        
        
        if ([textfield2.text isEqualToString:@"L/C"]) {
            lab3.hidden = YES;
            lab4.hidden = YES;
            lab5.hidden = YES;
            textfield3.hidden = YES;
            textfield4.hidden = YES;
            textfield5.hidden = YES;
        }else if ([textfield2.text isEqualToString:@"T/T"]) {
            lab3.hidden = NO;
            lab4.hidden = NO;
            textfield3.hidden = NO;
            textfield4.hidden = NO;
            
            if ([textfield3.text isEqualToString:@"出货前"]) {
                lab5.hidden = YES;
                textfield5.hidden = YES;
            }
            if ([textfield3.text isEqualToString:@"出货后"]) {
                lab5.hidden = NO;
                textfield5.hidden = NO;
            }
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(100, 50, SCREEN_WIDTH-120, 250)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    self.tableview1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview1.layer.borderWidth = 1.0;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.scrollview addSubview:self.tableview1];
    [self.scrollview bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(100, 110, SCREEN_WIDTH-120, 100)];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    self.tableview2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview2.layer.borderWidth = 1.0;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.scrollview addSubview:self.tableview2];
    [self.scrollview bringSubviewToFront:self.tableview2];
    
    
    self.tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(100, 170, SCREEN_WIDTH-120, 100)];
    self.tableview3.delegate = self;
    self.tableview3.dataSource = self;
    self.tableview3.hidden = YES;
    self.tableview3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview3.layer.borderWidth = 1.0;
    [self.tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.scrollview addSubview:self.tableview3];
    [self.scrollview bringSubviewToFront:self.tableview3];
    
    
    
    [self lodinformation];
    
}



- (void)clickSave{

    
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        
        
        if ([textfield2.text isEqualToString:@"T/T"]) {
            if ([textfield3.text isEqualToString:@"出货前"]) {
                if (textfield4.text.length != 0) {
                    textfield5.text = @"";
                    [self lodadd];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"定金不能为空" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }else  if ([textfield3.text isEqualToString:@"出货后"]) {
                if (textfield4.text.length != 0 && textfield5.text.length != 0) {
                    [self lodadd];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"定金/结算周期不能为空" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
            
        }else if ([textfield2.text isEqualToString:@"L/C"]) {
             idstr3 = @"";
             textfield4.text = @"";
             textfield5.text = @"";
             [self lodadd];
        }
        
        
    }else{
        if ([textfield2.text isEqualToString:@"T/T"]) {
            if ([textfield3.text isEqualToString:@"出货前"]) {
                if (textfield4.text.length != 0) {
                    textfield5.text = @"";
                    [self lopdedit];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"定金不能为空" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }else  if ([textfield3.text isEqualToString:@"出货后"]) {
                if (textfield4.text.length != 0 && textfield5.text.length != 0) {
                    [self lopdedit];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"定金/结算周期不能为空" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
            
        }else if ([textfield2.text isEqualToString:@"L/C"]) {
            idstr3 = @"";
            textfield4.text = @"";
            textfield5.text = @"";
            [self lopdedit];
        }
    }
    
    
}






- (void)lopdedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.idstr,
            @"dealerId":idstr1,
            @"paymentType":textfield2.text,
            @"retainageType":idstr3,
            @"proportion":textfield4.text,
            @"lcday":textfield5.text,
            };
    NSLog(@"%@",[dic objectForKey:@"lcday"]);
    [session POST:KURLNSString2(@"servlet", @"dealer",@"manager",@"dealerpayment/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑成功😊" preferredStyle:1];
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
            
            @"dealerId":idstr1,
            @"paymentType":textfield2.text,
            @"retainageType":idstr3,
            @"proportion":textfield4.text,
            @"lcday":textfield5.text,
            };
    [session POST:KURLNSString2(@"servlet", @"dealer",@"manager",@"dealerpayment/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新增成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

















- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.Array1.count;
    }
    if ([tableView isEqual:self.tableview2]) {
        return self.Array2.count;
    }
    return self.Array3.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.textLabel.text = [self.Array1 objectAtIndex:indexPath.row];
        return cell;
    }
    if ([tableView isEqual:self.tableview2]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
         cell.textLabel.text = [self.Array2 objectAtIndex:indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
     cell.textLabel.text = [self.Array3 objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([tableView isEqual:self.tableview1]) {
        textfield1.text = [self.Array1 objectAtIndex:indexPath.row];
        idstr1 = self.idarr[indexPath.row];
    }
    
    
    if ([tableView isEqual:self.tableview2]) {
        textfield2.text = [self.Array2 objectAtIndex:indexPath.row];
        if ([textfield2.text isEqualToString:@"L/C"]) {
            lab3.hidden = YES;
            lab4.hidden = YES;
            lab5.hidden = YES;
            textfield3.hidden = YES;
            textfield4.hidden = YES;
            textfield5.hidden = YES;
            
            
            
            
            
        }else if ([textfield2.text isEqualToString:@"T/T"]) {
            lab3.hidden = NO;
            lab4.hidden = NO;
            textfield3.hidden = NO;
            textfield4.hidden = NO;
        }
    }
    
    
    
    
    if ([tableView isEqual:self.tableview3]) {
        textfield3.text = [self.Array3 objectAtIndex:indexPath.row];
        if ([textfield3.text isEqualToString:@"出货前"]) {
            idstr3 = @"before";
            lab5.hidden = YES;
            textfield5.hidden = YES;
        }
        if ([textfield3.text isEqualToString:@"出货后"]) {
            idstr3 = @"after";
            lab5.hidden = NO;
            textfield5.hidden = NO;
        }
    }
    
    
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
}







- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString3(@"servlet", @"dealer",@"manager",@"dealerpayment",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//         NSLog(@"%@",dic);
        
        [weakSelf.Array1 removeAllObjects];

        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerInfoList"];
        for (NSDictionary *dic in arr) {
            jxs1model *model = [jxs1model mj_objectWithKeyValues:dic];
            [weakSelf.Array1 addObject:model.companyName];
            
            [weakSelf.idarr addObject:model.id];
        }
        
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            textfield1.text = weakSelf.Array1.firstObject;
            idstr1 = weakSelf.idarr.firstObject;
        }
        
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.navigationItem.title isEqualToString:@"新增"]){
        if ([textField isEqual:textfield1]) {
            self.tableview2.hidden = YES;
            self.tableview3.hidden = YES;
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:textfield2]) {
            self.tableview1.hidden = YES;
            self.tableview3.hidden = YES;
            if (self.tableview2.hidden == YES) {
                self.tableview2.hidden = NO;
            }else{
                self.tableview2.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:textfield3]) {
            self.tableview1.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview3.hidden == YES) {
                self.tableview3.hidden = NO;
            }else{
                self.tableview3.hidden = YES;
            }
            return NO;
        }
    }else{
        if ([textField isEqual:textfield1]) {
            return NO;
        }
        if ([textField isEqual:textfield2]) {
            self.tableview1.hidden = YES;
            self.tableview3.hidden = YES;
            if (self.tableview2.hidden == YES) {
                self.tableview2.hidden = NO;
            }else{
                self.tableview2.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:textfield3]) {
            self.tableview1.hidden = YES;
            self.tableview2.hidden = YES;
            if (self.tableview3.hidden == YES) {
                self.tableview3.hidden = NO;
            }else{
                self.tableview3.hidden = YES;
            }
            return NO;
        }
    }
    
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    return YES;
}


- (void)setUpView{
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 40)];
    lab1.text = @"公司名称";
    [self.scrollview addSubview:lab1];
    textfield1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-120, 40)];
    textfield1.delegate = self;
    textfield1.placeholder = @"请选择";
    textfield1.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 90, 40)];
    lab2.text = @"付款方式";
    [self.scrollview addSubview:lab2];
    textfield2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 70, SCREEN_WIDTH-120, 40)];
    textfield2.delegate = self;
    textfield2.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 40)];
    lab3.text = @"尾款";
    [self.scrollview addSubview:lab3];
    textfield3 = [[UITextField alloc]initWithFrame:CGRectMake(100, 130, SCREEN_WIDTH-120, 40)];
    textfield3.delegate = self;
    textfield3.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield3.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield3];
    
    lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, 90, 40)];
    lab4.text = @"定金";
    [self.scrollview addSubview:lab4];
    textfield4 = [[UITextField alloc]initWithFrame:CGRectMake(100, 190, SCREEN_WIDTH-120, 40)];
    textfield4.delegate = self;
    textfield4.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield4.placeholder = @"30";
    textfield4.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield4];
    
    
    
    lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 90, 40)];
    lab5.text = @"结算周期";
    [self.scrollview addSubview:lab5];
    textfield5 = [[UITextField alloc]initWithFrame:CGRectMake(100, 250, SCREEN_WIDTH-120, 40)];
    textfield5.delegate = self;
    textfield5.backgroundColor = [UIColor colorWithWhite:.9 alpha:.4];
    textfield5.placeholder = @"30";
    textfield5.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollview addSubview:textfield5];
    
    
    lab5.hidden = YES;
    textfield5.hidden = YES;
    
}

- (NSMutableArray *)Array1{
    if (_Array1 == nil) {
        self.Array1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array1;
}
- (NSMutableArray *)Array2{
    if (_Array2 == nil) {
        self.Array2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array2;
}
- (NSMutableArray *)Array3{
    if (_Array3 == nil) {
        self.Array3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array3;
}

- (NSMutableArray *)idarr{
    if (_idarr == nil) {
        self.idarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _idarr;
}
@end
