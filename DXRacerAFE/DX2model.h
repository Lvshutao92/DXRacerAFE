//
//  DX2model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DX2detailsmodel.h"
@interface DX2model : NSObject


@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *addressCn;
@property(nonatomic,strong)NSString *addressEn;
@property(nonatomic,strong)NSString *zip;
@property(nonatomic,strong)NSString *addressType;

@property(nonatomic,strong)NSDictionary *configAddrType;
@property(nonatomic,strong)DX2detailsmodel *model1;
@end
