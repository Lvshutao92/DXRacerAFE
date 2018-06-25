//
//  FK3_WanShan_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/14.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FK3_WanShan_ViewController.h"

#import "FK3WS_Arr2_model.h"
#import "FK3WS_Arr1_model.h"
#import "FK3WS_Data_model.h"
#import "FK3WSModel.h"



@interface FK3_WanShan_ViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *fkid;
    NSString *skid;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;

@end

@implementation FK3_WanShan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上传信用证";
    
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.img.userInteractionEnabled = YES;
    self.text1.text = self.str1;
    self.text2.text = [NSString stringWithFormat:@"%.02f",[self.str2 floatValue]];
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(90, 235, SCREEN_WIDTH-100, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(90, 285, SCREEN_WIDTH-100, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    [self lodDate];
}

- (IBAction)clickImageview:(id)sender {
    [self selectedImage];
}

- (IBAction)clickButton:(id)sender {
    
    
    if (self.text1.text.length != 0 && self.text2.text.length != 0) {
        [self lodSaveInformation];
    }
    
}

- (void)lodSaveInformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    
    CGSize size = self.img.image.size;
    size.height = size.height/6;
    size.width  = size.width/6;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.img.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"userId":[Manager redingwenjianming:@"loginId.text"],
            @"id":self.strid,
            @"paymentId":fkid,
            @"receiptId":skid,
            };
    
//        NSLog(@"%@",dic);
    [session POST:KURLNSString3(@"servlet", @"payment", @"dealer", @"information",@"update") parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"上传成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview]) {
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        FK3WS_Arr2_model *model = self.dataArray1[indexPath.row];
        self.text3.text = [NSString stringWithFormat:@"%@ %@ %@",model.bankName,model.bankAccount,model.bankNo];
        fkid = model.id;
    }
    if ([tableView isEqual:self.tableview1]) {
        FK3WS_Arr1_model *model = self.dataArray[indexPath.row];
        self.text4.text = [NSString stringWithFormat:@"%@ %@ %@",model.bankName,model.bankAccount,model.bankNo];
        skid = model.id;
    }
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FK3WS_Arr2_model *model = [self.dataArray1 objectAtIndex:indexPath.row];
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.bankName,model.bankAccount,model.bankNo];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FK3WS_Arr1_model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.bankName,model.bankAccount,model.bankNo];
    
    
    return cell;
}




- (void)lodDate{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"dealerId":[Manager redingwenjianming:@"dealerId.text"],
            @"id":self.strid,
            };
    [session POST:KURLNSString2(@"servlet", @"payment", @"dealer",@"informationtext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSDictionary *diction = [dic objectForKey:@"data"];
//        NSLog(@"----%@",diction);
        
        
        NSMutableArray *array = [[dic objectForKey:@"rows"] objectForKey:@"configBankList"];
        NSMutableArray *array1 = [[dic objectForKey:@"rows"] objectForKey:@"dealerBankList"];
        
        
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            FK3WS_Arr1_model *model = [FK3WS_Arr1_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.dataArray1 removeAllObjects];
        for (NSDictionary *dic in array1) {
            FK3WS_Arr2_model *model = [FK3WS_Arr2_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray1 addObject:model];
        }
        
        FK3WS_Arr2_model *model = weakSelf.dataArray1.firstObject;
        weakSelf.text3.text = [NSString stringWithFormat:@"%@ %@ %@",model.bankName,model.bankAccount,model.bankNo];
        fkid = model.id;
        
        FK3WS_Arr1_model *model1 = weakSelf.dataArray.firstObject;
        weakSelf.text4.text = [NSString stringWithFormat:@"%@ %@ %@",model1.bankName,model1.bankAccount,model1.bankNo];
        skid = model1.id;
        
        
        [weakSelf.tableview  reloadData];
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        self.tableview1.hidden = YES;
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text4]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        self.tableview.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text1]) {
        self.tableview.hidden = YES;
        self.tableview1.hidden = YES;
    }
    if ([textField isEqual:self.text2]) {
        self.tableview.hidden = YES;
        self.tableview1.hidden = YES;
    }
    return NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
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
    self.img.image = imagesave;
    
    NSData * imageData = UIImagePNGRepresentation(imagesave);
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * fullPathToFile = [documentsDirectory stringByAppendingString:@"/pic.png"];
    [imageData writeToFile:fullPathToFile atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}



@end
