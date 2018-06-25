//
//  ModelOne.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model01.h"
#import "Model02.h"
#import "tradeGoodsModel.h"
@interface ModelOne : NSObject

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)tradeGoodsModel *dealerInfoModel;


@property(nonatomic,strong)NSDictionary *goods;
@property(nonatomic,strong)Model02 *goodsModel;



@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *field5;
@property(nonatomic,strong)NSString *field6;
@property(nonatomic,strong)NSString *field7;
@property(nonatomic,strong)NSString *field8;
@property(nonatomic,strong)NSString *field9;
@property(nonatomic,strong)NSString *field10;



@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *tradeGoods;
@property(nonatomic,strong)NSString *unitPrice;
@property(nonatomic,strong)NSString *useType;
@end
