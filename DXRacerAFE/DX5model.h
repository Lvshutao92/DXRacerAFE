//
//  DX5model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DX5_o_model.h"
@interface DX5model : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *cnName;
@property(nonatomic,strong)NSString *field1;

@property(nonatomic,strong)NSString *createtime;
@property(nonatomic,strong)NSString *enName;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *starttime;

@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSDictionary *configCertificate;
@property(nonatomic,strong)DX5_o_model *model1;
@end
