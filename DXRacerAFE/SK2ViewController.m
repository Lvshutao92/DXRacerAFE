//
//  SK2ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SK2ViewController.h"
#import "SK2Cell.h"
#import "SK2Model.h"
#import "LookPictureViewController.h"
#import "CommitPicViewController.h"
#import "AuditViewController.h"
#import "SK2_details_TableViewController.h"
#import "SK_search_two_ViewController.h"
@interface SK2ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation SK2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"SK2Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    if (self.str1.length == 0) {
        self.str1 = @"";
    }
    if (self.str2.length == 0) {
        self.str2 = @"";
    }
    
    [self setUpReflash];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SK_search_two_ViewController *search = [[SK_search_two_ViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    SK2Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SK2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SK2Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.paymentNo;
    cell.lab2.text = [Manager jinegeshi:model.totalFee];
    
    if ([model.paymentType isEqualToString:@"Deposit"]) {
        cell.lab3.text = @"定金";
    }else if ([model.paymentType isEqualToString:@"Retainage"]){
        cell.lab3.text = @"尾款";
    }
    
    [cell.lookbtn addTarget:self action:@selector(clickLookimg:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.lab4.text = [NSString stringWithFormat:@"%@ %@ %@",model.paymentCompanyName,model.paymentBankName,model.paymentBankNo];
    
    if([model.paymentStatus isEqualToString:@"confirm"]){
        if (model.receiptVoucher != nil) {
            cell.auditbtn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
            [cell.auditbtn addTarget:self action:@selector(clickAudit:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.auditbtn.backgroundColor = [UIColor lightGrayColor];
        }
        
        cell.commitpicbtn.backgroundColor = RGBACOLOR(33, 186, 245, 1.0);
        [cell.commitpicbtn addTarget:self action:@selector(clickCommitimg:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.auditbtn.backgroundColor = [UIColor lightGrayColor];
        cell.commitpicbtn.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    [cell.cancleauditbtn addTarget:self action:@selector(clickCancleAudit:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



- (void)clickCancleAudit:(UIButton *)sender{
    SK2Cell *cell = (SK2Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    SK2Model *model = [self.dataArray objectAtIndex:indexpath.row];

    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"username":[Manager redingwenjianming:@"userName.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"refuse") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"取消审核成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"取消审核失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}





- (void)clickLookimg:(UIButton *)sender{
    SK2Cell *cell = (SK2Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    SK2Model *model = [self.dataArray objectAtIndex:indexpath.row];
    LookPictureViewController *look = [[LookPictureViewController alloc]init];
    look.imgStr = model.paymentVoucher;
    [self.navigationController pushViewController:look animated:YES];
}
- (void)clickCommitimg:(UIButton *)sender{
    SK2Cell *cell = (SK2Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    SK2Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    CommitPicViewController *commit = [[CommitPicViewController alloc]init];
    commit.navigationItem.title = @"上传收款凭证";
    
    commit.str1 = model.paymentNo;
    commit.str2 = model.totalFee;
    commit.str3 = model.paymentBankName;
    commit.str4 = model.paymentBankNo;
    commit.str5 = model.receiptBankName;
    commit.str6 = model.receiptBankNo;
    
    commit.strid = model.id;
    [self.navigationController pushViewController:commit animated:YES];
}


- (void)clickAudit:(UIButton *)sender{
    SK2Cell *cell = (SK2Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    SK2Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AuditViewController *commit = [[AuditViewController alloc]init];
    commit.navigationItem.title = @"审核";
    
    commit.str1 = model.paymentNo;
    commit.str2 = model.totalFee;
    commit.str3 = model.paymentBankName;
    commit.str4 = model.paymentBankNo;
    commit.str5 = model.receiptBankName;
    commit.str6 = model.receiptBankNo;
    
    commit.strid = model.id;
    [self.navigationController pushViewController:commit animated:YES];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SK2Model *model = [self.dataArray objectAtIndex:indexPath.row];
    SK2_details_TableViewController *commit = [[SK2_details_TableViewController alloc]init];
    commit.navigationItem.title = @"详情";

    commit.strid = model.id;
    [self.navigationController pushViewController:commit animated:YES];
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
            @"Page":[NSString stringWithFormat:@"%ld",(long)page],
            @"paymentStatus":@"confirm",
            @"paymentNo":self.str1,
            @"paymentType":self.str2,
            };
    
    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"dic = %@",dic);
                totalnum = [[dic objectForKey:@"total"] integerValue];
                [weakSelf.dataArray removeAllObjects];
        
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
                for (NSDictionary *dic in arr) {
                    SK2Model *model = [SK2Model mj_objectWithKeyValues:dic];
        
                   
        
        
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
            @"Page":[NSString stringWithFormat:@"%ld",(long)page],
            @"paymentStatus":@"confirm",
            @"paymentNo":@"",
            @"paymentType":@"",
            };
    [session POST:KURLNSString2(@"servlet", @"receivables", @"manager",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dic in arr) {
            SK2Model *model = [SK2Model mj_objectWithKeyValues:dic];
            
            
            
            
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
