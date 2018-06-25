//
//  WD_4_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigDutyModel.h"
@interface WD_4_model : NSObject
@property(nonatomic,strong)NSString *businessId;

@property(nonatomic,strong)NSDictionary *configDuty;
@property(nonatomic,strong)ConfigDutyModel *model1;
@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *createTime;

@property(nonatomic,strong)NSDictionary *dealerInfo;

@property(nonatomic,strong)NSString *dutyId;
@property(nonatomic,strong)NSString *email;

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


@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *person;
@property(nonatomic,strong)NSString *qq;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *wechat;

@end
