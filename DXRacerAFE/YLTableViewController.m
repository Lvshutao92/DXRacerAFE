//
//  YLTableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YLTableViewController.h"
#import "YLmodel.h"
#import "YLCell.h"
#import "Piliang_Orderlist_details_Cell.h"
@interface YLTableViewController ()
{
    CGFloat height;
    
     CGFloat height1;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation YLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"Piliang_Orderlist_details_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    NSLog(@"%@",self.arr);
    [self lodXL];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105+height1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell";
    Piliang_Orderlist_details_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Piliang_Orderlist_details_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLmodel *model = [self.dataArray objectAtIndex:indexPath.row];
    
 
    
    if (model.picture == nil) {
        cell.img.image = [UIImage imageNamed:@"未标题-2"];
    }else{
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)] placeholderImage:[UIImage imageNamed:@"未标题-2"]];
    }
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.name];
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height1 = size.height;
    
    if (height1 > 20) {
        cell.imgtop.constant = (height1-20)/2+5;
    }else{
        cell.imgtop.constant = 5;
    }
    
    
    cell.lab2.text = [NSString stringWithFormat:@"%@",model.part_no];
    
    cell.lab3.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"d10", nil),model.part_number];
    cell.lab3.font = [UIFont systemFontOfSize:16];
    cell.lab3.textColor = [UIColor blackColor];
    cell.lab4.hidden = YES;
    return cell;
}


//请求列表
- (void)lodXL{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id1":self.arr
            };
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer", @"batch",@"af/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
//        NSLog(@"%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            YLmodel *model = [YLmodel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
