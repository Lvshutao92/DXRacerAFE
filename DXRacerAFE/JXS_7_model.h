//
//  JXS_7_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jxs1model.h"
@interface JXS_7_model : NSObject




@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *bankAccount;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *payerCode;
@property(nonatomic,strong)NSString *telephone;


@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)jxs1model *model1;




@end
