//
//  QuestionDetailsCell.h
//  DXRacerAFE
//
//  Created by ilovedxracer on 2018/1/8.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *answerContent;
@property (weak, nonatomic) IBOutlet UILabel *answerTime;





@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgtop;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *namelabHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerContentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answercontentTop;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answertimeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answertimeTop;


@end
