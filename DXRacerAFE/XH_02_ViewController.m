//
//  XH_02_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XH_02_ViewController.h"

#import "XH02Cell.h"

#import "XHo2Model.h"
#import "tradeGoodsModel.h"

#import "Piliang_kemaichanpin_Cell.h"
#import "configCurrency_Model.h"
@interface XH_02_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    NSString *productCode;
    
    CGFloat height1;
    CGFloat height2;
}

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation XH_02_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"可买产品";
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"Piliang_kemaichanpin_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = NSLocalizedString(@"a20", nil);
    [view addSubview:_searchbar];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [view addSubview:line1];
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    XHo2Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    if (model.model1.imageUrl == nil) {
        cell.img.image = [UIImage imageNamed:@"未标题-2"];
    }else{
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.model1.imageUrl)] placeholderImage:[UIImage imageNamed:@"未标题-2"]];
    }
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab3.layer.masksToBounds = YES;
    cell.lab3.layer.cornerRadius = 5;
    
    cell.lab4.layer.masksToBounds = YES;
    cell.lab4.layer.cornerRadius = 5;
    if (model.model1.skuNameEn == nil || [model.model1.skuNameEn isEqual:[NSNull null]]  || model.model1.skuNameEn.length == 0) {
        model.model1.skuNameEn = @"-";
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.model1.skuNameEn];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.model1.skuNameCn];
    }
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height1 = size.height;
    
    cell.lab2.text = [NSString stringWithFormat:@"%@ - %@",model.model1.skuCode,model.model1.productCode];
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
    
    
    
    
    
    
    cell.lab3.text = [NSString stringWithFormat:@"%@m³",[NSString stringWithFormat:@"%.2f",[Manager returnTiJi:model.model1.packageLength width:model.model1.packageWidth height:model.model1.packageHeight]]];
    cell.lab4.text = [NSString stringWithFormat:@"%@kg",model.model1.packageWeight];
    
    
    cell.lab5.text = [NSString stringWithFormat:@"%@%.2f",model.model2.currmodel.field1,[model.unitPrice floatValue]];
    
    
    cell.lab5.font = [UIFont systemFontOfSize:18];

    if ([model.model1.currentQuantity isEqualToString:@"0"]) {
        [cell.btn setTitle:NSLocalizedString(@"f10", nil) forState:UIControlStateNormal];
        [cell.btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.cornerRadius = 15;
        cell.btn.layer.borderWidth = 1.0;
        cell.btn.layer.borderColor = [UIColor grayColor].CGColor;
    }else{
        [cell.btn setTitle:NSLocalizedString(@"f4", nil) forState:UIControlStateNormal];
        [cell.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.cornerRadius = 15;
        cell.btn.layer.borderWidth = 1.0;
        cell.btn.layer.borderColor = [UIColor redColor].CGColor;
        [cell.btn addTarget:self action:@selector(clickButtonAddCurt:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    cell.lab6.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"f9", nil),model.model1.currentQuantity];
    return cell;
}


- (void)clickButtonAddCurt:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"a21", nil) preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        XH02Cell *cell = (XH02Cell *)[sender.superview superview];
        NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
        XHo2Model *model = [self.dataArray objectAtIndex:indexpath.row];
        
        UITextField *TextField1 = alertController.textFields.firstObject;
        NSInteger inter = [TextField1.text integerValue];
        if (TextField1.text.length != 0  && inter >= 1 && model.model1.id != nil && model.model1.skuCode != nil) {
            [self lodAddCurt:TextField1.text ids:model.model1.id productcode:model.model1.skuCode];
        }else{
        }
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = @"1";
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)lodAddCurt:(NSString *)num ids:(NSString *)ids productcode:(NSString *)productcode {
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"loginId":[Manager redingwenjianming:@"loginId.text"],
            @"productCode":productcode,
            @"id":ids,
            @"quantity":num,
            };
//    NSLog(@"------%@",dic);
    [session POST:KURLNSString2(@"servlet", @"trade", @"tradeshoppingcart",@"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"------%@",dic);
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
            @"orderType":@"tradOrder",
            @"productCode":productCode,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    
    [session POST:KURLNSString3(@"servlet", @"trade", @"shopping", @"view",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//          NSLog(@"-----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            
            for (NSDictionary *dict in arr) {
                XHo2Model *model = [XHo2Model mj_objectWithKeyValues:dict];
                
                
                tradeGoodsModel *model1 = [tradeGoodsModel mj_objectWithKeyValues:model.tradeGoods];
                model.model1 = model1;
                
                
                tradeGoodsModel *model2 = [tradeGoodsModel mj_objectWithKeyValues:model.dealerInfo];
                model.model2 = model2;
                
                configCurrency_Model *model3 = [configCurrency_Model mj_objectWithKeyValues:model2.configCurrency];
                model2.currmodel = model3;
                
                
                [weakSelf.dataArray addObject:model];
            }
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
            @"orderType":@"tradOrder",
            @"productCode":productCode,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    
    [session POST:KURLNSString3(@"servlet", @"trade", @"shopping", @"view",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            
            for (NSDictionary *dict in arr) {
                XHo2Model *model = [XHo2Model mj_objectWithKeyValues:dict];
                
                
                tradeGoodsModel *model1 = [tradeGoodsModel mj_objectWithKeyValues:model.tradeGoods];
                model.model1 = model1;
                
                
                tradeGoodsModel *model2 = [tradeGoodsModel mj_objectWithKeyValues:model.dealerInfo];
                model.model2 = model2;
                
                configCurrency_Model *model3 = [configCurrency_Model mj_objectWithKeyValues:model2.configCurrency];
                model2.currmodel = model3;
                
                [weakSelf.dataArray addObject:model];
            }
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
