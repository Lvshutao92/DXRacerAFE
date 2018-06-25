//
//  MainPageViewController.m
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"
#define vBackBarButtonItemName  @"backArrow.png"    //导航条返回默认图片名
#import "HomepageModel.h"
#import "WebTitleCell.h"
#import "WebViewController.h"
@interface MainPageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSString *biaoji;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)NSMutableArray *ydArray;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"vc3Title", nil);
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);

    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

//    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"WebTitleCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    self.tableview.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    line.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    self.tableview.tableHeaderView = line;
    
    biaoji = [Manager redingwenjianming:@"loginId.text"];
    
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",biaoji]];
    self.ydArray = (NSMutableArray *)[NSArray arrayWithContentsOfFile:documentPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60+height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WebTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HomepageModel *model  = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    cell.img1.contentMode = UIViewContentModeScaleAspectFit;
    cell.img2.contentMode = UIViewContentModeScaleAspectFit;
    
    
    cell.lab1.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"f16", nil),model.annTheme];
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-110, MAXFLOAT)];
    height = size.height;
    cell.lab1height.constant = height;
    cell.lab2.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"f17", nil),[Manager TimeCuoToTimes:model.createTime]];
    cell.img1top.constant = (height+50)/2-15;
    
    
    if ([self.ydArray containsObject:model.id] == YES) {
        cell.img2.hidden = YES;
        cell.img1.image = [UIImage imageNamed:@"yd"];
        cell.lab1.textColor = [UIColor grayColor];
    }else{
        cell.img2.hidden = NO;
        cell.img1.image = [UIImage imageNamed:@"gonggao"];
        cell.lab1.textColor = RGBACOLOR(16, 162, 158, 1);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *web = [[WebViewController alloc]init];
    web.navigationItem.title = NSLocalizedString(@"vc3Title", nil);
    HomepageModel *model  = [self.dataArray objectAtIndex:indexPath.row];
    web.webStr = model.annContent;
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",biaoji]];
    self.ydArray = (NSMutableArray *)[NSArray arrayWithContentsOfFile:documentPath];
    if (![self.ydArray containsObject:model.id]) {
        [self.ydArray addObject:model.id];
    }
    NSArray *array1 =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents1 = [array1 lastObject];
    NSString *documentPath1 = [documents1 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",biaoji]];
    [self.ydArray writeToFile:documentPath1 atomically:YES];
    
    [self.navigationController pushViewController:web animated:YES];
}

- (void)lodHomepage{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = NSLocalizedString(@"jh", @"HUD loading title");
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerType":[Manager redingwenjianming:@"dealerType.text"],
                };
        [session POST:KURLNSString(@"user", @"index") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //NSLog(@"%@",dic);
            [weakSelf.dataArray removeAllObjects];
            
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"annList"];
            for (NSDictionary *dict in arr) {
                HomepageModel *model = [HomepageModel mj_objectWithKeyValues:dict];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableview reloadData];
//            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [hud hideAnimated:YES];
        }];
}








- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


- (NSMutableArray *)ydArray{
    if (_ydArray ==nil) {
        self.ydArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _ydArray;
}


- (void)openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self lodHomepage];
    
    self.tabBarController.tabBar.hidden = NO;
    
}






@end
