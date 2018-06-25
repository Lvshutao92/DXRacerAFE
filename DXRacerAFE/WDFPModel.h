//
//  WDFPModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ordermodel.h"
@interface WDFPModel : NSObject

@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *bankNo;

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *currencyId;


@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *invoiceCode;

@property(nonatomic,strong)NSString *invoiceNo;
@property(nonatomic,strong)NSString *invoiceNumber;
@property(nonatomic,strong)NSString *invoiceStatus;

@property(nonatomic,strong)NSString *invoiceType;
@property(nonatomic,strong)NSString *logisticName;
@property(nonatomic,strong)NSString *logisticsNo;


@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *postage;




@property(nonatomic,strong)NSString *receiveArea;
@property(nonatomic,strong)NSString *receiveCity;
@property(nonatomic,strong)NSString *receiveProvince;
@property(nonatomic,strong)NSString *zip;



@property(nonatomic,strong)NSString *receiveAddress;
@property(nonatomic,strong)NSString *receivePerson;
@property(nonatomic,strong)NSString *telephone;


@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *totalFee;
@property(nonatomic,strong)NSString *zipcode;


@property(nonatomic,strong)NSDictionary *configCurrency;

@property(nonatomic,strong)NSDictionary *dealerInfo;

@property(nonatomic,strong)NSDictionary *order;
@property(nonatomic,strong)Ordermodel *ordermodel;













@end






