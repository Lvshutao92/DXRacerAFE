//
//  PL_02_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PL_02_ViewController.h"
#import "PL_02_Cell.h"
#import "ModelOne.h"
#import "Model01.h"
#import "Model02.h"
#import "Piliang_kemaichanpin_Cell.h"
#import "tradeGoodsModel.h"
#import "configCurrency_Model.h"
@interface PL_02_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    UILabel *lable;
    NSString *productCode;
    CGFloat height;
    
    CGFloat height1;
    CGFloat height2;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation PL_02_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
 
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"Piliang_kemaichanpin_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 111)];
    self.tableview.tableHeaderView = view;
    
    lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, 61)];
    lable.textColor = [UIColor redColor];
    lable.font = [UIFont systemFontOfSize:13];
    lable.numberOfLines = 0;
    [view addSubview:lable];
    
    
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = NSLocalizedString(@"a20", nil);
    [view addSubview:_searchbar];
    
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [view addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [view addSubview:line2];
    
    [self lodgetdata];
    
    
    
    
    
    
    [self setUpReflash];
    
    
}



#pragma mark --searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    productCode = searchBar.text;
    [self setUpReflash];
    [searchBar resignFirstResponder];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    productCode = @"";
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}







- (void)lodgetdata{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    
    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"view",@"initpage") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  %@",NSLocalizedString(@"tishi", nil),[dic objectForKey:@"dateStr"]]];
        //NSLog(@"-----%ld",string.length);
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,105)];
        }else{
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,32)];
        }
        lable.attributedText = string;
        
        
//        lable.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@  %@",NSLocalizedString(@"tishi", nil),[dic objectForKey:@"dateStr"]]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155+height2+height1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    Piliang_kemaichanpin_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Piliang_kemaichanpin_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    
    cell.lab6.hidden = YES;
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (model.goodsModel.imageUrl == nil) {
        cell.img.image = [UIImage imageNamed:@"未标题-2"];
    }else{
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.goodsModel.imageUrl)] placeholderImage:[UIImage imageNamed:@"未标题-2"]];
    }
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab3.layer.masksToBounds = YES;
    cell.lab3.layer.cornerRadius = 5;
    
    cell.lab4.layer.masksToBounds = YES;
    cell.lab4.layer.cornerRadius = 5;
    if (model.goodsModel.fcnoNameEnglish == nil || [model.goodsModel.fcnoNameEnglish isEqual:[NSNull null]]  || model.goodsModel.fcnoNameEnglish.length == 0) {
        model.goodsModel.fcnoNameEnglish = @"-";
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.goodsModel.fcnoNameEnglish];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.goodsModel.fcnoNameChinese];
    }
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height1 = size.height;
    
    
    
    cell.lab2.text = [NSString stringWithFormat:@"%@ - %@ - %@",model.goodsModel.fcno,model.goodsModel.itemno,model.goodsModel.model];
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size2 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab2height.constant = size2.height;
    height2 = size2.height;
    
    if (height1 > 20 && height2 >20) {
        cell.imgtop.constant = height1+height2-20;
    }else if(height1 > 20 && height2 <= 20){
        cell.imgtop.constant = height1+height2-10;
    }else if(height1 <= 20 && height2 > 20){
        cell.imgtop.constant = height1+height2-10;
    }else{
        cell.imgtop.constant = height1+height2;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    CGFloat shu = floor([model.goodsModel.packageLength floatValue] * [model.goodsModel.packageWidth floatValue] * [model.goodsModel.packageHeight floatValue]/1000000*100)/100;
    
    
    cell.lab3.text = [NSString stringWithFormat:@"%@m³",[NSString stringWithFormat:@"%.2lf",shu]];
    
    
    
    
    
    cell.lab4.text = [NSString stringWithFormat:@"%@kg",model.goodsModel.packageWeight];
    
    cell.lab5.text = [NSString stringWithFormat:@"%@%.2f",model.dealerInfoModel.currmodel.field1,[model.unitPrice floatValue]];
    cell.lab5.font = [UIFont systemFontOfSize:18];

    
    [cell.btn setTitle:NSLocalizedString(@"f4", nil) forState:UIControlStateNormal];
    [cell.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    cell.btn.layer.masksToBounds = YES;
    cell.btn.layer.cornerRadius = 15;
    cell.btn.layer.borderWidth = 1.0;
    cell.btn.layer.borderColor = [UIColor redColor].CGColor;
    
    [cell.btn addTarget:self action:@selector(clickButtonAddCurt:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
    
    
    
    
    return cell;
}


- (void)clickButtonAddCurt:(UIButton *)sender{
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"a21", nil) preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        PL_02_Cell *cell = (PL_02_Cell *)[sender.superview superview];
        NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
        ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
        
        UITextField *TextField1 = alertController.textFields.firstObject;
        NSInteger inter = [TextField1.text integerValue];
        
        
        
        
        if (TextField1.text.length != 0 && model.goodsModel.fcno.length != 0 && inter >= [[Manager sharedManager].gerenMin integerValue] && inter <= [[Manager sharedManager].gerenMax integerValue]) {

             [self lodAddCurt:TextField1.text fcno:model.goodsModel.fcno];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:[NSString stringWithFormat:@"%@%@-%@",NSLocalizedString(@"x23", nil),[Manager sharedManager].gerenMin,[Manager sharedManager].gerenMax] preferredStyle:1];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
       
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [NSString stringWithFormat:@"%@",[Manager sharedManager].gerenMin];
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
 
}

- (void)lodAddCurt:(NSString *)num fcno:(NSString *)fcno {
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"loginId":[Manager redingwenjianming:@"loginId.text"],
            @"fcno":fcno,
            @"quantity":num,
            };
//    NSLog(@"%@--------",dic);
    [session POST:KURLNSString2(@"servlet", @"batch", @"batchshoppingcart", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"a22", nil) preferredStyle:1];
           
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
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
    if (productCode.length == 0) {
        productCode = @"";
    }
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"orderType":@"batchOrder",
            @"productCode":productCode,
            
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
//    NSLog(@"+++%@",dic);
    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"view",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dict];
            
            
            Model02 *model1 = [Model02 mj_objectWithKeyValues:model.goods];
            model.goodsModel = model1;
            
            tradeGoodsModel *model2 = [tradeGoodsModel mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfoModel = model2;
            
            configCurrency_Model *model3 = [configCurrency_Model mj_objectWithKeyValues:model2.configCurrency];
            model2.currmodel = model3;
        
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
    if (productCode.length == 0) {
        productCode = @"";
    }
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"orderType":@"batchOrder",
            @"productCode":productCode,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    
    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"view",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dict];
            
            
            Model02 *model1 = [Model02 mj_objectWithKeyValues:model.goods];
            model.goodsModel = model1;
            
            tradeGoodsModel *model2 = [tradeGoodsModel mj_objectWithKeyValues:model.dealerInfo];
            model.dealerInfoModel = model2;
            
            configCurrency_Model *model3 = [configCurrency_Model mj_objectWithKeyValues:model2.configCurrency];
            model2.currmodel = model3;
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
