//
//  DizhiModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DizhiModel : NSObject
@property(nonatomic,strong)NSString *business_id;
@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *currency_id;
@property(nonatomic,strong)NSString *currency_point;

@property(nonatomic,strong)NSString *dealer_id;
@property(nonatomic,strong)NSString *dealer_use_status;
@property(nonatomic,strong)NSString *fcno;
@property(nonatomic,strong)NSString *fcno_name_chinese;

@property(nonatomic,strong)NSString *fcno_name_english;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *itemno;

@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *unit_price;
@property(nonatomic,strong)NSString *use_type;
@end
