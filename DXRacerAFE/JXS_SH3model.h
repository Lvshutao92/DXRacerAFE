//
//  JXS_SH3model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXSCartmodel.h"
#import "JXSCurrencymodel.h"
#import "JXSGoodsExchangeRatemodel.h"
#import "JXSPartsmodel.h"
@interface JXS_SH3model : NSObject
@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSDictionary *cart;
@property(nonatomic,strong)JXSCartmodel *model1;

@property(nonatomic,strong)NSDictionary *currency;
@property(nonatomic,strong)JXSCurrencymodel *model2;

@property(nonatomic,strong)NSDictionary *goodsExchangeRate;
@property(nonatomic,strong)JXSGoodsExchangeRatemodel *model3;

@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) NSInteger number;

@property(nonatomic,strong)NSDictionary  *parts;
@property(nonatomic,strong)JXSPartsmodel *model4;
@end
