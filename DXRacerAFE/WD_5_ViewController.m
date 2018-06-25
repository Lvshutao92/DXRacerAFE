//
//  WD_5_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WD_5_ViewController.h"
#import "WD_5_Cell.h"
#import "WD_5_Mode.h"
#import "WD_5_Add_Edit_ViewController.h"
@interface WD_5_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation WD_5_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WD_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    button.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [button setTitle:@"新增" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
    
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 420;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    WD_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[WD_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.editbtn.layer.borderWidth = 1;
    cell.editbtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.editbtn.layer.masksToBounds = YES;
    cell.editbtn.layer.cornerRadius = 5;
    
    cell.delebtn.layer.borderWidth = 1;
    cell.delebtn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.delebtn.layer.masksToBounds = YES;
    cell.delebtn.layer.cornerRadius = 5;
    
    
    [cell.editbtn addTarget:self action:@selector(clickedit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delebtn addTarget:self action:@selector(clickdele:) forControlEvents:UIControlEventTouchUpInside];
    
    
    WD_5_Mode *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.lab1.text = model.bookingAgent;
    cell.lab2.text = model.province;
    cell.lab3.text = model.city;
    cell.lab4.text = model.county;
    cell.lab5.text = model.detailAddress;
    cell.lab6.text = model.telephone;
    
    
    cell.lab7.text  = model.contactPerson;
    
    
    cell.lab8.text  = model.mobilePhone;
    
    
    cell.lab9.text  = model.mailbox;
    cell.lab10.text = model.openBank;
    cell.lab11.text = model.bankAccount;
    cell.lab12.text = model.bankNumber;
    
    return cell;
}

- (void)clickedit:(UIButton *)sender{
    WD_5_Cell *cell = (WD_5_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    WD_5_Mode *model = [self.dataArray objectAtIndex:indexpath.row];
    WD_5_Add_Edit_ViewController *edit = [[WD_5_Add_Edit_ViewController alloc]init];
    edit.navigationItem.title = @"编辑";
    edit.strid = model.id;
   
    edit.str1 = model.bookingAgent;
    edit.str2 = model.province;
    edit.str3 = model.city;
    edit.str4 = model.county;
    edit.str5 = model.detailAddress;
    edit.str6 = model.telephone;
    edit.str7 = model.contactPerson;
    edit.str8 = model.mobilePhone;
    edit.str9 = model.mailbox;
    edit.str10 = model.openBank;
    edit.str11 = model.bankAccount;
    edit.str12 = model.bankNumber;
    [self.navigationController pushViewController:edit animated:YES];
}
- (void)clickadd{
    WD_5_Add_Edit_ViewController *add = [[WD_5_Add_Edit_ViewController alloc]init];
    add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
}



- (void)clickdele:(UIButton *)sender{
    WD_5_Cell *cell = (WD_5_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    WD_5_Mode *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine",@"dealerforward",@"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"----%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                //删除
                [self.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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
    
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine", @"dealerforward",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"dic = %@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            WD_5_Mode *model = [WD_5_Mode mj_objectWithKeyValues:dic];
            
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
    [session POST:KURLNSString3(@"servlet", @"dealer", @"mine", @"dealerforward",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            WD_5_Mode *model = [WD_5_Mode mj_objectWithKeyValues:dic];
            
            [weakSelf.dataArray addObject:model];
        }
        
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}























- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end