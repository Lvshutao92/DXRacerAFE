//
//  XH_04_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XH_04_ViewController.h"
#import "XH04Cell.h"



#import "OrderListModel.h"

#import "configContainerModel.h"
#import "configCurrency_Model.h"
#import "PL_01_Delearinfo_Model.h"
#import "systemUserModel.h"
#import "PL_search_two_ViewController.h"
#import "Order_details_ViewController.h"

#import "Piliang_orderlist_Cell.h"
@interface XH_04_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    NSString *stu1;
}
@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UIScrollView *BgView;




@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation XH_04_ViewController

- (void)clicksearch{
//    PL_search_two_ViewController *search = [[PL_search_two_ViewController alloc]init];
//    search.navigationItem.title = NSLocalizedString(@"x7", nil);
//    search.biaoshi = @"biaoshi";
//    [self.navigationController pushViewController:search animated:YES];
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    text2.text = nil;
    stu1 = nil;
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
    lab1.text = NSLocalizedString(@"a1", nil);;
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = NSLocalizedString(@"a1", nil);;
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    lab2.text = @"FCNO";
    [self.BgView addSubview:lab2];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10,145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"FCNO";
    text2.text = @"";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text2];
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    self.toplab.text = NSLocalizedString(@"a3", nil);
    [self.BgView addSubview:self.toplab];
    
    NSArray *arr = @[NSLocalizedString(@"pl2", nil),NSLocalizedString(@"pl3", nil),NSLocalizedString(@"pl4", nil),NSLocalizedString(@"pl5", nil),NSLocalizedString(@"pl6", nil),NSLocalizedString(@"pl7", nil)];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 240;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 20 , 40);
        //当button的位置超出屏幕边缘时换行 只是button所在父视图的宽度
        if(10 + w + length + 20 > self.view.frame.size.width){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 20, 40);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [_BgView addSubview:button];
        
    }
    
    
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-300);
    _BgView.contentSize = CGSizeMake(0, h+50);
    [window addSubview:_BgView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-300, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:NSLocalizedString(@"sure", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-299, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:NSLocalizedString(@"n", nil) forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    
    [self setUpReflash];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = @"";
    text2.text = @"";
    stu1 = @"";
}




- (void)sure{
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (stu1.length == 0) {
        stu1 = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}

- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"pl2", nil)]) {
        stu1 = @"confirm";
    }else if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"pl3", nil)]){
        stu1 = @"confirmed";
    }else if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"pl4", nil)]){
        stu1 = @"production";
    }else if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"pl5", nil)]){
        stu1 = @"undelivery";
    }else if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"pl6", nil)]){
        stu1 = @"delivery";
    }else if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"pl7", nil)]){
        stu1 = @"cancel";
    }
    
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    
    
    [self setUpReflash];
    window.hidden = YES;
}















- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"Piliang_orderlist_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    self.tableview.tableHeaderView = view;
//    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    _searchbar.delegate = self;
//    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
//    _searchbar.placeholder = @"请点击进行检索";
//    [view addSubview:_searchbar];
  

    [self setupButton];
    
}
//
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    PL_search_two_ViewController *search = [[PL_search_two_ViewController alloc]init];
//    search.navigationItem.title = @"检索";
//    search.biaoshi = @"biaoshi";
//    [self.navigationController pushViewController:search animated:YES];
//    return NO;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        return 230;
    }
    else {
        return 210;
    }
    return 230;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    Order_details_ViewController *details = [[Order_details_ViewController alloc]init];
    details.orderid = model.id;
    details.fuhao = model.model2.field1;
    [self.navigationController pushViewController:details animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    Piliang_orderlist_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Piliang_orderlist_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OrderListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
 
    
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.orderNo];
    
    
    cell.btn.layer.borderWidth = 1;
    cell.btn.layer.borderColor = [UIColor blackColor].CGColor;
    cell.btn.layer.masksToBounds = YES;
    cell.btn.layer.cornerRadius = 5;
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl2", nil)];
        cell.lab2.textColor = RGBACOLOR(227, 154, 70, 1);
        cell.img.image = [UIImage imageNamed:@"dqr"];
    }else if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl3", nil)];
        cell.lab2.textColor = RGBACOLOR(55, 154, 254, 1);
        cell.img.image = [UIImage imageNamed:@"yqr"];
    }else if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl4", nil)];
        cell.lab2.textColor = RGBACOLOR(0, 157, 147, 1.0);
        cell.img.image = [UIImage imageNamed:@"scz"];
    }else if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl5", nil)];
        cell.lab2.textColor = RGBACOLOR(162, 133, 233, 1);
        cell.img.image = [UIImage imageNamed:@"dfh"];
    }else if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl6", nil)];
        cell.lab2.textColor = RGBACOLOR(249, 76, 82, 1);
        cell.img.image = [UIImage imageNamed:@"yfh"];
    }else if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab2.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl7", nil)];
        cell.lab2.textColor = RGBACOLOR(113, 113, 113, 1);
        cell.img.image = [UIImage imageNamed:@"yqx"];
    }
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    if (model.model1.containerCode == nil) {
        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a5", nil),@"-"];
    }else{
        cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a5", nil),model.model1.containerCode];
    }
    
    
    
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@: %@%.2f",NSLocalizedString(@"a2", nil),model.model2.field1,[model.productTotalFee floatValue]]];
    // 需要改变的区间
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        NSRange range1 = NSMakeRange(0, 10);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:range1];
        // 为label添加Attributed
        [cell.lab4 setAttributedText:noteStr];
    }else{
        NSRange range1 = NSMakeRange(0, 5);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:range1];
        // 为label添加Attributed
        [cell.lab4 setAttributedText:noteStr];
    }
    
    
//    cell.lab5.text = [NSString stringWithFormat:@"%@",[Manager TimeCuoToTime:model.createTime]];
    
    
    [cell.btn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.btn.hidden = NO;
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.cornerRadius = 5;
        [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.line.hidden = NO;
    }
    if (![model.orderStatus isEqualToString:@"confirm"]){
        cell.btn.hidden = YES;
        cell.line.hidden = YES;
    }
    
    
    if (model.customOrderNo ==nil) {
        cell.lab5.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"g13", nil),@""];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"g13", nil),model.customOrderNo];
    }
    if (model.field7 ==nil) {
        cell.lab6.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"g14", nil),@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"g14", nil),model.field7];
    }
    
    
    
    
    
    
    
    
    cell.lab7.hidden = YES;
    return cell;
}
- (void)clickbtn:(UIButton *)sender{
    XH04Cell *cell = (XH04Cell *)[[[sender superview] superview]superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    OrderListModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    [self lodcancleOrder:model.id];
}

- (void)lodcancleOrder:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"loginId":[Manager redingwenjianming:@"loginId.text"],
            @"id":str,
            };
    
    [session POST:KURLNSString2(@"servlet", @"order", @"dealer",@"cancel") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"]isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"a24", nil) preferredStyle:1];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            
        }
        
        [weakSelf.tableview reloadData];
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
            
            @"orderNo":text1.text,
            @"searchFcno":text2.text,
            @"queryStatus":stu1,
            @"sorttype":@"desc",
            @"sort":@"createTime",
            };
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer", @"trade",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"-----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            OrderListModel *model = [OrderListModel mj_objectWithKeyValues:dict];
            
            configContainerModel *model1 = [configContainerModel mj_objectWithKeyValues:model.configContainer];
            model.model1 = model1;
            
            configCurrency_Model *model2 = [configCurrency_Model mj_objectWithKeyValues:model.configCurrency];
            model.model2 = model2;
            
            PL_01_Delearinfo_Model *model3 = [PL_01_Delearinfo_Model mj_objectWithKeyValues:model.dealerInfo];
            model.model3 = model3;
            
            systemUserModel *model4 = [systemUserModel mj_objectWithKeyValues:model.systemUser];
            model.model4 = model4;
            
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
            @"searchFcno":text2.text,
            @"orderNo":text1.text,
            @"queryStatus":stu1,
            @"sorttype":@"desc",
            @"sort":@"createTime",
            };
    
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer", @"trade",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            OrderListModel *model = [OrderListModel mj_objectWithKeyValues:dict];
            
            configContainerModel *model1 = [configContainerModel mj_objectWithKeyValues:model.configContainer];
            model.model1 = model1;
            
            configCurrency_Model *model2 = [configCurrency_Model mj_objectWithKeyValues:model.configCurrency];
            model.model2 = model2;
            
            PL_01_Delearinfo_Model *model3 = [PL_01_Delearinfo_Model mj_objectWithKeyValues:model.dealerInfo];
            model.model3 = model3;
            
            systemUserModel *model4 = [systemUserModel mj_objectWithKeyValues:model.systemUser];
            model.model4 = model4;
            
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
