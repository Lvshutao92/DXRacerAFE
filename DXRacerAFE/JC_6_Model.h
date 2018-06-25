//
//  JC_6_Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JC_06_Model.h"
@interface JC_6_Model : NSObject
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSString *portCode;
@property(nonatomic,strong)NSString *portCountryId;
@property(nonatomic,strong)NSString *portNameCn;
@property(nonatomic,strong)NSString *portNameEn;
@property(nonatomic,strong)NSString *status;






@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *field5;
@property(nonatomic,strong)NSString *field6;
@property(nonatomic,strong)NSString *field7;
@property(nonatomic,strong)NSString *field8;
@property(nonatomic,strong)NSString *field9;
@property(nonatomic,strong)NSString *field10;


@property(nonatomic,strong)NSDictionary *configCountry;
@property(nonatomic,strong)JC_06_Model  *jcmodel;
@end
