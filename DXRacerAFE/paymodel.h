//
//  paymodel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pay_One_model.h"
#import "Pay_Two_model.h"

#import "ConfigDutyModel.h"
#import "Conaddrmodel.h"
@interface paymodel : NSObject

@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *lcday;
@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *proportion;
@property(nonatomic,strong)NSString *retainageType;
@property(nonatomic,strong)NSString *field1;

@property(nonatomic,strong)NSDictionary  *dealerInfo;
@property(nonatomic,strong)Pay_One_model *dealerInfomodel;

@property(nonatomic,strong)NSString *dealerId;


@property(nonatomic,strong)NSString *dealerUseStatus;
@property(nonatomic,strong)NSString *goods;
@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *tradeGoods;
@property(nonatomic,strong)NSString *unitPrice;
@property(nonatomic,strong)NSString *useType;
@property(nonatomic,strong)NSString *swift;


@property(nonatomic,strong)NSString *bankAccount;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *bankNo;

@property(nonatomic,strong)NSDictionary  *configCurrency;
@property(nonatomic,strong)Pay_Two_model *configCurrencymodel;





@property(nonatomic,strong)NSDictionary  *configDuty;
@property(nonatomic,strong)ConfigDutyModel *configDutymodel;

@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *wechat;

@property(nonatomic,strong)NSString *person;
@property(nonatomic,strong)NSString *qq;





@property(nonatomic,strong)NSDictionary  *configAddrType;
@property(nonatomic,strong)Conaddrmodel *configAddrTypemodel;

@property(nonatomic,strong)NSString *receiveAddress;
@property(nonatomic,strong)NSString *receiveArea;
@property(nonatomic,strong)NSString *receiveCity;
@property(nonatomic,strong)NSString *receiveProvince;

@property(nonatomic,strong)NSString *typeId;
@property(nonatomic,strong)NSString *zip;
@end


    
