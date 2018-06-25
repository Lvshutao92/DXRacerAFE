//
//  Dx4model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dx4_con_model.h"
@interface Dx4model : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *bankAccount;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *bankNo;
@property(nonatomic,strong)NSString *field1;


@property(nonatomic,strong)NSString *swift;




@property(nonatomic,strong)NSDictionary *configCurrency;
@property(nonatomic,strong)Dx4_con_model *model1;
@end
