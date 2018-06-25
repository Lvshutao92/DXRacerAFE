//
//  LookTextViewController.m
//  DXRacerAFE
//
//  Created by ilovedxracer on 2017/9/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LookTextViewController.h"

@interface LookTextViewController ()<UITextViewDelegate>
{
    UITextView *textView;
}
@end

@implementation LookTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-70, SCREEN_HEIGHT-20)];
    textView.delegate = self;
    textView.text = self.contentStr;
    [self.view addSubview:textView];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


@end
