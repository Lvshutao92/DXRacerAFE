//
//  ShoopingCell.m
//  DXRacer
//
//  Created by ilovedxracer on 2017/6/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "ShoopingCell.h"

@interface ShoopingCell()

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

@end
@implementation ShoopingCell


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

// 数量加按钮
-(void)addBtnClick
{
    if (self.numAddBlock) {
        self.numAddBlock();
    }
}

//数量减按钮
-(void)cutBtnClick
{
    if (self.numCutBlock) {
        self.numCutBlock();
    }
}

-(void)reloadDataWith:(PL_03_Model *)model
{    
    [self.imageView_cell sd_setImageWithURL:[NSURL URLWithString:NSString(model.imageUrl)]placeholderImage:[UIImage imageNamed:@"bgview"]];
    
    self.nameLabel.text = model.itemno;
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@%.2f",model.currencyType,[model.unitPrice floatValue]];
    ;

    
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",model.currencyType,[Manager jinegeshi111:[NSString stringWithFormat:@"%.2lf",[model.unitPrice floatValue]*[model.quantity floatValue]]]];
    
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.quantity];
    self.sizeLabel.text = [NSString stringWithFormat:@"%@",model.fcno];
    
    self.selectBtn.selected = self.isSelected;
    model.number = [model.quantity integerValue];
    
}


-(void)setupMainView
{
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = kUIColorFromRGB(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(5, 46, 28, 28);
    self.selectBtn.selected = self.isSelected;
    [self.selectBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    
    
    UIImage *theImage = [UIImage imageNamed:@"cart_selected_btn"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.selectBtn setImage:theImage forState:UIControlStateSelected];
    [self.selectBtn setTintColor:[UIColor redColor]];
    
    
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.selectBtn];
    
    //照片背景
    UIView *imageBgView = [[UIView alloc]init];
    imageBgView.frame = CGRectMake(40, 10, 100, 100);
    imageBgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:imageBgView];
    
    //显示照片
    self.imageView_cell = [[UIImageView alloc]init];
    self.imageView_cell.frame = CGRectMake(40, 10, 100, 100);
    self.imageView_cell.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView_cell.layer.borderColor = [UIColor colorWithWhite:.85 alpha:.5].CGColor;
    self.imageView_cell.layer.borderWidth = 1.0;
    [bgView addSubview:self.imageView_cell];
    
    
    
    
    //商品名
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(145, 10, 150, 20);
    //    self.nameLabel.text = @"海报";
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.nameLabel];
    
    //尺寸
    self.sizeLabel = [[UILabel alloc]init];
    self.sizeLabel.frame = CGRectMake(145, 50, 120, 20);
    //    self.sizeLabel.text = @"尺寸:58*86cm";
    self.sizeLabel.textColor = RGBCOLOR(132, 132, 132);
    self.sizeLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:self.sizeLabel];
    
    //时间
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.frame = CGRectMake(145, 90, 100, 20);
    self.dateLabel.font = [UIFont systemFontOfSize:18];
    self.dateLabel.textColor = [UIColor redColor];
    [bgView addSubview:self.dateLabel];
    
    
    //价格
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.frame = CGRectMake(SCREEN_WIDTH-95, 50, 80, 30);
    //    self.priceLabel.text = @"￥100.11";
    self.priceLabel.font = [UIFont boldSystemFontOfSize:14];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.priceLabel];
    
    //数量加按钮
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(SCREEN_WIDTH-36, 87, 26, 26);
    [self.addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [self.addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.addBtn];
    
    //数量减按钮
    self.cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cutBtn.frame = CGRectMake(SCREEN_WIDTH-112, 87, 26, 26);
    [self.cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [self.cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [self.cutBtn addTarget:self action:@selector(cutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.cutBtn];
    
    
    //数量显示
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.frame = CGRectMake(SCREEN_WIDTH-86, 87, 50, 26);
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.text = @"5";
    self.numberLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:self.numberLabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-86, 87, 50, 1)];
    line.backgroundColor = [UIColor colorWithWhite:.55 alpha:.5];
    [bgView addSubview:line];

    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-86, 112, 50, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.55 alpha:.5];
    [bgView addSubview:line1];
    
}

@end
