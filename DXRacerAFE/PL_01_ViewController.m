//
//  PL_01_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PL_01_ViewController.h"
#import "PL_01_Cell.h"
#import "PL_01_Model.h"
#import "PL_01_GoodsModel.h"
#import "PL_01_Deleargoods_Model.h"
#import "PL_search_one_ViewController.h"
#import "PiLiang_Chanpinliulan_Cell.h"
@interface PL_01_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    CGFloat height;
    
    CGFloat height1;
    CGFloat height2;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    NSString *areaChineseName;
    
    NSString *str1;
    NSString *str2;
}
@property (nonatomic, strong)UIScrollView *BgView;

@property (nonatomic, strong)UILabel *toplab;

@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation PL_01_ViewController
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)clicksearch{
//    PL_search_one_ViewController *search = [[PL_search_one_ViewController alloc]init];
//    search.navigationItem.title = NSLocalizedString(@"x7", nil);
//    [self.navigationController pushViewController:search animated:YES];
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = @"";
    areaChineseName = @"";
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
    lab1.text = @"MODEL";
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"MODEL";
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    lab2.text = @"ITEMNO";
    [self.BgView addSubview:lab2];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10,145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"ITEMNO";
    text2.text = @"";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"FCNO";
    [self.BgView addSubview:lab3];
    
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10,240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"FCNO";
    text3.text = @"";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text3];
    
    
    
    
    
    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    self.toplab.text = NSLocalizedString(@"g8", nil);
    [self.BgView addSubview:self.toplab];
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 335;//用来控制button距离父视图的高
    for (int i = 0; i < self.arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(SCREEN_WIDTH-20, 25);
        CGFloat length = [self.arr[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:self.arr[i] forState:UIControlStateNormal];
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
    
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, h+50, SCREEN_WIDTH-20, 40)];
    lab4.text = NSLocalizedString(@"g9", nil);
    [self.BgView addSubview:lab4];
    
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10,h+95, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.text = @"";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text4];
//
    
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-250);
    _BgView.contentSize = CGSizeMake(0, h+200);
    [window addSubview:_BgView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-250, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:NSLocalizedString(@"sure", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-249, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:NSLocalizedString(@"n", nil) forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    
    [self setUpReflash];
}





- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    
    areaChineseName = btn.titleLabel.text;
    if (areaChineseName == nil || areaChineseName.length == 0) {
        areaChineseName = @"";
    }
    
    
    [self setUpReflash];
    window.hidden = YES;
}







- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
        text3.text = @"";
        text4.text = @"";
        areaChineseName = @"";
}




- (void)sure{
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (areaChineseName == nil || areaChineseName.length == 0) {
        areaChineseName = @"";
    }
    
    
    [self setUpReflash];
    window.hidden = YES;
}












- (void)lodfenzu{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof(self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString1(@"servlet", @"batch", @"shopping/apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"---------%@",dic);
        NSMutableArray *arr = [dic objectForKey:@"goodsAreaList"];
        [weakSelf.arr removeAllObjects];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            
            str1 = @"fcnoNameEnglish";
            str2 = @"areaEnglishName";
            
            for (NSDictionary *dic in arr) {
                if (![dic isEqual:[NSNull null]]) {
                    [weakSelf.arr addObject:[dic objectForKey:@"area_english_name"]];
                }
            }
        }else{
            str1 = @"fcnoNameChinese";
            str2 = @"areaChineseName";
            for (NSDictionary *dic in arr) {
                if (![dic isEqual:[NSNull null]]) {
                    [weakSelf.arr addObject:[dic objectForKey:@"area_chinese_name"]];
                }
            }
        }
        [weakSelf setupButton];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    areaChineseName = @"";
    
    [self lodfenzu];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    CGFloat heights;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        heights = 88;
    }else{
        heights = 64;
    }
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"PiLiang_Chanpinliulan_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
    
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    PL_search_one_ViewController *search = [[PL_search_one_ViewController alloc]init];
    search.navigationItem.title = NSLocalizedString(@"x7", nil);
    
    //取出根视图控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //取出当前选中的导航控制器
    UINavigationController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:search animated:YES];
    return NO;
}








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
    PL_01_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab5.hidden = YES;
    
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
    
    if (model.goodsModel.fcnoNameEnglish == nil || [model.goodsModel.fcnoNameEnglish isEqual:[NSNull null]] || model.goodsModel.fcnoNameEnglish.length == 0) {
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
    
    if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"N"]  || model.dealerGoodsModel.dealerUseStatus == nil) {
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
    }else  if ([model.dealerGoodsModel.dealerUseStatus isEqualToString:@"Y"]){
        [cell.btn setTitle:NSLocalizedString(@"f3", nil) forState:UIControlStateNormal];
        [cell.btn setTitleColor:RGBACOLOR(56, 56, 56, 1) forState:UIControlStateNormal];
        
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.cornerRadius = 15;
        cell.btn.layer.borderWidth = 1.0;
        cell.btn.layer.borderColor = RGBACOLOR(56, 56, 56, 1).CGColor;
    }
    
    [cell.btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)clickButton:(UIButton *)sender{
    PL_01_Cell *cell = (PL_01_Cell *)[sender.superview superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PL_01_Model *model = [self.dataArray objectAtIndex:indexpath.row];
//    NSLog(@"======%@",model.goodsModel.id);
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
    
    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"apply",@"apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"a23", nil) preferredStyle:1];
//                UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
//                [alert addAction:action];
                [weakSelf presentViewController:alert animated:YES completion:nil];
      
        
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
    
    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"apply",@"cancel") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [Manager returndictiondata:responseObject];

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"a24", nil) preferredStyle:1];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf setUpReflash];
        }];
        [alert addAction:cancel];
//        [alert addAction:action];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
       
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
            @"orderType":@"batchOrder",
            
            @"model":text1.text,
            @"itemno":text2.text,
            @"fcno":text3.text,
            
            str1:text4.text,
            str2:areaChineseName,
            
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            };

    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"apply",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"%@",dic);
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
            @"orderType":@"batchOrder",
            
            @"model":text1.text,
            @"itemno":text2.text,
            @"fcno":text3.text,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            str1:text4.text,
            str2:areaChineseName,
            };
    
    [session POST:KURLNSString3(@"servlet", @"batch", @"shopping", @"apply",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
