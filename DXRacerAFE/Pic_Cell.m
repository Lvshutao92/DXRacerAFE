//
//  Pic_Cell.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/10/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Pic_Cell.h"

@implementation Pic_Cell
- (UILabel *)label1 {
    if (_label1 == nil) {
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    }
    return _label1;
}
- (UILabel *)label2 {
    if (_label2 == nil) {
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 300, 30)];
    }
    return _label2;
}
- (UIImageView *)imageView {
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 90)];
        self.imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label1];
    }
    return self;
}
@end
