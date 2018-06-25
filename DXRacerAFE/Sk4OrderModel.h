//
//  Sk4OrderModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SK4_dealer_model.h"

@interface Sk4OrderModel : NSObject
@property(nonatomic,strong)NSString *orderNo;

@property(nonatomic,strong)NSString *productTotalFee;

@property(nonatomic,strong)NSString *orderType;
@property(nonatomic,strong)NSString *orderStatus;

@property(nonatomic,strong)NSString *dealerId;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)SK4_dealer_model *dealermodel;









@end
