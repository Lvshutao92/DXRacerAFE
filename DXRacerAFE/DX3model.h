//
//  DX3model.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DX3detailsmodel.h"
@interface DX3model : NSObject




@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *deptId;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *field1;


@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *person;
@property(nonatomic,strong)NSString *qq;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *wechat;



@property(nonatomic,strong)NSDictionary *configDept;
@property(nonatomic,strong)DX3detailsmodel *model1;










@end
