//
//  YCSH_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXSCurrencymodel.h"
#import "JXSGoodsExchangeRatemodel.h"
@interface YCSH_model : NSObject

@property(nonatomic,strong)NSString *aftersale_price;
@property(nonatomic,strong)NSString *weight;
@property(nonatomic,strong)NSString *inventory;

@property(nonatomic,strong)NSString *english_name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *chinese_name;

@property(nonatomic,strong)NSString *part_no;
@property(nonatomic,strong)NSString *package_width;
@property(nonatomic,strong)NSString *package_height;

@property(nonatomic,strong)NSString *classify_en;
@property(nonatomic,strong)NSString *classify_cn;
@property(nonatomic,strong)NSString *package_length;


@property(nonatomic,strong)NSDictionary *currency;
@property(nonatomic,strong)JXSCurrencymodel *model1;


@property(nonatomic,strong)NSDictionary *goodsExchangeRate;
@property(nonatomic,strong)JXSGoodsExchangeRatemodel *model2;
@end
