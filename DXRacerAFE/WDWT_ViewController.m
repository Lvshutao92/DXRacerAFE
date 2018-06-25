//
//  WDWT_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WDWT_ViewController.h"
#import "WDWT_Cell.h"
#import "LookPictureViewController.h"
#import "LookTextViewController.h"
#import "WDWT_Model.h"
#import "QuestionDetailsTableViewController.h"
@interface WDWT_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    NSString *field4;
    NSString *idstr;
    NSString *statu;
}

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableview;


@property (strong, nonatomic)UIScrollView *bgView;//半透明背景
@property (strong, nonatomic)UIView *alertView;//假设为弹窗
@property (strong, nonatomic)UITextView *textview;//
@property (strong, nonatomic)UITextField *textfield;//
@end

@implementation WDWT_ViewController

- (void)click1{
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
     field4 = @"";
    [self setUpReflash];
}
- (void)click2{
    [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    field4 = @"1";
    [self setUpReflash];
}
- (void)click3{
    [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    field4 = @"2";
    [self setUpReflash];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
     field4 = @"";
    CGFloat hei;
    if ([[[Manager sharedManager] iphoneType]isEqualToString:@"iPhone X"]) {
        hei = 88;
    }else{
        hei = 64;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, hei, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
   
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn1 setTitle:NSLocalizedString(@"g0", nil) forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn2 setTitle:NSLocalizedString(@"g1", nil) forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn3 setTitle:NSLocalizedString(@"g2", nil) forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn3];
    
    
    UILabel *LIN1 = [[UILabel alloc]init];
    LIN1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [view addSubview:LIN1];
    
    UILabel *LIN2 = [[UILabel alloc]init];
    LIN2.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [view addSubview:LIN2];
    
    
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        btn1.frame = CGRectMake(0, 0, 50, 50);
        btn2.frame = CGRectMake(50, 0, 110, 50);
        btn3.frame = CGRectMake(160, 0, 110, 50);
        LIN1.frame = CGRectMake(49, 5, 1, 40);
        LIN2.frame = CGRectMake(159, 5, 1, 40);
        
        btn1.titleLabel.font = [UIFont systemFontOfSize:13];
        btn2.titleLabel.font = [UIFont systemFontOfSize:13];
        btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    }else{
        btn1.frame = CGRectMake(0, 0, 80, 50);
        btn2.frame = CGRectMake(80, 0, 80, 50);
        btn3.frame = CGRectMake(160, 0, 80, 50);
        LIN1.frame = CGRectMake(79, 5, 1, 40);
        LIN2.frame = CGRectMake(159, 5, 1, 40);
    }
    
    
    
    
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, hei+52, SCREEN_WIDTH, SCREEN_HEIGHT-52-hei)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor=RGBACOLOR(230, 236, 240, 1);
    [self.tableview registerNib:[UINib nibWithNibName:@"WDWT_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setUpReflash];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
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
    
    [cell.btn2 setTitle:NSLocalizedString(@"h1", nil) forState:UIControlStateNormal];
    [cell.btn1 setTitle:NSLocalizedString(@"h2", nil) forState:UIControlStateNormal];
    
    
    
    
    WDWT_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = model.questionContent;
    
    
    cell.lab2.text = [Manager TimeCuoToTime_yh:model.createTime];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        CGSize size = [model.english_name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        cell.lab3.text = model.english_name;
        if (size.width >= 100) {
            cell.lab3width.constant = 100;
        }else{
            cell.lab3width.constant = size.width+10;
        }
    }else{
        CGSize size = [model.chinese_name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        cell.lab3.text = model.chinese_name;
        if (size.width >= 100) {
            cell.lab3width.constant = 100;
        }else{
            cell.lab3width.constant = size.width+10;
        }
    }
    LRViewBorderRadius(cell.lab3, 0, 1, [UIColor colorWithWhite:.85 alpha:.6]);
    cell.lab3.textAlignment = NSTextAlignmentCenter;
    

    
    if ([model.field4 isEqualToString:@"2"]) {
        cell.lab4.text = NSLocalizedString(@"g2", nil);
        cell.img.image = [UIImage imageNamed:@"da"];
    }else{
        cell.lab4.text = NSLocalizedString(@"g1", nil);
        cell.img.image = [UIImage imageNamed:@"ddhf"];
    }
    
    LRViewBorderRadius(cell.btn1, 3, 1, [UIColor redColor]);
    LRViewBorderRadius(cell.btn2, 3, 1, [UIColor blackColor]);
    
    
    [cell.btn2 addTarget:self action:@selector(clickdelete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickadd:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickadd:(UIButton *)sender{
    WDWT_Cell *cell = (WDWT_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    WDWT_Model *model = [self.dataArray objectAtIndex:indexpath.row];
    idstr = model.id;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    _bgView = [[UIScrollView alloc]init];
    _bgView.frame = window.bounds;
    _bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [window addSubview:_bgView];
    
    _alertView = [[UIView alloc ]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _alertView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    
    
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
    lab.text = NSLocalizedString(@"g10", nil);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:20];
    [_alertView addSubview:lab];
    
    _textview = [[UITextView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 150)];
    _textview.delegate = self;
    _textview.font = [UIFont systemFontOfSize:16];
    [_textview becomeFirstResponder];
    LRViewBorderRadius(_textview, 3, .5, [UIColor colorWithWhite:.8 alpha:.5]);
    [_alertView addSubview:_textview];
    
    
//    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 40)];
//    lab1.text = @"是否满意";
//    lab1.font = [UIFont systemFontOfSize:18];
//    [_alertView addSubview:lab1];
//
//
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"是",@"否"]];
//    segmentedControl.frame = CGRectMake(10, 240, 200, 40);
//    segmentedControl.selectedSegmentIndex = 0;
//    segmentedControl.momentary = NO;
//    [segmentedControl addTarget:self action:@selector(clicksegment:) forControlEvents:UIControlEventValueChanged];
//    [_alertView addSubview:segmentedControl];
   

    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(30, 230, (SCREEN_WIDTH-90)/2, 40);
    [cancel setTitle:NSLocalizedString(@"n", nil) forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    LRViewBorderRadius(cancel, 3, 1, [UIColor lightGrayColor]);
    [cancel addTarget:self action:@selector(clickcancel) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cancel];

    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake((SCREEN_WIDTH-90)/2+60, 230, (SCREEN_WIDTH-90)/2, 40);
    [sure setTitle:NSLocalizedString(@"sure", nil) forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    LRViewBorderRadius(sure, 3, 1, [UIColor redColor]);
    [sure addTarget:self action:@selector(clicksure) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:sure];
    
    
    [window addSubview:_alertView];
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAlertView)];
    [_bgView addGestureRecognizer:tap];
    
    
    
    
}

- (void)clicksegment:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex == 0) {
        statu = @"Y";
    }else if (seg.selectedSegmentIndex == 1) {
        statu = @"N";
    }
}

- (void)clicksure{
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT, 0, 0);
    }];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.3];
    [_textview resignFirstResponder];

    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"answerUserId":[Manager redingwenjianming:@"loginId.text"],
            @"id":idstr,
            @"answerContent":_textview.text,
            };
    [session POST:KURLNSString2(@"servlet", @"ticket", @"ticketquestion",@"update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"----%@",dic);
        if ([[dic objectForKey:@"code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"message"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                [weakSelf setUpReflash];
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"message"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}


- (void)clickcancel{
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT, 0, 0);
    }];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.3];
    [_textview resignFirstResponder];
}
- (void)hideAlertView{
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT, 0, 0);
    }];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.3];
    [_textview resignFirstResponder];
}
- (void)remove{
    [_bgView removeFromSuperview];
}









- (void)clickdelete:(UIButton *)sender{
    WDWT_Cell *cell = (WDWT_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    WDWT_Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"g5", nil) preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
                @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString2(@"servlet", @"ticket", @"ticketquestion",@"delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"----%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"g3", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                    [self.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"g4", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
   
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
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"field4":field4,
            };
    
    [session POST:KURLNSString2(@"servlet", @"ticket",@"ticketquestion",@"mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//      NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            WDWT_Model *model = [WDWT_Model mj_objectWithKeyValues:dict];
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
            @"field4":field4,
            };
    [session POST:KURLNSString2(@"servlet", @"ticket",@"ticketquestion",@"mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            WDWT_Model *model = [WDWT_Model mj_objectWithKeyValues:dict];
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
