//
//  Sk3Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Moneysinemodel.h"
@interface Sk3Model : NSObject
@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSDictionary *configCurrency;

@property(nonatomic,strong)NSString *paymentNo;

@property(nonatomic,strong)NSString *totalFee;
@property(nonatomic,strong)NSString *paidFee;
@property(nonatomic,strong)NSString *differencePrice;

@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *paymentStatus;

@property(nonatomic,strong)NSString *paymentVoucher;
@property(nonatomic,strong)NSString *receiptVoucher;

@property(nonatomic,strong)NSString *rmbpaidFee;

@property(nonatomic,strong)NSString *paymentCompanyName;
@property(nonatomic,strong)NSString *paymentBankName;
@property(nonatomic,strong)NSString *paymentBankNo;

@property(nonatomic,strong)NSString *receiptBankName;
@property(nonatomic,strong)NSString *receiptBankNo;
@property(nonatomic,strong)NSString *receiptCompanyName;

@property(nonatomic,strong)NSString *transactionNo;







@property(nonatomic,strong)NSString *field6;
@property(nonatomic,strong)Moneysinemodel *model1;


@end
