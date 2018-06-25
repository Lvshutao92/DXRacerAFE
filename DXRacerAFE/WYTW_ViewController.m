//
//  WYTW_ViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WYTW_ViewController.h"
#import "configArea_Model.h"
@interface WYTW_ViewController ()<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *ids1;
    NSString *ids2;
}
@property(nonatomic,strong)NSMutableArray *idarr;
@property(nonatomic,strong)NSMutableArray *Array1;
@property(nonatomic,strong)NSMutableArray *Array2;
@property(nonatomic,strong)NSMutableArray *idarr2;
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)UITableView *tableview2;
@end

@implementation WYTW_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textview.delegate = self;
    self.textview.layer.masksToBounds = YES;
    self.textview.layer.cornerRadius  = 5;
    self.textview.layer.borderWidth   = 0.5;
    self.img.userInteractionEnabled = YES;
    self.textview.layer.borderColor   = [UIColor colorWithWhite:.6 alpha:.5].CGColor;
    
    
    self.lab1.text = NSLocalizedString(@"e10", nil);
    self.lab2.text = NSLocalizedString(@"e11", nil);
    self.lab3.text = NSLocalizedString(@"e12", nil);
    self.lab4.text = NSLocalizedString(@"e13", nil);
    
    
    self.textfield1.placeholder = NSLocalizedString(@"x19", nil);
    self.textfield2.placeholder = NSLocalizedString(@"x19", nil);
    
    self.textfield1.delegate = self;
    self.textfield2.delegate = self;
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(140, 110, SCREEN_WIDTH-150, 150)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    self.tableview1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview1.layer.borderWidth = 1.0;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]init];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    self.tableview2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableview2.layer.borderWidth = 1.0;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
    
    [self lodinformation];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 60, 30);
    [button setTitle:NSLocalizedString(@"e14", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
}



- (IBAction)clickimg:(id)sender {
    [self selectedImage];
}


- (void)clickSave{
    if (ids1.length != 0 && ids2.length != 0 && self.textview.text.length != 0) {
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
                @"configIds":ids1,
                @"configId":ids2,
                @"questionContent":self.textview.text,
                };
        
//            NSLog(@"%@",dic);
        [session POST:KURLNSString2(@"servlet", @"ticket", @"ticketquestion", @"add") parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData * data   =  UIImagePNGRepresentation(scaledImage);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"imgFile" fileName:fileName mimeType:@"image/png"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//                    NSLog(@"%@",dic);
            if ([[dic objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"e16", nil) preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"e15", nil) preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.Array1.count;
    }
    return self.Array2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.textLabel.text = [self.Array1 objectAtIndex:indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.textLabel.text = [self.Array2 objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.textfield2.text = nil;
        ids2 = nil;
        
        self.textfield1.text = [self.Array1 objectAtIndex:indexPath.row];
        ids1 = [self.idarr objectAtIndex:indexPath.row];
        [self lodErjiInformation:ids1];
    }
    if ([tableView isEqual:self.tableview2]) {
        self.textfield2.text = [self.Array2 objectAtIndex:indexPath.row];
        ids2 = [self.idarr2 objectAtIndex:indexPath.row];
    }
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
}


- (void)lodErjiInformation:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            @"parentId":str
            };
    [session POST:KURLNSString2(@"servlet", @"ticket",@"ticketquestion",@"initTicketConfig") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        [weakSelf.Array2 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dic in arr) {
            configArea_Model *model = [configArea_Model mj_objectWithKeyValues:dic];
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
                [weakSelf.Array2 addObject:model.englishName];
            }else{
                [weakSelf.Array2 addObject:model.chineseName];
            }
            
            [weakSelf.idarr2 addObject:model.id];
        }
        if (weakSelf.Array2.count > 0) {
            weakSelf.textfield2.text = weakSelf.Array2.firstObject;
            ids2 = weakSelf.idarr2.firstObject;
        }
        
        CGFloat height = self.Array2.count * 50;
        if (height <= 150) {
            weakSelf.tableview2.frame = CGRectMake(140, 160, SCREEN_WIDTH-150, height);
        }else{
            weakSelf.tableview2.frame = CGRectMake(140, 160, SCREEN_WIDTH-150, 150);
        }
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"businessId.text"],
            };
    [session POST:KURLNSString2(@"servlet", @"ticket",@"ticketquestion",@"initpage") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        [weakSelf.Array1 removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"TicketConfiglist"];
        for (NSDictionary *dic in arr) {
            configArea_Model *model = [configArea_Model mj_objectWithKeyValues:dic];
            
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
                [weakSelf.Array1 addObject:model.englishName];
            }else{
                [weakSelf.Array1 addObject:model.chineseName];
            }
            
            [weakSelf.idarr addObject:model.id];
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (void)selectedImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"e19", nil) preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:NSLocalizedString(@"e17", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerPictureFromAlbum];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:NSLocalizedString(@"e18", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromCamera];
    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:NSLocalizedString(@"n", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"x9", nil) message:NSLocalizedString(@"e20", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"n", nil) otherButtonTitles:NSLocalizedString(@"sure", nil), nil];
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



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
        if ([textField isEqual:self.textfield1]) {
            self.tableview2.hidden = YES;
            [self.textview resignFirstResponder];
            if (self.tableview1.hidden == YES) {
                self.tableview1.hidden = NO;
            }else{
                self.tableview1.hidden = YES;
            }
            return NO;
        }
        if ([textField isEqual:self.textfield2]) {
            self.tableview1.hidden = YES;
            [self.textview resignFirstResponder];
            if (self.tableview2.hidden == YES) {
                self.tableview2.hidden = NO;
            }else{
                self.tableview2.hidden = YES;
            }
            return NO;
        }
    return NO;
}

- (NSMutableArray *)Array1{
    if (_Array1 == nil) {
        self.Array1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array1;
}
- (NSMutableArray *)Array2{
    if (_Array2 == nil) {
        self.Array2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array2;
}
- (NSMutableArray *)idarr{
    if (_idarr == nil) {
        self.idarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _idarr;
}
- (NSMutableArray *)idarr2{
    if (_idarr2 == nil) {
        self.idarr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _idarr2;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textview resignFirstResponder];
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
}
@end
