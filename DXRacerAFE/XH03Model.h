//
//  XH03Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "tradeGoodsModel.h"
#import "dealeGModel.h"

@interface XH03Model : NSObject

@property(nonatomic,strong)NSString *businessId;

@property(nonatomic,strong)NSDictionary *dealerGoods;
@property(nonatomic,strong)dealeGModel *model2;





@property(nonatomic,strong)NSDictionary *tradeGoods;
@property(nonatomic,strong)tradeGoodsModel *model1;


@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *field5;

@property(nonatomic,strong)NSString *lastUpdate;
@property(nonatomic,strong)NSString *loginId;

@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *quantity;



@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) NSInteger number;


@end
