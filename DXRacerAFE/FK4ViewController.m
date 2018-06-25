//
//  FK4ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FK4ViewController.h"
#import "FK4TableViewCell.h"

#import "FK_4_Details_TableViewController.h"
#import "FK4_order_Model.h"
#import "FK4Model.h"
#import "LookPictureViewController.h"
@interface FK4ViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    
    UIView * view ;
    UIWindow *window;
    UIImageView *img;
    
    NSString *strid;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FK4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [Manager returnButton];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.editing = NO;
    self.tableview.allowsMultipleSelectionDuringEditing = YES;
    [self.tableview registerNib:[UINib nibWithNibName:@"FK4TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
    
    [self setUpReflash];
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FK_4_Details_TableViewController *fk12 = [[FK_4_Details_TableViewController alloc]init];
    fk12.navigationItem.title = @"明细";
    FK4Model *model = self.dataArray[indexPath.row];
    
    fk12.orderid = model.orderId;
    
    [self.navigationController pushViewController:fk12 animated:YES];
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"cell";
    FK4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[FK4TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FK4Model *model = self.dataArray[indexPath.row];
    
        cell.lab1.text =  model.ordermodel.orderNo;
        cell.lab2.text =  [Manager jinegeshi:model.ordermodel.productTotalFee];
    
    
        if ([model.paymentStatus isEqualToString:@"N"]) {
            cell.lab3.text =  @"未付款";
            
            cell.btn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
            [cell.btn addTarget:self action:@selector(clcickbtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
        }else if ([model.paymentStatus isEqualToString:@"A"]) {
            cell.lab3.text =  @"待审核";
            
            cell.btn.backgroundColor = [UIColor lightGrayColor];
            [cell.btn addTarget:self action:@selector(clcickbtnCancle:) forControlEvents:UIControlEventTouchUpInside];
            
           
            
        }else if ([model.paymentStatus isEqualToString:@"Y"]) {
            cell.lab3.text =  @"已审核";
            
            cell.btn.backgroundColor = [UIColor lightGrayColor];
            [cell.btn addTarget:self action:@selector(clcickbtnCancle:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
        }else if ([model.paymentStatus isEqualToString:@"C"]) {
            cell.lab3.text =  @"已取消";
            
            cell.btn.backgroundColor = [UIColor lightGrayColor];
            [cell.btn addTarget:self action:@selector(clcickbtnCancle:) forControlEvents:UIControlEventTouchUpInside];
            
           
        }
    
    
    if ([model.ordermodel.orderType isEqualToString:@"batchOrder"]) {
        cell.lab4.text =  @"批量订单";
    }else if ([model.ordermodel.orderType isEqualToString:@"afterSale"]) {
        cell.lab4.text =  @"售后订单";
    }else if ([model.ordermodel.orderType isEqualToString:@"tradOrder"]) {
        cell.lab4.text =  @"现货订单";
    }
    
        if ([model.ordermodel.orderStatus isEqualToString:@"confirm"]) {
            cell.lab5.text =  @"待确认订单";
            
            
            
        }else if ([model.ordermodel.orderStatus isEqualToString:@"confirmed"]) {
            cell.lab5.text =  @"已确认订单";
            
        }else if ([model.ordermodel.orderStatus isEqualToString:@"production"]) {
            cell.lab5.text =  @"生产中订单";
            
        }else if ([model.ordermodel.orderStatus isEqualToString:@"undelivery"]) {
            cell.lab5.text =  @"待发货订单";
            
        }else if ([model.ordermodel.orderStatus isEqualToString:@"delivery"]) {
            cell.lab5.text =  @"已发货订单";
            
        }else if ([model.ordermodel.orderStatus isEqualToString:@"cancelled"]) {
            cell.lab5.text =  @"已取消订单";
            
        }
    
    
    
    if ([model.paymentStatus isEqualToString:@"N"]) {
        if (model.field1 != nil){
            cell.surebtn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
            [cell.surebtn addTarget:self action:@selector(clcickbtnsure:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.surebtn.backgroundColor = [UIColor lightGrayColor];
            [cell.surebtn addTarget:self action:@selector(clcickbtnNosure:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        cell.surebtn.backgroundColor = [UIColor lightGrayColor];
        [cell.surebtn addTarget:self action:@selector(clcickbtnNosure:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (model.field1 != nil) {
        [cell.lookbtn setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.lookbtn addTarget:self action:@selector(clciklook:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.lookbtn setTitle:@"-" forState:UIControlStateNormal];
        [cell.lookbtn addTarget:self action:@selector(clcikNolook:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    return cell;
}

- (void)clciklook:(UIButton *)sender{
    FK4TableViewCell *cell = (FK4TableViewCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK4Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
    
    lookpic.imgStr =  model.field1;
    
    [self.navigationController pushViewController:lookpic animated:YES];
    
}

- (void)clcickbtnsure:(UIButton *)sender{
  
    FK4TableViewCell *cell = (FK4TableViewCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK4Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    [self lodsureinformation:model.id];
    
}
- (void)lodsureinformation:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"id":idstr,
            };
    [session POST:KURLNSString3(@"servlet", @"lc", @"dealer",@"paylist",@"confirm") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确认成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}







- (void)clcickbtn:(UIButton *)sender{
    
    FK4TableViewCell *cell = (FK4TableViewCell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    FK4Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    strid = model.id;
    
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    view.backgroundColor = [UIColor colorWithWhite:.5 alpha:.8];
   
    window = [[UIApplication sharedApplication].windows lastObject];
    window.windowLevel = UIWindowLevelNormal;
    [window addSubview:view];
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-150, SCREEN_WIDTH-60, 200)];
    vi.backgroundColor = [UIColor whiteColor];
    [view addSubview:vi];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-80, 30)];
    lable.text = @"信用证管理";
    lable.textAlignment = NSTextAlignmentCenter;
    [vi addSubview:lable];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(60, 50, 90, 50)];
    lab.text = @"请上传文件";
    [vi addSubview:lab];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake((SCREEN_WIDTH-200)/3, 150, 70, 30);
    btn1.backgroundColor = [UIColor lightGrayColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((SCREEN_WIDTH-200)/3*2+60, 150, 70, 30);
    btn2.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    [btn2 setTitle:@"保存" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn2];
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(160, 50, 70, 50)];
    img.image = [UIImage imageNamed:@"file"];
    img.userInteractionEnabled = YES;
    img.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap:)];
    [img addGestureRecognizer:tap];
    
    
    [vi addSubview:img];
   
}

- (void)cancle{
     [view removeFromSuperview];
}



- (void)clicktap:(UITapGestureRecognizer *)tap{
    [view removeFromSuperview];
    [self selectedImage];
}
- (void)selectedImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择图片获取路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerPictureFromAlbum];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromCamera];
    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionA setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionB setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionC setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [alert addAction:actionA];
    [alert addAction:actionB];
    [alert addAction:actionC];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
//从手机相册选取图片功能
- (void)pickerPictureFromAlbum {
    //1.创建图片选择器对象
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.allowsEditing = YES;
    imagepicker.delegate = self;
    [self presentViewController:imagepicker animated:YES completion:nil];
}
//拍照--照相机是否可用
- (void)pictureFromCamera {
    //照相机是否可用
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        //提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"摄像头不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;//如果不存在摄像头，直接返回即可，不需要做调用相机拍照的操作；
    }
    //创建图片选择器对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //设置图片选择器选择图片途径
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//从照相机拍照选取
    //设置拍照时下方工具栏显示样式
    imagePicker.allowsEditing = YES;
    //设置代理对象
    imagePicker.delegate = self;
    //最后模态退出照相机即可
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
//当得到选中的图片或视频时触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [window addSubview:view];
    
    
    UIImage *imagesave = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageOrientation imageOrientation = imagesave.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(imagesave.size);
        [imagesave drawInRect:CGRectMake(0, 0, imagesave.size.width, imagesave.size.height)];
        imagesave = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    img.image = imagesave;
    
    NSData * imageData = UIImagePNGRepresentation(imagesave);
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * fullPathToFile = [documentsDirectory stringByAppendingString:@"/pic.png"];
    [imageData writeToFile:fullPathToFile atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void)save{
     [view removeFromSuperview];
    
    
    [self lodShangChuanPic];
}

- (void)lodShangChuanPic{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    
    CGSize size = img.image.size;
    size.height = size.height/6;
    size.width  = size.width/6;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [img.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
   
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"userId":[Manager redingwenjianming:@"loginId.text"],
            @"id":strid,
            };
    
//    NSLog(@"%@",dic);
    [session POST:KURLNSString3(@"servlet", @"lc", @"dealer", @"paylist",@"upload") parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data   =  UIImagePNGRepresentation(scaledImage);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"imgFile" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"上传成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}




















- (void)clcickbtnNosure:(UIButton *)sender{}
- (void)clcikNolook:(UIButton *)sender{}
- (void)clcickbtnCancle:(UIButton *)sender{}
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
            };
    
    [session POST:KURLNSString3(@"servlet", @"lc", @"dealer", @"paylist",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            FK4Model *model = [FK4Model mj_objectWithKeyValues:dict];
            
            FK4_order_Model *model1 = [FK4_order_Model mj_objectWithKeyValues:model.order];
            model.ordermodel = model1;
            
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
            };
    
    [session POST:KURLNSString3(@"servlet", @"lc", @"dealer", @"paylist",@"list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"+++%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            FK4Model *model = [FK4Model mj_objectWithKeyValues:dict];
            
            FK4_order_Model *model1 = [FK4_order_Model mj_objectWithKeyValues:model.order];
            model.ordermodel = model1;
            
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

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [view removeFromSuperview];
}



@end
