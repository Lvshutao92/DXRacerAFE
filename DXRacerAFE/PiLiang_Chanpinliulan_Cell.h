//
//  PiLiang_Chanpinliulan_Cell.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiLiang_Chanpinliulan_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;


@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *lab4;

@property (weak, nonatomic) IBOutlet UILabel *lab5;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgtop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab1height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab2height;




@end
