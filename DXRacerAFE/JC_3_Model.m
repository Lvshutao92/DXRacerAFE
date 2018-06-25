//
//  JC_3_Model.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JC_3_Model.h"

@implementation JC_3_Model
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"dess"]) propertyName = @"description";
    return propertyName;
}
@end
