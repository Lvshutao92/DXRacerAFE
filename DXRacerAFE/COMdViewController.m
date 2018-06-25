//
//  COMdViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "COMdViewController.h"
#import "SGTopScrollMenu.h"
#import "Companydetails_1_TableViewController.h"
#import "Companydetails_2_TableViewController.h"
#import "Companydetails_3_TableViewController.h"
#import "Companydetails_4_TableViewController.h"
#import "Companydetails_5_TableViewController.h"




@interface COMdViewController ()<SGTopScrollMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation COMdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"经销商管理";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    
    self.titles = @[@"付款方式", @"产品列表", @"银行信息", @"联系人", @"地址"];
    
    self.topScrollMenu = [SGTopScrollMenu topScrollMenuWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    _topScrollMenu.titlesArr = [NSArray arrayWithArray:_titles];
    _topScrollMenu.topScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    
    _mainScrollView.scrollEnabled = YES;
    [self.view addSubview:_mainScrollView];
    
    Companydetails_1_TableViewController *oneVC = [[Companydetails_1_TableViewController alloc] init];
    oneVC.idstr = self.idstr;
    [self.mainScrollView addSubview:oneVC.view];
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];
    
    
}





















- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    
    Companydetails_1_TableViewController *oneVC = [[Companydetails_1_TableViewController alloc] init];
    oneVC.idstr = self.idstr;
    [self addChildViewController:oneVC];
    
    Companydetails_2_TableViewController *twoVC = [[Companydetails_2_TableViewController alloc] init];
    twoVC.idstr = self.idstr;
    [self addChildViewController:twoVC];
    
    Companydetails_3_TableViewController *threeVC = [[Companydetails_3_TableViewController alloc] init];
    threeVC.idstr = self.idstr;
    [self addChildViewController:threeVC];
    
    Companydetails_4_TableViewController *fourVC = [[Companydetails_4_TableViewController alloc] init];
    fourVC.idstr = self.idstr;
    [self addChildViewController:fourVC];
    
    Companydetails_5_TableViewController *fiveVC = [[Companydetails_5_TableViewController alloc] init];
    fiveVC.idstr = self.idstr;
    [self addChildViewController:fiveVC];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:@(index) userInfo:nil];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topScrollMenu.allTitleLabel[index];
    
    [self.topScrollMenu selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self.topScrollMenu setupTitleCenter:selLabel];
}

@end
