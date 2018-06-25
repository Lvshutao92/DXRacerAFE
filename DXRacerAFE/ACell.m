//
//  ACell.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "ACell.h"
@interface ACell()

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
@implementation ACell

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


-(void)reloadDataWith:(FK1Model *)model
{
   
    self.lab6.text = model.model1.orderNo;
    self.lab7.text =  [Manager jinegeshi:model.model1.productTotalFee];
    self.lab7.textColor = [UIColor redColor];
    self.lab8.textColor = [UIColor redColor];
    
    self.lab8.text =  [Manager jinegeshi:model.totalFee];
    
    
    if ([model.model1.orderType isEqualToString:@"batchOrder"]) {
       self.lab9.text =  @"批量订单";
    }else if ([model.model1.orderType isEqualToString:@"afterSale"]) {
        self.lab9.text =  @"售后订单";
    }else if ([model.model1.orderType isEqualToString:@"tradOrder"]) {
        self.lab9.text =  @"现货订单";
    }
    
    
    if ([model.model1.orderStatus isEqualToString:@"confirm"]) {
        self.lab10.text =  @"待确认订单";
    }else if ([model.model1.orderStatus isEqualToString:@"confirmed"]) {
        self.lab10.text =  @"已确认订单";
    }else if ([model.model1.orderStatus isEqualToString:@"production"]) {
        self.lab10.text =  @"生产中订单";
    }else if ([model.model1.orderStatus isEqualToString:@"undelivery"]) {
        self.lab10.text =  @"待发货订单";
    }else if ([model.model1.orderStatus isEqualToString:@"delivery"]) {
        self.lab10.text =  @"已发货订单";
    }else if ([model.model1.orderStatus isEqualToString:@"cancelled"]) {
        self.lab10.text =  @"已取消订单";
    }
    
    self.selectBtn.selected = self.isSelected;
}

-(void)setupMainView
{
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(5, 0, SCREEN_WIDTH-10, 200);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = kUIColorFromRGB(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame =  CGRectMake(2.5, 85, 30, 30);
    self.selectBtn.selected = self.isSelected;
    [self.selectBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    
    
    UIImage *theImage = [UIImage imageNamed:@"cart_selected_btn"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.selectBtn setImage:theImage forState:UIControlStateSelected];
    [self.selectBtn setTintColor:RGBACOLOR(32, 157, 149, 1.0)];
    
    
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.selectBtn];
    
    
    
    self.lab1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, 75, 30)];
    self.lab1.text = @"订单编号";
    [bgView addSubview:self.lab1];
    self.lab6 = [[UILabel alloc]initWithFrame:CGRectMake(115, 5, SCREEN_WIDTH-125, 30)];
    [bgView addSubview:self.lab6];
    
    
    self.lab2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 45, 75, 30)];
    self.lab2.text = @"货款总计";
    [bgView addSubview:self.lab2];
    self.lab7 = [[UILabel alloc]initWithFrame:CGRectMake(115, 45, SCREEN_WIDTH-125, 30)];
    [bgView addSubview:self.lab7];
    
    self.lab3 = [[UILabel alloc]initWithFrame:CGRectMake(35, 85, 75, 30)];
    self.lab3.text = @"应付定金";
    [bgView addSubview:self.lab3];
    self.lab8 = [[UILabel alloc]initWithFrame:CGRectMake(115, 85, SCREEN_WIDTH-125, 30)];
    [bgView addSubview:self.lab8];
    
    self.lab4 = [[UILabel alloc]initWithFrame:CGRectMake(35, 125, 75, 30)];
    self.lab4.text = @"订单类型";
    [bgView addSubview:self.lab4];
    self.lab9 = [[UILabel alloc]initWithFrame:CGRectMake(115, 125, SCREEN_WIDTH-125, 30)];
    [bgView addSubview:self.lab9];
    
    self.lab5 = [[UILabel alloc]initWithFrame:CGRectMake(35, 165, 75, 30)];
    self.lab5.text = @"订单状态";
    [bgView addSubview:self.lab5];
    self.lab10 = [[UILabel alloc]initWithFrame:CGRectMake(115, 165, SCREEN_WIDTH-125, 30)];
    [bgView addSubview:self.lab10];

    
}


@end
