//
//  Wd8model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "wd8_o_model.h"
#import "jxs1model.h"
@interface Wd8model : NSObject




@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *certificationTypeId;
@property(nonatomic,strong)NSDictionary *configCertificate;
@property(nonatomic,strong)wd8_o_model *model1;

@property(nonatomic,strong)NSString *dealerId;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)jxs1model *companymodel;

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
@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSString *filePath;
@property(nonatomic,strong)NSString *uploadTime;


@end
