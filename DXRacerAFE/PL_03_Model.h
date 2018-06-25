//
//  PL_03_Model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartModel.h"
@interface PL_03_Model : NSObject
@property(nonatomic,strong)NSString *currencyType;
@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSString *fcno;
@property(nonatomic,strong)NSString *hsCode;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *itemno;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *unitPrice;
@property(nonatomic,strong)NSString *vol;
@property(nonatomic,strong)NSString *weight;




@property(nonatomic,strong)NSDictionary *cart;
@property(nonatomic,strong)CartModel    *cartmodel;

@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) NSInteger number;
@end
