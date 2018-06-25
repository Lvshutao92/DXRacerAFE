//
//  JXS_SH_2_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_SH_2_ViewController.h"
#import "YCSH_Cell.h"
#import "YCSH_model.h"
#import "SH_search_one_ViewController.h"
#import "JXSCurrencymodel.h"
#import "JXSGoodsExchangeRatemodel.h"
#import "ShouHou_Youchang_Cell.h"
@interface JXS_SH_2_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    CGFloat height;
    
    
    CGFloat height1;
    CGFloat height2;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    
    NSString *str1;
     NSString *statu;
}
@property (nonatomic, strong)UIScrollView *BgView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong)UISearchBar *searchbar;


@property (nonatomic, strong)UILabel *toplab;
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation JXS_SH_2_ViewController
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)clicksearch{
//    SH_search_one_ViewController *search = [[SH_search_one_ViewController alloc]init];
//    search.navigationItem.title = NSLocalizedString(@"x7", nil);
//    [self.navigationController pushViewController:search animated:YES];
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    text2.text = nil;
    statu = nil;
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
    lab1.text = NSLocalizedString(@"d2", nil);
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = NSLocalizedString(@"d2", nil);
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    lab2.text = NSLocalizedString(@"d3", nil);
    [self.BgView addSubview:lab2];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10,145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = NSLocalizedString(@"d3", nil);
    text2.text = @"";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text2];
    
    
    
    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    self.toplab.text = NSLocalizedString(@"d4", nil);
    [self.BgView addSubview:self.toplab];
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 240;//用来控制button距离父视图的高
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
        CGSize size = CGSizeMake(MAXFLOAT, 25);
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
    
    
    
    
    
    
    
    
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-300);
    _BgView.contentSize = CGSizeMake(0, h+100);
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
    
    
    [self loddeList];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    text2.text = nil;
    statu = nil;
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
    
    
    statu = btn.titleLabel.text;
    if (statu == nil || statu.length == 0) {
        statu = @"";
    }
    
    
    [self loddeList];
    window.hidden = YES;
}



- (void)sure{
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    
    statu = @"";
    
    
    [self loddeList];
    window.hidden = YES;
}







- (void)lodfenzu{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof(self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString1(@"servlet", @"aftersale", @"shopping/view") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"---------%@",dic);
        NSMutableArray *arr = [dic objectForKey:@"classifyCn"];
        NSMutableArray *arr1 = [dic objectForKey:@"classifyEn"];
        
        [weakSelf.arr removeAllObjects];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
            str1 = @"classifyEn";
            weakSelf.arr = arr1;
        }else{
            str1 = @"classifyCn";
            weakSelf.arr = arr;
        }
        [weakSelf setupButton];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}













- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    statu = @"";
    [self lodfenzu];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"ShouHou_Youchang_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    self.tableview.tableHeaderView = view;
//    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    _searchbar.delegate = self;
//    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
//    _searchbar.placeholder = @"请点击进行检索";
//    [view addSubview:_searchbar];
    
   
    
    
    
    
}
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    SH_search_one_ViewController *search = [[SH_search_one_ViewController alloc]init];
//    search.navigationItem.title = @"检索";
//    [self.navigationController pushViewController:search animated:YES];
//    return NO;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165+height2+height1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    ShouHou_Youchang_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[ShouHou_Youchang_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    YCSH_model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab3.layer.masksToBounds = YES;
    cell.lab3.layer.cornerRadius  = 3;
    cell.lab4.layer.masksToBounds = YES;
    cell.lab4.layer.cornerRadius  = 3;
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)]placeholderImage:[UIImage imageNamed:@"bgview"]];
    if (model.english_name == nil || [model.english_name isEqual:[NSNull null]]  || model.english_name.length == 0) {
        model.english_name = @"-";
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.english_name];
        cell.lab2.text = [NSString stringWithFormat:@"%@  %@",model.part_no,model.classify_en];
    }else {
        cell.lab1.text = [NSString stringWithFormat:@"%@",model.chinese_name];
        cell.lab2.text = [NSString stringWithFormat:@"%@  %@",model.part_no,model.classify_cn];
    }
    
    
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height1 = size.height;
    
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
    
    
    
    
    
    
    cell.lab3.text = [NSString stringWithFormat:@"%@*%@*%@cm",model.package_length,model.package_width,model.package_height];
    cell.lab4.text = [NSString stringWithFormat:@"%@kg",model.weight];
    cell.lab5.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"c1", nil),model.inventory];
    
    if ([model.model1.id isEqualToString:model.model2.fromCurrency]) {
        cell.lab6.text = [NSString stringWithFormat:@"%@%.2f",model.model1.field1,[model.aftersale_price floatValue]];
        ;
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"%@%.2f",model.model1.field1,[model.aftersale_price floatValue]*[model.model2.rate floatValue]];
        ;
    }
    

    
    
    [cell.btn setTitle:NSLocalizedString(@"f4", nil) forState:UIControlStateNormal];
    [cell.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    cell.btn.layer.masksToBounds = YES;
    cell.btn.layer.cornerRadius  = 15;
    cell.btn.layer.borderWidth   = 1.0;
    cell.btn.layer.borderColor   = [UIColor redColor].CGColor;
    [cell.btn addTarget:self action:@selector(clickButtonAddCurt:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void)clickButtonAddCurt:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"a21", nil) preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ShouHou_Youchang_Cell *cell = (ShouHou_Youchang_Cell *)[sender.superview superview];
        NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
        YCSH_model *model = [self.dataArray objectAtIndex:indexpath.row];
        
        UITextField *TextField1 = alertController.textFields.firstObject;
        
        if (TextField1.text.length != 0 && model.part_no.length != 0) {
            [self lodAddCurt:TextField1.text fcno:model.part_no];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"x23", nil) preferredStyle:1];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = @"1";
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)lodAddCurt:(NSString *)num fcno:(NSString *)fcno {
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"loginId":[Manager redingwenjianming:@"loginId.text"],
            @"partsCode":fcno,
            @"quantity":num,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"aftersale", @"aftersaleshoppingcart", @"add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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










- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"partNo":text1.text,
            @"name":text2.text,
            str1:statu,
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"aftersale",@"shopping/view",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
//        NSLog(@"%@",dic);
//        if ([dic objectForKey:@"total"] != nil || [[dic objectForKey:@"total"] isEqual:[NSNull null]]) {
//            totalnum = [[dic objectForKey:@"total"] integerValue];
//        }
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            YCSH_model *model = [YCSH_model mj_objectWithKeyValues:dict];
            
            
            
            JXSCurrencymodel *model2 = [JXSCurrencymodel mj_objectWithKeyValues:model.currency];
            model.model1 = model2;
            
            JXSGoodsExchangeRatemodel *model3 = [JXSGoodsExchangeRatemodel mj_objectWithKeyValues:model.goodsExchangeRate];
            model.model2 = model3;
            
            
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}














@end
