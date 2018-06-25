//
//  PL_01_GoodsModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PL_01_GoodsModel : NSObject
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *field5;
@property(nonatomic,strong)NSString *field6;
@property(nonatomic,strong)NSString *field7;
@property(nonatomic,strong)NSString *field8;
@property(nonatomic,strong)NSString *field9;
@property(nonatomic,strong)NSString *field10;


@property(nonatomic,strong)NSString *fcno;
@property(nonatomic,strong)NSString *fcnoBomId;
@property(nonatomic,strong)NSString *fcnoNameChinese;
@property(nonatomic,strong)NSString *fcnoNameEnglish;


@property(nonatomic,strong)NSString *hsCode;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *itemno;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *packageHeight;

@property(nonatomic,strong)NSString *packageLength;
@property(nonatomic,strong)NSString *packageWeight;
@property(nonatomic,strong)NSString *packageWidth;
@property(nonatomic,strong)NSString *series;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *type;







//现货多的
@property(nonatomic,strong)NSString *currentQuantity;
@property(nonatomic,strong)NSString *lockQuantity;
@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *skuCode;
@property(nonatomic,strong)NSString *skuNameCn;
@property(nonatomic,strong)NSString *skuNameEn;



@end
