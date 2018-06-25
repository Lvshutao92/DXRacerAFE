//
//  SK4model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sk4OrderModel.h"
@interface SK4model : NSObject

@property(nonatomic,strong)NSString *paymentStatus;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSDictionary  *order;
@property(nonatomic,strong)Sk4OrderModel *ordermodel;




@property(nonatomic,strong)NSString  *orderId;



@end
