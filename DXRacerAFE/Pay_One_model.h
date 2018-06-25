//
//  Pay_One_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "configArea_Model.h"
#import "configCountry_Model.h"
@interface Pay_One_model : NSObject
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *companyCode;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *areaId;


@property(nonatomic,strong)NSDictionary *configCurrency;
@property(nonatomic,strong)NSDictionary *configDuration;
@property(nonatomic,strong)NSDictionary *configScale;



@property(nonatomic,strong)NSString *countryId;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *currencyId;
@property(nonatomic,strong)NSString *durationId;


@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *field10;
@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;


@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *field5;
@property(nonatomic,strong)NSString *field6;
@property(nonatomic,strong)NSString *field7;


@property(nonatomic,strong)NSString *field8;
@property(nonatomic,strong)NSString *field9;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *rememberCode;

@property(nonatomic,strong)NSString *scaleId;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *website;




@property(nonatomic,strong)NSDictionary  *configArea;
@property(nonatomic,strong)configArea_Model *configAreamodel;

@property(nonatomic,strong)NSDictionary  *configCountry;
@property(nonatomic,strong)configCountry_Model *configCountrymodel;
@end
