//
//  DX5_add_edit_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "DX5_add_edit_ViewController.h"
#import "KSDatePicker.h"
#import "DX5_o_model.h"
@interface DX5_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *scrollview;
    
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    
    NSString *ids;
    UIImageView *img;
}

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableview;

@end

@implementation DX5_add_edit_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    scrollview.contentSize = CGSizeMake(0, 600);
    scrollview.userInteractionEnabled = YES;
    [self.view addSubview:scrollview];
    
    [self setUpLeftLable];
    [self setUpRightTextfield];
    
   
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(130, 40, SCREEN_WIDTH-140, 200)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.hidden = YES;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview];
    
    [self lodinfor];
}


- (void)clickSave{
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    [self lodadd];
   
}




- (void)lodadd{
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
            @"field1":ids,
            @"enName":text2.text,
            @"cnName":text3.text,
            @"starttime":text4.text,
            @"endtime":text5.text,
            };
    
    //            NSLog(@"%@",dic);
    [session POST:KURLNSString2(@"servlet", @"server", @"dxracercertificate", @"add") parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data   =  UIImagePNGRepresentation(scaledImage);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"imgFile" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
                        NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"保存成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
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
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DX5_o_model *model = [self.dataArray objectAtIndex:indexPath.row];
    text1.text = model.certificateNameCn;
    ids = model.id;
    self.tableview.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DX5_o_model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.certificateNameCn;
    return cell;
}




- (void)lodinfor{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"server", @"dxracercertificate",@"add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                        NSLog(@"----%@",dic);
        NSMutableArray *array  = [[dic objectForKey:@"rows"] objectForKey:@"configCertificateList"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            DX5_o_model *model = [DX5_o_model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        DX5_o_model *model = weakSelf.dataArray.firstObject;
        text1.text = model.certificateNameCn;
        ids = model.id;
        
        [weakSelf.tableview  reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        if (self.tableview.hidden == YES) {
            self.tableview.hidden = NO;
        }else{
            self.tableview.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:text4]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
         self.tableview.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                text4.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:text5]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        self.tableview.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                text5.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    self.tableview.hidden = YES;
    return YES;
}






- (void)setUpRightTextfield{
    for (int i = 0; i<5; i++) {
        UITextField *lable = [[UITextField alloc]initWithFrame:CGRectMake(130, 10+50*i, SCREEN_WIDTH-140, 30)];
        switch (i) {
            case 0:
                text1 = lable;
                break;
            case 1:
                text2 = lable;
                break;
            case 2:
                text3 = lable;
                break;
            case 3:
                text4 = lable;
                text4.placeholder = @"请选择";
                break;
            case 4:
                text5 = lable;
                text5.placeholder = @"请选择";
                break;
                break;
            default:
                break;
        }
        lable.delegate = self;
        lable.font = [UIFont systemFontOfSize:16];
        lable.borderStyle=UITextBorderStyleRoundedRect;
        [scrollview addSubview:lable];
    }
    scrollview.userInteractionEnabled = YES;
    img = [[UIImageView alloc]initWithFrame:CGRectMake(130, 250, 100, 100)];
    img.image = [UIImage imageNamed:@"bgview"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap:)];
    [img addGestureRecognizer:tap];
    img.userInteractionEnabled = YES;
    img.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview addSubview:img];
    
    
}
- (void)clicktap:(UITapGestureRecognizer *)tap{
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
















- (void)setUpLeftLable{
    NSMutableArray *arr = [@[@"证书类型",@"英文名",@"中文名",@"有效起始日期",@"有效结束日期",@"上传文件"]mutableCopy];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 120, 30)];
        lable.text = arr[i];
        lable.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lable];
    }
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
