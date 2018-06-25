//
//  JXS_SH_1_cell.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_SH_1_cell.h"
@interface JXS_SH_1_cell()

//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
//显示照片
@property (nonatomic,retain) UIImageView *imageView_cell;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//尺寸
@property (nonatomic,retain) UILabel *sizeLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *priceLabel;


@property (nonatomic,strong)UILabel *lab1;
@property (nonatomic,strong)UILabel *lab2;
@property (nonatomic,strong)UILabel *lab3;
@property (nonatomic,strong)UILabel *lab4;
@property (nonatomic,strong)UILabel *lab5;
@property (nonatomic,strong)UILabel *lab6;
@property (nonatomic,strong)UILabel *lab7;
@property (nonatomic,strong)UILabel *lab8;
@property (nonatomic,strong)UILabel *lab9;
@property (nonatomic,strong)UILabel *lab10;
@end










@implementation JXS_SH_1_cell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 246, 248);
        
        
        
        [self setupMainView];
        
    }
    return self;
}
//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    button.selected = !button.selected;
    if (self.cartBlock) {
        self.cartBlock(button.selected);
    }
}


-(void)reloadDataWith:(PL_____model *)model
{
    self.lab6.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a1", nil),model.orderNo];
//    self.lab7.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a2", nil),[Manager jinegeshi:model.orderTotalFee]];
    self.lab7.textColor = [UIColor redColor];
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl2", nil)];
    }else if ([model.orderStatus isEqualToString:@"confirmed"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl3", nil)];
    }else if ([model.orderStatus isEqualToString:@"production"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl4", nil)];
    }else if ([model.orderStatus isEqualToString:@"undelivery"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl5", nil)];
    }else if ([model.orderStatus isEqualToString:@"delivery"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl6", nil)];
    }else if ([model.orderStatus isEqualToString:@"cancel"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"a3", nil),NSLocalizedString(@"pl7", nil)];
    }
    
    

    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@: %@%.2f",NSLocalizedString(@"a2", nil),model.model3.field1,[model.orderTotalFee floatValue]]];
    // 需要改变的区间
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"myLanguage"] isEqualToString:@"en"]) {
        NSRange range1 = NSMakeRange(0, 10);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:range1];
        // 为label添加Attributed
        [self.lab7 setAttributedText:noteStr];
    }else{
        NSRange range1 = NSMakeRange(0, 5);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:range1];
        // 为label添加Attributed
        [self.lab7 setAttributedText:noteStr];
    }
//
//
//
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl2", nil)];
        self.lab8.textColor = RGBACOLOR(242, 180, 108, 1);
    }else if ([model.orderStatus isEqualToString:@"confirmed"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl3", nil)];
        self.lab8.textColor = RGBACOLOR(0, 195, 237, 1);
    }else if ([model.orderStatus isEqualToString:@"production"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl4", nil)];
        self.lab8.textColor = RGBACOLOR(32, 157, 149, 1.0);
    }else if ([model.orderStatus isEqualToString:@"undelivery"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl5", nil)];
        self.lab8.textColor = RGBACOLOR(234, 133, 189, 1);
    }else if ([model.orderStatus isEqualToString:@"delivery"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl6", nil)];
        self.lab8.textColor = [UIColor redColor];
    }else if ([model.orderStatus isEqualToString:@"cancel"]) {
        self.lab8.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"pl7", nil)];
        self.lab8.textColor = RGBACOLOR(52, 56, 59, 1);
    }
    self.selectBtn.selected = self.isSelected;
}

-(void)setupMainView
{
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = kUIColorFromRGB(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame =  CGRectMake(2.5, 50, 30, 30);
    self.selectBtn.selected = self.isSelected;
    [self.selectBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    
    
    UIImage *theImage = [UIImage imageNamed:@"cart_selected_btn"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.selectBtn setImage:theImage forState:UIControlStateSelected];
    [self.selectBtn setTintColor:[UIColor redColor]];
    
    
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.selectBtn];
    
    
    
//    self.lab1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, 75, 30)];
//    self.lab1.text = NSLocalizedString(@"a1", nil);
//    [bgView addSubview:self.lab1];
    self.lab6 = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, SCREEN_WIDTH-45, 30)];
    [bgView addSubview:self.lab6];
    
    
//    self.lab2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 45, 75, 30)];
//    self.lab2.text = NSLocalizedString(@"a2", nil);
//    [bgView addSubview:self.lab2];
    self.lab7 = [[UILabel alloc]initWithFrame:CGRectMake(35, 45, SCREEN_WIDTH-45, 30)];
    self.lab7.font = [UIFont systemFontOfSize:18];
    [bgView addSubview:self.lab7];
    
//    self.lab3 = [[UILabel alloc]initWithFrame:CGRectMake(35, 85, 75, 30)];
//    self.lab3.text = NSLocalizedString(@"a3", nil);
//    [bgView addSubview:self.lab3];
    self.lab8 = [[UILabel alloc]initWithFrame:CGRectMake(35, 85, SCREEN_WIDTH-45, 30)];
    self.lab8.font = [UIFont systemFontOfSize:20];
    [bgView addSubview:self.lab8];
    
//    self.lab4 = [[UILabel alloc]initWithFrame:CGRectMake(35, 125, 75, 30)];
//    self.lab4.text = @"集装箱";
//    [bgView addSubview:self.lab4];
//    self.lab9 = [[UILabel alloc]initWithFrame:CGRectMake(115, 125, SCREEN_WIDTH-125, 30)];
//    [bgView addSubview:self.lab9];
//    
//    self.lab5 = [[UILabel alloc]initWithFrame:CGRectMake(35, 165, 100, 30)];
//    self.lab5.text = @"计划生产日期";
//    
//    [bgView addSubview:self.lab5];
//    self.lab10 = [[UILabel alloc]initWithFrame:CGRectMake(140, 165, SCREEN_WIDTH-150, 30)];
//    [bgView addSubview:self.lab10];
    
    self.lab1.font = [UIFont systemFontOfSize:16];
    self.lab2.font = [UIFont systemFontOfSize:16];
    self.lab3.font = [UIFont systemFontOfSize:16];
//    self.lab5.font = [UIFont systemFontOfSize:16];
//    self.lab4.font = [UIFont systemFontOfSize:16];
    
    self.lab6.font = [UIFont systemFontOfSize:16];
    self.lab7.font = [UIFont systemFontOfSize:18];
    self.lab8.font = [UIFont systemFontOfSize:18];
//    self.lab9.font = [UIFont systemFontOfSize:16];
//    self.lab10.font = [UIFont systemFontOfSize:16];
}


@end
