//
//  FK1Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FK1_Order_Model.h"
@interface FK1Model : NSObject

@property (nonatomic, strong) NSString *paymentType;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *orderId;


@property (nonatomic, strong) NSString *paymentStatus;

@property (nonatomic, strong) NSString *totalFee;
@property (nonatomic, strong) NSString *ttRetainageType;
@property (nonatomic, strong) NSString *ttType;

@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *dealerId;
@property (nonatomic, strong) NSString *estimatedDate;
@property (nonatomic, strong) NSString *field1;
@property (nonatomic, strong) NSString *field2;
@property (nonatomic, strong) NSString *field3;
@property (nonatomic, strong) NSString *field4;
@property (nonatomic, strong) NSString *field5;

@property (nonatomic, strong) NSString *lcDay;


@property (nonatomic, strong) NSDictionary *order;
@property (nonatomic, strong)FK1_Order_Model *model1;


@end








   
   




