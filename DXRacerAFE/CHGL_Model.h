//
//  CHGL_Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/9.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "resultmodel.h"
@interface CHGL_Model : NSObject
@property(nonatomic,strong)NSString *actualDate;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *dealerId;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *logistics;


@property(nonatomic,strong)NSString *planShipmentDate;
@property(nonatomic,strong)NSString *shipmentNo;
@property(nonatomic,strong)NSString *shipmentPicture;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *type;

@property(nonatomic,strong)NSString *currency_point;
@property(nonatomic,strong)NSString *order_no;
@property(nonatomic,strong)NSString *order_status;
@property(nonatomic,strong)NSString *plan_delivery_date;
@property(nonatomic,strong)NSString *product_total_fee;

@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) NSInteger number;





@property(nonatomic,strong)NSString *fcno;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *productFee;
@property(nonatomic,strong)NSString *productNameCn;
@property(nonatomic,strong)NSString *productNameZh;
@property(nonatomic,strong)NSString *searchOrderNo;
@property(nonatomic,strong)NSString *unitPrice;

@property(nonatomic,strong)NSDictionary *searchResult;
@property(nonatomic,strong)resultmodel  *searchResultmodel;




@property(nonatomic,strong)NSString *receiveAddress;
@property(nonatomic,strong)NSString *receiveArea;
@property(nonatomic,strong)NSString *receiveCity;
@property(nonatomic,strong)NSString *receiveProvince;
@property(nonatomic,strong)NSString *zip;
@property(nonatomic,strong)NSDictionary *configLogistic;
@property(nonatomic,strong)resultmodel  *configLogisticmodel;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *person;





@property(nonatomic,strong)NSDictionary *orderList;
@property(nonatomic,strong)resultmodel  *orderListmodel;

@property(nonatomic,strong)NSDictionary *paymentList;
@property(nonatomic,strong)resultmodel  *paymentListmodel;
@end
