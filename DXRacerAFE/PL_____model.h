//
//  PL_____model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PL__1__model.h"
#import "PL___2__model.h"
#import "configCurrency_Model.h"
@interface PL_____model : NSObject


@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *orderTotalFee;
@property(nonatomic,strong)NSString *orderStatus;

@property(nonatomic,strong)NSString *planDeliveryDate;

@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)PL__1__model *model1;
@property(nonatomic,strong)NSDictionary *configContainer;
@property(nonatomic,strong)PL___2__model *model2;


@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) NSInteger number;

@property(nonatomic,strong)NSDictionary *configCurrency;
@property(nonatomic,strong)configCurrency_Model *model3;

@end
