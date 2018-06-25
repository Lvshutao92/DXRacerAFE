//
//  XHo2Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "tradeGoodsModel.h"
@interface XHo2Model : NSObject
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *dealerId;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)tradeGoodsModel *model2;


@property(nonatomic,strong)NSDictionary *tradeGoods;
@property(nonatomic,strong)tradeGoodsModel *model1;



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
@property(nonatomic,strong)NSString *dealerUseStatus;
@property(nonatomic,strong)NSString *goods;

@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *unitPrice;
@property(nonatomic,strong)NSString *useType;






@end

   
//    dealerInfo = {
//        areaId = 1;
//        businessId = 10003;
//        companyCode = E019;
//        companyName = "Kansai Soai Furniture Inc.";
//        configArea =   {
//           
//        };
//        configCountry =  {
//           
//        };
//        configCurrency = {
//           
//        };
//        configDuration ={
//           
//        };
//        configScale =   {
//            
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
//        scaleId = 1;
//        status = cooperate;
//        telephone = "81-727-94-22171";
//        website = "www.dxracer.jp";
//    };

    
    
