//
//  JXS_12_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jxs1model.h"
#import "systemRoleModel.h"

@interface JXS_12_model : NSObject
@property(nonatomic,strong)NSDictionary *systemRole;
@property(nonatomic,strong)systemRoleModel *rolemodel;

@property(nonatomic,strong)NSDictionary *configInstruct;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)jxs1model *dealerInfomodel;

@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *username;

@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *businessId;






@end
