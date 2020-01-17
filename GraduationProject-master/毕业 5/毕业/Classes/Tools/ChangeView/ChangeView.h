//
//  ChangeControllerView.h
//  测试
//
//  Created by 吴添培的黑苹果 on 2017/10/10.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeView : UIView

@property (nonatomic, strong) NSArray *array;

- (void)setToolBarWithTintColor:(UIColor *)toolTintColor barTintColor:(UIColor *)toolBarTintColor;
- (void)setSelectedColor:(UIColor *)selectedColor;
+ (instancetype)getChangeView;


@end
