//
//  kkfp_1_model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/29.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "searchResultmodel.h"


@interface kkfp_1_model : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSDictionary *searchResult;
@property(nonatomic,strong)searchResultmodel *model1;

@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *productNameCn;
@property(nonatomic,strong)NSString *productNameZh;

@property(nonatomic,strong)NSString *productFee;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *unitPrice;





@end
