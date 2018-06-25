//
//  WDWT_Cell.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDWT_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;



@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UIImageView *img;





@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab1right;


@property (weak, nonatomic) IBOutlet UIButton *btn2;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab3width;

@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@end
