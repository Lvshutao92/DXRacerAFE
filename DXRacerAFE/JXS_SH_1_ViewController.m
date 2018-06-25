//
//  JXS_SH_1_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_SH_1_ViewController.h"
#import "JXS_SH_1_cell.h"

#import "PL_____model.h"
#import "PL___2__model.h"
#import "PL__1__model.h"
#import "configCurrency_Model.h"
#import "PurchaseCarAnimationTool.h"
#define  TAG_BACKGROUNDVIEW 350
#import "YLTableViewController.h"
@interface JXS_SH_1_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CAGradientLayer *_gradientLayer;
    UILabel *txlab;//没有选择商品点击结算提示label
    UIView *bgView;//底部视图
    //    UIButton *btn;//编辑按钮
    UITableView *myTableView;
    //全选按钮
    UIButton *selectAll;
    //展示数据源数组
    NSMutableArray *dataArray;
    //是否全选
    BOOL isSelect;
    //已选的商品集合
    NSMutableArray *selectGoods;
    UILabel *priceLabel;
    
    BOOL isedit;
    UIButton *editbtn;
    
    NSMutableArray *deleateArr;
    
    NSInteger totolNum;
    UIButton *btn;
    
    CGFloat money;
    
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    NSString *stu1;
}
@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UIScrollView *BgView;

@end

@implementation JXS_SH_1_ViewController








- (void)clicksearch{
    //    PL_search_two_ViewController *search = [[PL_search_two_ViewController alloc]init];
    //    search.navigationItem.title = NSLocalizedString(@"x7", nil);
    //    search.biaoshi = @"SH_jxs";
    //    [self.navigationController pushViewController:search animated:YES];
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
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
    
    
    [self lodXL];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = @"";
    text2.text = @"";
    stu1 = @"";
}




- (void)sure{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (stu1.length == 0) {
        stu1 = @"";
    }
    [self lodXL];
    window.hidden = YES;
}

- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
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
    
    
    [self lodXL];
    window.hidden = YES;
}





















- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    
    
    
    deleateArr = [NSMutableArray arrayWithCapacity:1];
    dataArray = [[NSMutableArray alloc]init];
    selectGoods = [[NSMutableArray alloc]init];
    editbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editbtn.frame = CGRectMake(0, 0, 50, 30) ;
    [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editbtn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:editbtn];
    //    self.navigationItem.rightBarButtonItem = bar;
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 100;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = RGBCOLOR(245, 246, 248);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    //每次进入购物车的时候把选择的置空
    [deleateArr removeAllObjects];
    [selectGoods removeAllObjects];
    isSelect = NO;
    selectAll.selected = NO;
    priceLabel.text = [NSString stringWithFormat:@"￥0.00"];
    
    [self.view addSubview:myTableView];
    [self setupBottomView];
    
     [self setupButton];
}
- (void)clickEdit {
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    //    [self networkRequest];
    selectAll.selected = NO;
    priceLabel.text = [NSString stringWithFormat:@"￥0.00"];
    [myTableView reloadData];
    
    if (isedit == NO) {
        [deleateArr removeAllObjects];
        [editbtn setTitle:@"完成" forState:UIControlStateNormal];
    }else {
        [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    isedit = !isedit;;
    [self setupBottomView];
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XH_PL_details_TableViewController *details = [[XH_PL_details_TableViewController alloc]init];
    PL_____model *model = [dataArray objectAtIndex:indexPath.row];
    details.idstr = model.id;
    details.fuhao = model.model3.field1;
    [self.navigationController pushViewController:details animated:YES];
}

//请求列表
- (void)lodXL{
    AFHTTPSessionManager *session = [Manager returnsession];
    //__weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"orderNo":text1.text,
            @"searchFcno":text2.text,
            @"queryStatus":stu1,
            };
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer", @"batch",@"af/list/get") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        [dataArray removeAllObjects];
//        NSLog(@"%@",dic);
        NSMutableArray *arr = [[[dic objectForKey:@"rows"] objectForKey:@"result"] objectForKey:@"rows"];
        
        for (NSDictionary *dict in arr) {
            PL_____model *model = [PL_____model mj_objectWithKeyValues:dict];
            
            PL__1__model *model1 = [PL__1__model mj_objectWithKeyValues:model.dealerInfo];
            model.model1 = model1;
            
            PL___2__model *model2 = [PL___2__model mj_objectWithKeyValues:model.configContainer];
            model.model2 = model2;
            
            configCurrency_Model *model3 = [configCurrency_Model mj_objectWithKeyValues:model.configCurrency];
            model.model3 = model3;
            
            
            [dataArray addObject:model];
        }
        
        [myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




-(void)selectAllBtnClick:(UIButton*)sender
{
    
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    sender.selected = !sender.selected;
    isSelect = sender.selected;
    if (isSelect) {
        for (PL_____model *model in dataArray) {
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    [myTableView reloadData];
}

//合并付款
-(void)goPayBtnClick
{
    if (selectGoods.count == 0) {
        txlab.hidden = NO;
        [self.view bringSubviewToFront:txlab];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            txlab.hidden = YES;
        });
    }else {
        NSString  *ids = @"";
//        NSString  *orderids = @"";
        for (PL_____model *model in selectGoods) {
            ids      = [ids stringByAppendingString:[NSString stringWithFormat:@",%@",model.id]];
//            orderids = [orderids stringByAppendingString:[NSString stringWithFormat:@",%@",model.orderId]];
        }
        [self lodOrderYULan:[ids substringFromIndex:1] orderids:nil];
    }
}

//合并付款
- (void)lodOrderYULan:(NSString *)ids orderids:(NSString *)orderids{
    YLTableViewController *yl = [[YLTableViewController alloc]init];
    yl.navigationItem.title = NSLocalizedString(@"cart3", nil);
    yl.arr = ids;
    [self.navigationController pushViewController:yl animated:YES];
}







#pragma mark - 设置底部视图

-(void)setupBottomView
{
    //底部视图的 背景
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = kUIColorFromRGB(0xD5D5D5);
    [bgView addSubview:line];
    //全选按钮
    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:13];
    [selectAll setTitle:NSLocalizedString(@"cart5", nil) forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"cart_unSelect_btn1"] forState:UIControlStateNormal];
    
    
    UIImage *theImage = [UIImage imageNamed:@"cart_selected_btn1"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [selectAll setImage:theImage forState:UIControlStateSelected];
    [selectAll setTintColor:[UIColor redColor]];
    
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectAll];
#pragma mark -- 底部视图添加约束
    //全选按钮
    [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(10);
        make.top.equalTo(@10);
        make.bottom.equalTo(bgView).offset(-10);
        make.width.equalTo(@60);
        
    }];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = RGBACOLOR(229, 29, 43, 1.0);
    [btn setTitle:NSLocalizedString(@"cart3", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.right.equalTo(bgView);
        make.bottom.equalTo(bgView);
        make.width.equalTo(@150);
        
    }];
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

#pragma mark - tableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCell = @"cell";
    JXS_SH_1_cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[JXS_SH_1_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isSelected = isSelect;
    
    //是否被选中
    if ([selectGoods containsObject:[dataArray objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    
    //选择回调
    cell.cartBlock = ^(BOOL isSelec){
        
        if (isSelec) {
            [selectGoods addObject:[dataArray objectAtIndex:indexPath.row]];
            [deleateArr addObject:[dataArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [selectGoods removeObject:[dataArray objectAtIndex:indexPath.row]];
            [deleateArr removeObject:[dataArray objectAtIndex:indexPath.row]];
        }
        
        if (selectGoods.count == dataArray.count) {
            selectAll.selected = YES;
        }
        else
        {
            selectAll.selected = NO;
        }
        
    };
    
    [cell reloadDataWith:[dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
