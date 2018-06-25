//
//  OrderListModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "configContainerModel.h"
#import "configCurrency_Model.h"
#import "PL_01_Delearinfo_Model.h"
#import "systemUserModel.h"



@interface OrderListModel : NSObject
@property(nonatomic, strong)NSString *abroadOrder;
@property(nonatomic, strong)NSString *actualDeliveryDate;
@property(nonatomic, strong)NSString *businessId;

@property(nonatomic, strong)NSDictionary *configContainer;
@property(nonatomic, strong)configContainerModel *model1;

@property(nonatomic, strong)NSDictionary *configCurrency;
@property(nonatomic, strong)configCurrency_Model *model2;




@property(nonatomic, strong)NSString *containerId;
@property(nonatomic, strong)NSString *createTime;
@property(nonatomic, strong)NSString *currencyId;
@property(nonatomic, strong)NSString *dealerId;

@property(nonatomic,strong)NSDictionary *dealerInfo;
@property(nonatomic,strong)PL_01_Delearinfo_Model *model3;



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
@property(nonatomic, strong)NSString *field11;
@property(nonatomic, strong)NSString *field12;
@property(nonatomic, strong)NSString *field13;
@property(nonatomic, strong)NSString *field14;
@property(nonatomic, strong)NSString *field15;


@property(nonatomic, strong)NSString *id;
@property(nonatomic, strong)NSString *isprocess;
@property(nonatomic, strong)NSString *loginId;
@property(nonatomic, strong)NSString *orderNo;
@property(nonatomic, strong)NSString *orderNote;
@property(nonatomic, strong)NSString *orderStatus;

@property(nonatomic, strong)NSString *orderStatusChildren;
@property(nonatomic, strong)NSString *orderTotalFee;
@property(nonatomic, strong)NSString *orderType;
@property(nonatomic, strong)NSString *paymentType;
@property(nonatomic, strong)NSString *planDeliveryDate;
@property(nonatomic, strong)NSString *productTotalFee;
@property(nonatomic, strong)NSString *queryStatus;


@property(nonatomic,strong)NSDictionary *systemUser;
@property(nonatomic,strong)systemUserModel *model4;



@property(nonatomic, strong)NSString *customOrderNo;
@property(nonatomic, strong)NSString *shipmentNo;
@end

