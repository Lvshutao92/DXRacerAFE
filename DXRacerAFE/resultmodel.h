//
//  resultmodel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/9.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resultmodel : NSObject
@property(nonatomic,strong)NSString *chineseName;
@property(nonatomic,strong)NSString *englishName;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *product;


@property(nonatomic,strong)NSString *logisticName;


@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSString *currencyPoint;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *totalFee;

@end
