//
//  SK2Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SK2Model : NSObject
@property(nonatomic,strong)NSString *paymentNo;

@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *totalFee;
@property(nonatomic,strong)NSString *paidFee;
@property(nonatomic,strong)NSString *differencePrice;
@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *paymentStatus;
@property(nonatomic,strong)NSString *paymentVoucher;
@property(nonatomic,strong)NSString *receiptVoucher;
@property(nonatomic,strong)NSString *receiptTime;


@property(nonatomic,strong)NSString *receiptInfo;
@property(nonatomic,strong)NSString *paymentInfo;


@property(nonatomic,strong)NSString *transactionNo;


@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSString *paymentCompanyName;
@property(nonatomic,strong)NSString *paymentBankName;
@property(nonatomic,strong)NSString *paymentBankNo;


@property(nonatomic,strong)NSString *receiptBankName;
@property(nonatomic,strong)NSString *receiptBankNo;
@property(nonatomic,strong)NSString *receiptCompanyName;
@end
