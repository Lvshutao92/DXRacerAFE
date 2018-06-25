//
//  Wd_6_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wd6_con_model.h"
@interface Wd_6_model : NSObject


@property(nonatomic,strong)NSString *currencyId;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *bankNo;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *bankAccount;



@property(nonatomic,strong)NSString *id;
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
@property(nonatomic,strong)NSString *swift;



@property(nonatomic,strong)NSString *dealerId;


@property(nonatomic,strong)NSDictionary *configCurrency;
@property(nonatomic,strong)Wd6_con_model *model1;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@end




//dealerInfo =                 {
//    areaId = 1;
//    businessId = 10003;
//    companyCode = E019;
//    companyName = "Kansai Soai Furniture Inc.";
//    configArea =                     {
//        businessId = 10003;
//        chineseName = "\U4e1c\U5357\U4e9a";
//        englishName = "South East Asia";
//        id = 1;
//    };
//    configCountry =                     {
//        areaId = 1;
//        businessId = 10003;
//        chineseName = "\U9a6c\U6765\U897f\U4e9a";
//        englishName = "Malaysia ";
//        id = 35;
//    };
//    configCurrency =                     {
//        businessId = 10003;
//        currencyCode = RMB;
//        currencyName = "\U4eba\U6c11\U5e01";
//        field1 = "\Uffe5";
//        field10 = "<null>";
//        field2 = "<null>";
//        field3 = "<null>";
//        field4 = "<null>";
//        field5 = "<null>";
//        field6 = "<null>";
//        field7 = "<null>";
//        field8 = "<null>";
//        field9 = "<null>";
//        id = 1;
//    };
//    configDuration =                     {
//        businessId = 10003;
//        id = 2;
//        nameCn = "3-5\U5e74";
//        nameEn = "Three to five years";
//    };
//    configScale =                     {
//        businessId = 10003;
//        id = 2;
//        nameCn = "50-100\U4eba";
//        nameEn = "Between 50 and 100";
//    };
//    countryId = 35;
//    createTime = 1501489323000;
//    currencyId = 1;
//    durationId = 2;
//    field1 = "<null>";
//    field10 = "<null>";
//    field2 = "<null>";
//    field3 = "<null>";
//    field4 = "<null>";
//    field5 = "<null>";
//    field6 = "<null>";
//    field7 = "<null>";
//    field8 = 1501489323000;
//    field9 = "<null>";
//    id = 11;
//    rememberCode = E019;
//    scaleId = 2;
//    status = cooperate;
//    telephone = 18552026537;
//    website = "www.dxracer.jp";
//};
