//
//  PLXHDetailsModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLXHdetails1model.h"
@interface PLXHDetailsModel : NSObject
@property(nonatomic,strong)NSString *productFee;
@property(nonatomic,strong)NSString *productCode;

@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *fcno;

@property(nonatomic,strong)NSString *productNameCn;
@property(nonatomic,strong)NSString *productNameZh;

@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *unitPrice;


@property(nonatomic,strong)NSDictionary *searchResult;
@property(nonatomic,strong)PLXHdetails1model *model1;


@end
