//
//  configContainerModel.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "configContainerModel.h"

@implementation configContainerModel
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"dess"]) propertyName = @"description";
    return propertyName;
}
@end
