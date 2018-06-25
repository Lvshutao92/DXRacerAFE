//
//  LMJDropdownMenu.h
//  改过公告 很多功夫皇帝
//
//  Created by ilovedxracer on 2017/9/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//
#import <UIKit/UIKit.h>

@class LMJDropdownMenu;




@protocol LMJDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu;    // 当下拉菜单将要显示时调用
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu;     // 当下拉菜单已经显示时调用
- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu;  // 当下拉菜单将要收起时调用
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu;   // 当下拉菜单已经收起时调用

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number titleString:(NSString *)title; // 当选择某个选项时调用

@end




@interface LMJDropdownMenu : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIButton * mainBtn;  // 主按钮 可以自定义样式 可在.m文件中修改默认的一些属性

@property (nonatomic, assign) id <LMJDropdownMenuDelegate>delegate;


- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight;  // 设置下拉菜单控件样式

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单



@property (nonatomic,strong) NSString * title;
@end
