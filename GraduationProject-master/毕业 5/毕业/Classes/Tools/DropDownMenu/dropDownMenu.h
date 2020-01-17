//
//  dropDownMenu.h
//  校园帮
//
//  Created by 吴添培 on 2017/7/18.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dropDownMenu;


@protocol dropDownMenuDelegate <NSObject>

@optional

- (void)dropDownMenuWillShow:(dropDownMenu *)menu;    // 当下拉菜单将要显示时调用
- (void)dropDownMenuDidShow:(dropDownMenu *)menu;     // 当下拉菜单已经显示时调用
- (void)dropDownMenuWillHidden:(dropDownMenu *)menu;  // 当下拉菜单将要收起时调用
- (void)dropDownMenuDidHidden:(dropDownMenu *)menu;   // 当下拉菜单已经收起时调用

- (void)dropDownMenu:(dropDownMenu *)menu selectedCellNumber:(NSInteger)number; // 当选择某个选项时调用

@end

@interface dropDownMenu : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIButton * mainBtn;  // 主按钮 可以自定义样式 可在.m文件中修改默认的一些属性

@property (nonatomic, strong) NSString *btnTitle;

@property (nonatomic, weak) id <dropDownMenuDelegate>delegate;


- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight;  // 设置下拉菜单控件样式

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单



@end
