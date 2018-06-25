//
//  XH_01_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XH_01_ViewController.h"
#import "XH01Cell.h"

#import "PL_01_Model.h"
#import "PL_01_GoodsModel.h"
#import "PL_01_Deleargoods_Model.h"
#import "XH_search_one_ViewController.h"

#import "PiLiang_Chanpinliulan_Cell.h"
@interface XH_01_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    
    CGFloat height1;
    CGFloat height2;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
}
@property (nonatomic, strong)UIScrollView *BgView;





@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation XH_01_ViewController

- (void)clicksearch{
//    XH_search_one_ViewController *search = [[XH_search_one_ViewController alloc]init];
//    search.navigationItem.title = NSLocalizedString(@"x7", nil);
//    [self.navigationController pushViewController:search animated:YES];
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    text2.text = nil;
}


- (void)setupButton {
    
    CGFloat heights;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        heights = 88;
    }else{
        heights = 64;
    }
    
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, heights, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.BgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.BgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
    lab1.text = @"FCNO";
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"FCNO";
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    lab2.text = @"MODEL";
    [self.BgView addSubview:lab2];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10,145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"MODEL";
    text2.text = @"";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text2];
    
    
  
    
    
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-350);
    [window addSubview:_BgView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-350, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:NSLocalizedString(@"sure", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-349, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:NSLocalizedString(@"n", nil) forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    
    [self setUpReflash];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    text2.text = nil;
}




- (void)sure{
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}









- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"PiLiang_Chanpinliulan_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
//    // Do any additional setup after loading the view.
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    self.tableview.tableHeaderView = view;
//    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    _searchbar.delegate = self;
//    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
//    _searchbar.placeholder = @"请点击进行检索";
//    [view addSubview:_searchbar];
    
   
    [self setupButton];
}
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    XH_search_one_ViewController *search = [[XH_search_one_ViewController alloc]init];
//    search.navigationItem.title = @"检索";
//    [self.navigationController pushViewController:search animated:YES];
//    return NO;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120+height1+height2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifierCell = @"cell";
    PiLiang_Chanpinliulan_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[PiLiang_Chanpinliulan_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PL_01_Model *model = [self.dataArray objectAtIndex:indexPath.row];

    
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.goodsModel.imageUrl)] placeholderImage:[UIImage imageNamed:@"未标题-2"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab3.layer.masksToBounds = YES;
    cell.lab3.layer.cornerRadius = 5;
    
    cell.lab4.layer.masksToBounds = YES;
    cell.lab4.layer.cornerRadius = 5;
    if (model.goodsModel.skuNameEn == nil || [model.goodsModel.skuNameEn isEqual:[NSNull null]] || model.goodsModel.skuNameEn.length == 0) {
        model.goodsModel.skuNameEn = @"-";
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.goodsModel.skuNameEn];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.goodsModel.skuNameCn];
    }
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height1 = size.height;
    
    
    cell.lab2.text = [NSString stringWithFormat:@"%@ - %@",model.goodsModel.skuCode,model.goodsModel.productCode];
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size2 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab2height.constant = size2.height;
    height2 = size2.height;
    
    if (height1 > 20 && height2 >20) {
        cell.imgtop.constant = height1+height2-40;
    }else if(height1 > 20 && height2 <= 20){
        cell.imgtop.constant = height1+height2-30;
    }else if(height1 <= 20 && height2 > 20){
        cell.imgtop.constant = height1+height2-30;
    }else{
        cell.imgtop.constant = height1+height2-20;
    }
    
    
    
    
    
    cell.lab3.text = [NSString stringWithFormat:@"%@cm",[NSString stringWithFormat:@"%@*%@*%@",model.goodsModel.packageLength,model.goodsModel.packageWidth,model.goodsModel.packageHeight]];
    cell.lab4.text = [NSString stringWithFormat:@"%@kg",model.goodsModel.packageWeight];
    
    if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"N"] || model.dealerGoodsModel.dealerUseStatus == nil) {
        [cell.btn setTitle:NSLocalizedString(@"f2", nil) forState:UIControlStateNormal];
        [cell.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.cornerRadius = 15;
        cell.btn.layer.borderWidth = 1.0;
        cell.btn.layer.borderColor = [UIColor redColor].CGColor;
        
    }else if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"A"]) {
        [cell.btn setTitle:NSLocalizedString(@"f1", nil) forState:UIControlStateNormal];
        [cell.btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        cell.btn.layer.borderColor = [UIColor clearColor].CGColor;
    }else if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"Y"]) {
        [cell.btn setTitle:NSLocalizedString(@"f3", nil) forState:UIControlStateNormal];
        [cell.btn setTitleColor:RGBACOLOR(56, 56, 56, 1) forState:UIControlStateNormal];
        
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.cornerRadius = 15;
        cell.btn.layer.borderWidth = 1.0;
        cell.btn.layer.borderColor = RGBACOLOR(56, 56, 56, 1).CGColor;
    }
    
    [cell.btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    cell.lab5.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"f9", nil),model.goodsModel.currentQuantity];
    
    
    
    
    return cell;
}
-(void)clickButton:(UIButton *)sender{
    XH01Cell *cell = (XH01Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PL_01_Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"Y"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"no", nil) preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self lodcancle:[NSString stringWithFormat:@"%@",model.goodsModel.id]];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
 
    }else if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"A"]){
    
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"uuu", nil) preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self lodsure:[NSString stringWithFormat:@"%@",model.goodsModel.id]];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}


- (void)lodsure:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":idstr,
            };
    
    [session POST:KURLNSString3(@"servlet", @"trade", @"shopping", @"apply",@"apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"a23", nil) preferredStyle:1];
           
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)lodcancle:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":idstr,
            };
    
    [session POST:KURLNSString3(@"servlet", @"trade", @"shopping", @"apply",@"cancel") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"a24", nil) preferredStyle:1];
    
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
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
            @"orderType":@"tradOrder",
            
            @"productCode":text1.text,
            @"skuCode":text2.text,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    
    [session POST:KURLNSString3(@"servlet", @"trade", @"shopping", @"apply",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            PL_01_Model *model = [PL_01_Model mj_objectWithKeyValues:dict];
            
            
            PL_01_GoodsModel *model1 = [PL_01_GoodsModel mj_objectWithKeyValues:model.goods];
            model.goodsModel = model1;
            
            
            
            PL_01_Deleargoods_Model *model2 = [PL_01_Deleargoods_Model mj_objectWithKeyValues:model.dealerGoods];
            model.dealerGoodsModel = model2;
            
            
            
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
            @"orderType":@"tradOrder",
            
            @"productCode":text1.text,
            @"skuCode":text2.text,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    
    [session POST:KURLNSString3(@"servlet", @"trade", @"shopping", @"apply",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            PL_01_Model *model = [PL_01_Model mj_objectWithKeyValues:dict];
            
            
            PL_01_GoodsModel *model1 = [PL_01_GoodsModel mj_objectWithKeyValues:model.goods];
            model.goodsModel = model1;
            
            
            
            PL_01_Deleargoods_Model *model2 = [PL_01_Deleargoods_Model mj_objectWithKeyValues:model.dealerGoods];
            model.dealerGoodsModel = model2;
            
            
            
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


@end
