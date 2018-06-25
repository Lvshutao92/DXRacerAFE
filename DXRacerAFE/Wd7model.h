//
//  Wd7model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wd7_o_model.h"
@interface Wd7model : NSObject
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *dealerId;

@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *field5;
@property(nonatomic,strong)NSString *field6;
@property(nonatomic,strong)NSString *field7;
@property(nonatomic,strong)NSString *field8;
@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSString *orderType;
@property(nonatomic,strong)NSString *originCertificate;


@property(nonatomic,strong)NSDictionary *configCertificateOrigin;
@property(nonatomic,strong)Wd7_o_model  *model1;
@end
