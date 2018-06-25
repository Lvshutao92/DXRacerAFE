//
//  JXS_SH_3_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_SH_3_ViewController.h"
#import "PurchaseCarAnimationTool.h"
#import "JXSSH3Cell.h"



#import "JXS_SH3model.h"
#import "JXSCartmodel.h"
#import "JXSCurrencymodel.h"
#import "JXSGoodsExchangeRatemodel.h"
#import "JXSPartsmodel.h"


#import "JXS_YL__ViewController.h"

#import "JXS_SH_2_ViewController.h"


#define  TAG_BACKGROUNDVIEW 100
@interface JXS_SH_3_ViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    
    UIButton *button;
}



@end

@implementation JXS_SH_3_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    deleateArr = [NSMutableArray arrayWithCapacity:1];
    dataArray = [[NSMutableArray alloc]init];
    selectGoods = [[NSMutableArray alloc]init];
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"cart4", nil)];
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
    [self lodXL];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


//请求列表
- (void)lodXL{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof(self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"userId":[Manager redingwenjianming:@"loginId.text"],
            @"orderType":@"aftersale",
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
//     NSLog(@"cart+++%@",dic);
    [session POST:KURLNSString2(@"servlet", @"aftersale", @"aftersaleshoppingcart",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"cart+++%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        [dataArray removeAllObjects];
        for (NSDictionary *dict in arr) {
            JXS_SH3model *model = [JXS_SH3model mj_objectWithKeyValues:dict];
            
            JXSCartmodel *model1 = [JXSCartmodel mj_objectWithKeyValues:model.cart];
            model.model1 = model1;
            
            JXSCurrencymodel *model2 = [JXSCurrencymodel mj_objectWithKeyValues:model.currency];
            model.model2 = model2;
            
            JXSGoodsExchangeRatemodel *model3 = [JXSGoodsExchangeRatemodel mj_objectWithKeyValues:model.goodsExchangeRate];
            model.model3 = model3;
            
            JXSPartsmodel *model4 = [JXSPartsmodel mj_objectWithKeyValues:model.parts];
            model.model4 = model4;
            
            [dataArray addObject:model];
        }
        weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@(%ld)",NSLocalizedString(@"cart4", nil),dataArray.count];
        [myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


/**
 *  计算已选中商品金额
 */
-(void)countPrice
{
//    double totlePrice = 0.0;
//    for (JXS_SH3model *model in selectGoods) {
//        double price = [model.model2.unitPrice doubleValue];
//        
//        totlePrice += price*model.number;
//    }
    //    NSLog(@"%@",[Manager jinegeshi:[NSString stringWithFormat:@"%f",totlePrice]]);
//    priceLabel.text = [Manager jinegeshi:[NSString stringWithFormat:@"%f",totlePrice]];
    
}



-(void)selectAllBtnClick:(UIButton*)sender
{
    
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    sender.selected = !sender.selected;
    isSelect = sender.selected;
    if (isSelect) {
        for (JXS_SH3model *model in dataArray) {
            [selectGoods addObject:model];
            
        }
        [deleateArr addObjectsFromArray:selectGoods];
    }
    else
    {
        [selectGoods removeAllObjects];
        [deleateArr removeAllObjects];
    }
    [myTableView reloadData];
    [self countPrice];
}

//提交订单
-(void)goPayBtnClick
{
    if (selectGoods.count == 0) {
        txlab.hidden = NO;
        [self.view bringSubviewToFront:txlab];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            txlab.hidden = YES;
        });
    }else {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
        for (JXS_SH3model *model in selectGoods) {
            [arr addObject:model.id];
        }
        [self lodOrderYULan:arr];
    }
}

//订单预览
- (void)lodOrderYULan:(NSMutableArray *)ids {
    
    if (selectGoods.count != 0) {
        JXS_YL__ViewController *pl03 = [[JXS_YL__ViewController alloc]init];
        
        pl03.dataArray = selectGoods;
        
        
        [self.navigationController pushViewController:pl03 animated:YES];
    }
    
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
    
    if (isedit == NO) {
        
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = RGBACOLOR(229, 29, 43, 1.0);
        [btn setTitle:NSLocalizedString(@"cart3", nil) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = RGBACOLOR(250, 180, 30, 1.0);
        [button setTitle:NSLocalizedString(@"cart2", nil) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goShoppingBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView);
            make.right.equalTo(bgView);
            make.bottom.equalTo(bgView);
            make.width.equalTo(@100);
            
        }];
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(0);
            make.bottom.equalTo(bgView).offset(0);
            make.right.equalTo(btn.mas_left);
            make.width.equalTo(@100);
        }];
        
        
    }else {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
        [btn1 setTitle:@"删除" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(clickgodeleate) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn1];
        
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView);
            make.right.equalTo(bgView);
            make.bottom.equalTo(bgView);
            make.width.equalTo(@150);
        }];
    }
    
}

- (void)goShoppingBtnClick{
    JXS_SH_2_ViewController *pl02 = [[JXS_SH_2_ViewController alloc]init];
    pl02.navigationItem.title = NSLocalizedString(@"sh-2", nil);
    [self.navigationController pushViewController:pl02 animated:YES];
}



- (void)clickgodeleate {
    
    [dataArray removeObjectsInArray:deleateArr];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (JXS_SH3model *model in deleateArr) {
        [arr addObject:model.id];
    }
    [self lodDelegateSelectsGoods:arr];
    
    [myTableView reloadData];
    if (dataArray.count == 0) {
        [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
        isedit = NO;
        [self setupBottomView];
    }
    self.navigationItem.title = [NSString stringWithFormat:@"购物车(%ld)",dataArray.count];
}





#pragma mark - tableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JXSSH3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoopingcell"];
    if (!cell) {
        cell = [[JXSSH3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoopingcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
        
        [self countPrice];
    };
    __block JXSSH3Cell *weakCell = cell;
    cell.numAddBlock =^(){
        
        NSInteger count = [weakCell.numberLabel.text integerValue];
        count++;
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        JXS_SH3model *model = [dataArray objectAtIndex:indexPath.row];
        weakCell.numberLabel.text = numStr;
        model.number = count;
        [self lodChangeGoodsNumber:[NSString stringWithFormat:@"%ld",model.number] ids:model.id indexpath:indexPath];
        
        [dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([selectGoods containsObject:model]) {
            [selectGoods removeObject:model];
            [selectGoods addObject:model];
            [self countPrice];
        }
    };
    
    cell.numCutBlock =^(){
        
        NSInteger count = [weakCell.numberLabel.text integerValue];
        count--;
        if(count <= 0){
            return ;
        }
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        JXS_SH3model *model = [dataArray objectAtIndex:indexPath.row];
        weakCell.numberLabel.text = numStr;
        model.number = count;
        [self lodChangeGoodsNumber:[NSString stringWithFormat:@"%ld",model.number] ids:model.id indexpath:indexPath];
        
        [dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([selectGoods containsObject:model]) {
            [selectGoods removeObject:model];
            [selectGoods addObject:model];
            [self countPrice];
        }
    };
    
    [cell reloadDataWith:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}
//改变商品数量
- (void)lodChangeGoodsNumber:(NSString *)amount ids:(NSString *)ids indexpath:(NSIndexPath *)indexpath{
    
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof(self) weakSelf = self;
    dic = @{@"quantity":amount,
            @"id":ids,
            @"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"loginId":[Manager redingwenjianming:@"loginId.text"],
            };
    //    NSLog(@"---%@",dic);
    [session POST:KURLNSString2(@"servlet",@"aftersale", @"aftersaleshoppingcart",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"+++%@",dic);
//                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
//        
//                [dataArray removeAllObjects];
//                for (NSDictionary *dict in arr) {
//                    JXS_SH3model *model = [JXS_SH3model mj_objectWithKeyValues:dict];
//        
//                    JXSCartmodel *model1 = [JXSCartmodel mj_objectWithKeyValues:model.cart];
//                    model.model1 = model1;
//                    
//                    JXSCurrencymodel *model2 = [JXSCurrencymodel mj_objectWithKeyValues:model.currency];
//                    model.model2 = model2;
//                    
//                    JXSGoodsExchangeRatemodel *model3 = [JXSGoodsExchangeRatemodel mj_objectWithKeyValues:model.goodsExchangeRate];
//                    model.model3 = model3;
//                    
//                    JXSPartsmodel *model4 = [JXSPartsmodel mj_objectWithKeyValues:model.parts];
//                    model.model4 = model4;
//        
//                    [dataArray addObject:model];
//                }
        
        [weakSelf lodXL];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    
    
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *xiugai = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"cart6", nil) handler:^(UITableViewRowAction * _Nonnull kaipiao, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"x20", nil) preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
            JXS_SH3model *model = [dataArray objectAtIndex:indexPath.row];
            //            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
            //            [arr addObject:model.id];
            [self lodDelegateSelectsGoods:model.id];
            
            [dataArray removeObjectAtIndex:indexPath.row];
            //删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //延迟0.5s刷新一下,否则数据会乱
            //            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            self.navigationItem.title = [NSString stringWithFormat:@"%@(%ld)",NSLocalizedString(@"cart4", nil),dataArray.count];
            myTableView.editing = NO;
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            myTableView.editing = NO;
        }];
        
        
        [self countPrice];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }];
    xiugai.backgroundColor = [UIColor redColor];
    return @[xiugai];
}
//删除购物车商品
- (void)lodDelegateSelectsGoods:(NSString *)idstr{
    
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"loginId":[Manager redingwenjianming:@"loginId.text"],
            @"id":idstr,
            };
    
    [session POST:KURLNSString2(@"servlet", @"aftersale", @"aftersaleshoppingcart",@"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"delete+++%@",dic);
        [myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}



@end
