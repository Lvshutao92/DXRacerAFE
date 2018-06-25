//
//  MXModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "resultmodel.h"
@interface MXModel : NSObject
@property(nonatomic, strong)NSString *businessId;
@property(nonatomic, strong)NSString *currencyId;
@property(nonatomic, strong)NSString *fcno;
@property(nonatomic, strong)NSString *id;

@property(nonatomic, strong)NSString *orderId;
@property(nonatomic, strong)NSString *productCode;
@property(nonatomic, strong)NSString *productFee;
@property(nonatomic, strong)NSString *productNameCn;

@property(nonatomic, strong)NSString *productNameZh;
@property(nonatomic, strong)NSString *quantity;

@property(nonatomic, strong)NSString *field1;
@property(nonatomic, strong)NSString *field2;
@property(nonatomic, strong)NSString *field3;
@property(nonatomic, strong)NSString *field4;
@property(nonatomic, strong)NSString *field5;
@property(nonatomic, strong)NSString *field6;
@property(nonatomic, strong)NSString *field7;
@property(nonatomic, strong)NSString *field8;
@property(nonatomic, strong)NSString *field9;
@property(nonatomic, strong)NSString *field10;

@property(nonatomic, strong)NSDictionary *searchResult;
@property(nonatomic, strong)resultmodel *searchResultmodel;
@property(nonatomic, strong)NSString *unitPrice;
@end


