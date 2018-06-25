//
//  JC_5_Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JC5_o_model.h"
@interface JC_5_Model : NSObject
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *chineseName;
@property(nonatomic,strong)NSString *englishName;


@property(nonatomic,strong)NSDictionary *configArea;
@property(nonatomic,strong)JC5_o_model  *model1;

@end
