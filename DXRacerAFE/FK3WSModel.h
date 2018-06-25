//
//  FK3WSModel.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/14.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FK3WS_Data_model.h"
#import "FK3WS_Arr1_model.h"
#import "FK3WS_Arr2_model.h"


@interface FK3WSModel : NSObject


@property(nonatomic,strong)NSString *paymentInformationId;



@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)FK3WS_Data_model *datamodel;



@property(nonatomic,strong)NSArray *configBankList;

@property(nonatomic,strong)NSArray *dealerBankList;



@end




