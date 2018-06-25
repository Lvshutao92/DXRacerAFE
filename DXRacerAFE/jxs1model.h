//
//  jxs1model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "model1.h"
#import "model2.h"
#import "model3.h"
#import "model4.h"
#import "model5.h"


#import "configCertificateOriginmodel.h"

@interface jxs1model : NSObject



@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *companyCode;
@property(nonatomic,strong)NSString *companyName;


@property(nonatomic,strong)NSDictionary *configArea;
@property(nonatomic,strong)model1 *model1;

@property(nonatomic,strong)NSDictionary *configCountry;
@property(nonatomic,strong)model2 *model2;

@property(nonatomic,strong)NSDictionary *configCurrency;
@property(nonatomic,strong)model3 *model3;

@property(nonatomic,strong)NSDictionary *configDuration;
@property(nonatomic,strong)model4 *model4;

@property(nonatomic,strong)NSDictionary *configScale;
@property(nonatomic,strong)model5 *model5;




@property(nonatomic,strong)NSString *countryId;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *currencyId;
@property(nonatomic,strong)NSString *durationId;


@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *rememberCode;
@property(nonatomic,strong)NSString *scaleId;


@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *website;




@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *orderType;
@property(nonatomic,strong)NSString *originCertificate;
@property(nonatomic,strong)NSDictionary *configCertificateOrigin;
@property(nonatomic,strong)configCertificateOriginmodel *certificateOriginmodel;




@property(nonatomic,strong)NSString *salePoint;
@property(nonatomic,strong)NSString *url;


@end






































