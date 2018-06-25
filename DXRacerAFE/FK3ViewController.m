//
//  FK3ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FK3ViewController.h"
#import "FK3Cell.h"

#import "FK_3_Details_TableViewController.h"
#import "FK3Model.h"
#import "LookPictureViewController.h"
#import "FK3_WanShan_ViewController.h"
@interface FK3ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FK3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.editing = NO;
    self.tableview.allowsMultipleSelectionDuringEditing = YES;
    [self.tableview registerNib:[UINib nibWithNibName:@"FK3Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
    [self setUpReflash];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FK_3_Details_TableViewController *fk3 = [[FK_3_Details_TableViewController alloc]init];
    fk3.navigationItem.title = @"明细";
    FK3Model *model = self.dataArray[indexPath.row];
    fk3.orderid = model.id;
    [self.navigationController pushViewController:fk3 animated:YES];
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 405;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseID = @"cell";
    
    FK3Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[FK3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FK3Model *model = self.dataArray[indexPath.row];
    
    
    
    
    
    
    
    if ([model.paymentType isEqualToString:@"Deposit"]) {
        cell.lab3.text =  @"定金";
    }else if ([model.paymentType isEqualToString:@"Retainage"]){
        cell.lab3.text =  @"尾款";
    }
    
    
    if (model.paymentVoucher.length != 0 || [model.paymentVoucher isEqual:[NSNull null]]) {
        [cell.lookbtn1 setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.lookbtn1 addTarget:self action:@selector(clciklook:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.lookbtn1 setTitle:@"-" forState:UIControlStateNormal];
        [cell.lookbtn1 addTarget:self action:@selector(clcikNolook:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (model.receiptVoucher.length != 0 || [model.receiptVoucher isEqual:[NSNull null]]) {
        [cell.lookbtn2 setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.lookbtn2 addTarget:self action:@selector(clciklook1:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.lookbtn2 setTitle:@"-" forState:UIControlStateNormal];
        [cell.lookbtn2 addTarget:self action:@selector(clcikNolook1:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.lab1.text =  model.paymentNo;
    cell.lab2.text =  [Manager jinegeshi:model.totalFee];
    cell.lab7.text  =  model.receiptCompanyName;
    cell.lab8.text  =  model.receiptBankName;
    cell.lab9.text  =  model.receiptBankNo;
    cell.lab10.text =  model.paymentCompanyName;
    cell.lab11.text =  model.paymentBankName;
    cell.lab12.text =  model.paymentBankNo;
   
    
    if ([model.paymentStatus isEqualToString:@"create"] &&
        !([model.paymentVoucher isEqual:[NSNull null]] || model.paymentVoucher.length == 0 || model.paymentVoucher==nil) &&
        !([model.receiptBankName isEqual:[NSNull null]] || model.receiptBankName.length == 0 || model.receiptBankName ==nil) &&
        !([model.receiptBankNo isEqual:[NSNull null]] || model.receiptBankNo.length == 0 || model.receiptBankNo ==nil) &&
        !([model.paymentBankName isEqual:[NSNull null]] || model.paymentBankName.length == 0 || model.paymentBankName ==nil) &&
        !([model.paymentBankNo isEqual:[NSNull null]] || model.paymentBankNo.length == 0 || model.paymentBankNo ==nil)){
        [cell.surebtn addTarget:self action:@selector(clickBtnSure:) forControlEvents:UIControlEventTouchUpInside];
        cell.surebtn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    }else{
        [cell.surebtn addTarget:self action:@selector(clickNoBtnSure:) forControlEvents:UIControlEventTouchUpInside];
        cell.surebtn.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    if ([model.paymentStatus isEqualToString:@"create"]) {
        cell.lab4.text =  @"创建成功";
        [cell.wanshanbtn addTarget:self action:@selector(clickWanShanInformation:) forControlEvents:UIControlEventTouchUpInside];
        cell.wanshanbtn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
        
    }else if ([model.paymentStatus isEqualToString:@"confirm"]) {
        cell.lab4.text =  @"确认支付";
        [cell.wanshanbtn addTarget:self action:@selector(clicccc:) forControlEvents:UIControlEventTouchUpInside];
        cell.wanshanbtn.backgroundColor = [UIColor lightGrayColor];
    }else if ([model.paymentStatus isEqualToString:@"paysuccess"]) {
        cell.lab4.text =  @"支付成功";
        [cell.wanshanbtn addTarget:self action:@selector(clicccc1:) forControlEvents:UIControlEventTouchUpInside];
        cell.wanshanbtn.backgroundColor = [UIColor lightGrayColor];
    }else if ([model.paymentStatus isEqualToString:@"payfail"]) {
        cell.lab4.text =  @"支付失败";
        [cell.wanshanbtn addTarget:self action:@selector(clicccc2:) forControlEvents:UIControlEventTouchUpInside];
        cell.wanshanbtn.backgroundColor = [UIColor lightGrayColor];
    }else if ([model.paymentStatus isEqualToString:@"canceled"]) {
        cell.lab4.text =  @"取消成功";
        [cell.wanshanbtn addTarget:self action:@selector(clicccc3:) forControlEvents:UIControlEventTouchUpInside];
        cell.wanshanbtn.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    return cell;
}

- (void)clickBtnSure:(UIButton *)sender{
    
    FK3Cell *cell = (FK3Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK3Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    [self lodsureinformation:model.id];
}




- (void)lodsureinformation:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":idstr,
            };
    [session POST:KURLNSString3(@"servlet", @"payment", @"dealer",@"information",@"confirm") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确认成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (void)clickWanShanInformation:(UIButton *)sender{
    
    FK3Cell *cell = (FK3Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK3Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    if ([model.paymentStatus isEqualToString:@"create"]){
        FK3_WanShan_ViewController *infor = [[FK3_WanShan_ViewController alloc]init];
        infor.strid = model.id;
        infor.str1 = model.paymentNo;
        infor.str2 = model.totalFee;
        [self.navigationController pushViewController:infor animated:YES];
    }
    
}











- (void)clickNoBtnSure:(UIButton *)sender{};
- (void)clcikNolook:(UIButton *)sender{}
- (void)clcikNolook1:(UIButton *)sender{}
- (void)clicccc:(UIButton *)sender{}
- (void)clicccc1:(UIButton *)sender{}
- (void)clicccc2:(UIButton *)sender{}
- (void)clicccc3:(UIButton *)sender{}

- (void)clciklook:(UIButton *)sender{
    
    FK3Cell *cell = (FK3Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK3Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
    lookpic.imgStr =  model.paymentVoucher;
    [self.navigationController pushViewController:lookpic animated:YES];
    
}
- (void)clciklook1:(UIButton *)sender{
    FK3Cell *cell = (FK3Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK3Model *model = [self.dataArray objectAtIndex:indexpath.row];
    LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
    lookpic.imgStr =  model.receiptVoucher;
    [self.navigationController pushViewController:lookpic animated:YES];
    
}

//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    
    [session POST:KURLNSString3(@"servlet", @"payment", @"dealer", @"create",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            FK3Model *model = [FK3Model mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        page=2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString3(@"servlet", @"payment", @"dealer", @"create",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);

        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            FK3Model *model = [FK3Model mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}
















- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
