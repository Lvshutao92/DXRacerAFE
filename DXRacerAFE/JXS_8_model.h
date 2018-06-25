//
//  JXS_8_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jxs1model.h"
#import "configLogisticmodel.h"
@interface JXS_8_model : NSObject




@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *businessId;


@property(nonatomic,strong)NSString *dealerLogisticId;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *person;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *truckNumber;




@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)jxs1model *model1;

@property(nonatomic,strong)NSDictionary *configLogistic;
@property(nonatomic,strong)configLogisticmodel *model2;








@property(nonatomic,strong)NSString *bankAccount;
@property(nonatomic,strong)NSString *bankNumber;
@property(nonatomic,strong)NSString *bookingAgent;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *contactPerson;
@property(nonatomic,strong)NSString *county;

@property(nonatomic,strong)NSString *detailAddress;

@property(nonatomic,strong)NSString *mailbox;
@property(nonatomic,strong)NSString *mobilePhone;
@property(nonatomic,strong)NSString *openBank;
@property(nonatomic,strong)NSString *province;




@end
