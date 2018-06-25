//
//  WD3AddressModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WD3Address_addrlx_model.h"
#import "WD3address_con_model.h"
@interface WD3AddressModel : NSObject





@property(nonatomic,strong)NSString *receiveProvince;
@property(nonatomic,strong)NSString *receiveCity;
@property(nonatomic,strong)NSString *receiveArea;
@property(nonatomic,strong)NSString *receiveAddress;
@property(nonatomic,strong)NSString *zip;
@property(nonatomic,strong)NSString *id;



@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *countryId;
@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *typeId;


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


@property(nonatomic,strong)NSDictionary *configAddrType;
@property(nonatomic,strong)WD3Address_addrlx_model *model1;

@property(nonatomic,strong)NSDictionary *configCountry;
@property(nonatomic,strong)WD3address_con_model *model2;
@end

   
//    configAddrType =                 {
//        businessId = 10003;
//        id = 1;
//        typeCn = "\U6ce8\U518c\U5730\U5740";
//        typeEn = "Registered address";
//    };
//    configArea =                 {
//        businessId = 10003;
//        chineseName = "\U4e9a\U6d32";
//        englishName = Asia;
//        id = 6;
//    };
//    configCountry =                 {
//        areaId = 2;
//        businessId = 10003;
//        chineseName = "\U52a0\U62ff\U5927";
//        englishName = Canada;
//        id = 4;
//    };
//    dealerInfo =                 {
//        areaId = 1;
//        businessId = 10003;
//        companyCode = E019;
//        companyName = "Kansai Soai Furniture Inc.";
//        configArea =                     {
//            businessId = 10003;
//            chineseName = "\U4e1c\U5357\U4e9a";
//            englishName = "South East Asia";
//            id = 1;
//        };
//        configCountry =                     {
//            areaId = 1;
//            businessId = 10003;
//            chineseName = "\U9a6c\U6765\U897f\U4e9a";
//            englishName = "Malaysia ";
//            id = 35;
//        };
//        configCurrency =                     {
//            businessId = 10003;
//            currencyCode = RMB;
//            currencyName = "\U4eba\U6c11\U5e01";
//            field1 = "\Uffe5";
//            field10 = "<null>";
//            field2 = "<null>";
//            field3 = "<null>";
//            field4 = "<null>";
//            field5 = "<null>";
//            field6 = "<null>";
//            field7 = "<null>";
//            field8 = "<null>";
//            field9 = "<null>";
//            id = 1;
//        };
//        configDuration =                     {
//            businessId = 10003;
//            id = 2;
//            nameCn = "3-5\U5e74";
//            nameEn = "Three to five years";
//        };
//        configScale =                     {
//            businessId = 10003;
//            id = 2;
//            nameCn = "50-100\U4eba";
//            nameEn = "Between 50 and 100";
//        };
//        countryId = 35;
//        createTime = 1501489323000;
//        currencyId = 1;
//        durationId = 2;
//        field1 = "<null>";
//        field10 = "<null>";
//        field2 = "<null>";
//        field3 = "<null>";
//        field4 = "<null>";
//        field5 = "<null>";
//        field6 = "<null>";
//        field7 = "<null>";
//        field8 = 1501489323000;
//        field9 = "<null>";
//        id = 11;
//        rememberCode = E019;
//        scaleId = 2;
//        status = cooperate;
//        telephone = 111111111;
//        website = "www.dxracer.jp";
//    };

    
