//
//  FK_1_2_Details_TableViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FK_1_2_Details_TableViewController.h"
#import "OrderDetails_1_Cell.h"
#import "FK_1_2_Details_Model.h"

@interface FK_1_2_Details_TableViewController ()
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation FK_1_2_Details_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderDetails_1_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    
    [self lodMingXi];
    

}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetails_1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FK_1_2_Details_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.productCode;
    
    cell.lab2.text = [Manager jinegeshi:model.unitPrice];
    
    cell.lab3.text = model.quantity;
    
    cell.lab4.text = [Manager jinegeshi:[NSString stringWithFormat:@"%.02f",[model.unitPrice floatValue]*[model.quantity floatValue]]];
    return cell;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (void)lodMingXi{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"id":self.orderid,
            };
    [session POST:KURLNSString3(@"servlet", @"order", @"dealer",@"item",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"----%@",dic);
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            
            [weakSelf.dataArray removeAllObjects];
             NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dic in arr) {
                FK_1_2_Details_Model *model = [FK_1_2_Details_Model mj_objectWithKeyValues:dic];
                [weakSelf.dataArray addObject:model];
            }
        }
//        NSLog(@"====%ld",weakSelf.dataArray.count);
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
