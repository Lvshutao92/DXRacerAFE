//
//  PLXHPaymentModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLXHPaymentModel : NSObject
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *paymentStatus;
@property(nonatomic,strong)NSString *totalFee;
@property(nonatomic,strong)NSString *ttType;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *estimatedDate;
@end

