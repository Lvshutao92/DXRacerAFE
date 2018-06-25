//
//  CJWT_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2018/1/5.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "CJWT_ViewController.h"
#import "WDWT_Cell.h"
#import "LookPictureViewController.h"
#import "LookTextViewController.h"
#import "WDWT_Model.h"
#import "QuestionDetailsTableViewController.h"
@interface CJWT_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    NSString *field4;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableview;

@end

@implementation CJWT_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
   
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-0)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor=RGBACOLOR(230, 236, 240, 1);
    [self.tableview registerNib:[UINib nibWithNibName:@"WDWT_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setUpReflash];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    WDWT_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[WDWT_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=RGBACOLOR(230, 236, 240, 1);
    cell.lab1right.constant = 10;
    cell.lab4.hidden = YES;
    cell.img.hidden = YES;
    
    cell.line.hidden = YES;
    cell.btn1.hidden = YES;
    cell.btn2.hidden = YES;
    
    
    WDWT_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.questionContent;
    cell.lab2.text = [Manager TimeCuoToTime_yh:model.createTime];

    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        CGSize size = [model.english_name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        cell.lab3.text = model.english_name;
        if (size.width >= 200) {
            cell.lab3width.constant = 200;
        }else{
            cell.lab3width.constant = size.width+10;
        }
    }else{
        CGSize size = [model.chinese_name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        cell.lab3.text = model.chinese_name;
        if (size.width >= 200) {
            cell.lab3width.constant = 200;
        }else{
            cell.lab3width.constant = size.width+10;
        }
    }
    LRViewBorderRadius(cell.lab3, 0, 1, [UIColor colorWithWhite:.85 alpha:.6]);
    cell.lab3.textAlignment = NSTextAlignmentCenter;
    
    
    
    return cell;
}








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WDWT_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    QuestionDetailsTableViewController *details = [[QuestionDetailsTableViewController alloc]init];
    details.navigationItem.title = NSLocalizedString(@"g11", nil);
    details.idstr = model.id;
    details.img = model.field1;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]){
        details.fenlei = model.english_name;
    }else{
        details.fenlei = model.chinese_name;
    }
    
    details.miaoshu = model.questionContent;
    details.time = [Manager TimeCuoToTime_yh:model.createTime];
    [self.navigationController pushViewController:details animated:YES];
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
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"configId":@"",
            @"isopen":@"Y",
            };
    
    [session POST:KURLNSString2(@"servlet", @"ticket",@"ticketquestion",@"openList") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr =[dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                WDWT_Model *model = [WDWT_Model mj_objectWithKeyValues:dict];
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
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"configId":@"",
            @"isopen":@"Y",
            };
    [session POST:KURLNSString2(@"servlet", @"ticket",@"ticketquestion",@"openList") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr =[dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                WDWT_Model *model = [WDWT_Model mj_objectWithKeyValues:dict];
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
