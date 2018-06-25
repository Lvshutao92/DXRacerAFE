//
//  QuestionDetails_1_Cell.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2018/1/8.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDetails_1_Cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *time;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentheight;



@end
