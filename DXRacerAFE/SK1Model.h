//
//  SK1Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SK1Model : NSObject

@property(nonatomic,strong)NSString *business_id;

@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *currency;
@property(nonatomic,strong)NSString *currency_id;
@property(nonatomic,strong)NSString *dealer_id;
@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *order_no;
@property(nonatomic,strong)NSString *order_status;
@property(nonatomic,strong)NSString *order_type;
@property(nonatomic,strong)NSString *total_fee;


@property(nonatomic,strong)NSString *estimated_date;

@end
