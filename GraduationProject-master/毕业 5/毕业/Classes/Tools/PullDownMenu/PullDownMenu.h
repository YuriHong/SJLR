//
//  PullDownMenu.h
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullDownMenu;

//下拉菜单数据源协议
@protocol PullDownMenuDataSource <NSObject>

//下拉菜单有多少列
- (NSInteger)numberOfColsInMenu:(PullDownMenu *)pullDownMenu;

//下拉菜单每列按钮外观
- (UIButton *)pullDownMenu:(PullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index;

//下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(PullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index;

//下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(PullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index;

@end

extern NSString * const UpdateMenuTitleNote;

@protocol PullDownMenuDelegate <NSObject>

-(void)PullDownMenuWithStr:(NSString *)str;

@end

@interface PullDownMenu : UIView

@property (nonatomic, weak) id<PullDownMenuDelegate> delegate;

//下拉菜单数据源
@property (nonatomic, weak) id<PullDownMenuDataSource> dataSource;

//分割线颜色
@property (nonatomic, strong) UIColor *separateLineColor;

//分割线距离顶部间距，默认10
@property (nonatomic, assign) NSInteger separateLineTopMargin;

//蒙版颜色
@property (nonatomic, strong) UIColor *coverColor;

//刷新下拉菜单
- (void)reload;

@end
