//
//  JXSGoodsExchangeRatemodel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXSGoodsExchangeRatemodel : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *fromCurrency;
@property(nonatomic,strong)NSString *toCurrency;
@property(nonatomic,strong)NSString *rate;
@end
