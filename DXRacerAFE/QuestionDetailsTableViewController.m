//
//  QuestionDetailsTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2018/1/8.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "QuestionDetailsTableViewController.h"
#import "WDWT_Model.h"
#import "QuestionDetailsCell.h"
#import "QuestionDetails_1_Cell.h"
@interface QuestionDetailsTableViewController ()
{
    CGFloat hei;
    CGFloat height;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation QuestionDetailsTableViewController





-(NSDictionary *)setTextLineSpaceWithString:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withTextlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = lineSpace; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 20.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font,
                          
                          NSParagraphStyleAttributeName:paraStyle,
                          
                          NSKernAttributeName:textlengthSpace
                          
                          };
    
    return dic;
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *headerview = [[UIView alloc]init];
    
    UILabel *lab = [[UILabel alloc]init];
    
    UIFont * font = [UIFont systemFontOfSize:18]; //字号
    CGFloat lineSpace = 10;//行间距
    CGFloat paragraphSpacing = 10;//段间距
    CGSize labSize = CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT);//label宽高
    NSNumber * textLengthSpace  = @2;//字间距
    NSDictionary * dic  = [self setTextLineSpaceWithString:self.miaoshu withFont:font withLineSpace:lineSpace  withTextlengthSpace:textLengthSpace paragraphSpacing:paragraphSpacing];
    CGSize size = [self.miaoshu boundingRectWithSize:labSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
     lab.numberOfLines = 0;
    lab.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, size.height);
    lab.attributedText = [[NSAttributedString alloc] initWithString:self.miaoshu attributes:dic];
    [headerview addSubview:lab];
    

    
    
    
    
    
    UIImageView *imgs = [[UIImageView alloc]init];
    imgs.contentMode = UIViewContentModeScaleAspectFit;
    
    if (self.img!=nil && self.img.length!=0 && ![self.img isEqual:[NSNull null]]) {
        imgs.frame = CGRectMake(10, size.height+15, 200, 200);
        [imgs sd_setImageWithURL:[NSURL URLWithString:NSString(self.img)]];
        hei = size.height + 215;
    }else{
        imgs.frame = CGRectMake(0, 0, 0, 0);
        hei = size.height + 5;
    }
    [headerview addSubview:imgs];
    
    
    UILabel *timelab = [[UILabel alloc]init];
    timelab.frame = CGRectMake(10, hei+10, SCREEN_WIDTH-20, 20);
    timelab.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"g12", nil),self.time];
    timelab.textColor = [UIColor lightGrayColor];
    timelab.font = [UIFont systemFontOfSize:14];
    [headerview addSubview:timelab];
    
    headerview.frame = CGRectMake(0, 0, SCREEN_WIDTH, hei+40);
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, hei+39, SCREEN_WIDTH, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    [headerview addSubview:lin];
    
    self.tableView.tableHeaderView = headerview;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionDetailsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionDetails_1_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self lodinformation];
}
- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.idstr,
            @"sorttype":@"desc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString2(@"servlet/ticket", @"ticketquestion",@"add",@"inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",[[Manager sharedManager] convertToJsonData:dic]);
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"Ticket_AnswerList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"Ticket_AnswerList"];
            for (NSDictionary *dict in arr) {
                WDWT_Model *model = [WDWT_Model mj_objectWithKeyValues:dict];
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115+height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDWT_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.username isEqualToString:[Manager redingwenjianming:@"userName.text"]]){
        static NSString *identifierCell = @"cell1";
        QuestionDetails_1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[QuestionDetails_1_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.name.text = model.username;
        cell.content.text = model.answerContent;
        cell.content.numberOfLines = 0;
        cell.content.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.content sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
        cell.contentheight.constant = size.height;
        height = size.height;
        
        
        
        cell.time.text = [Manager TimeCuoToTime_yh:model.answerTime];
        
        return cell;
    }
    
    
    static NSString *identifierCell = @"cell";
    QuestionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[QuestionDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.namelab.text = model.username;
    cell.answerContent.text = model.answerContent;
    cell.answerContent.text = model.answerContent;
    cell.answerContent.numberOfLines = 0;
    cell.answerContent.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.answerContent sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.answerContentHeight.constant = size.height;
    height = size.height;
    
    
    
    
    cell.answerTime.text = [Manager TimeCuoToTime_yh:model.answerTime];
    return cell;
}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
