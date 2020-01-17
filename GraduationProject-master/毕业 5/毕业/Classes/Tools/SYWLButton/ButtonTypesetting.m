//
//  ButtonTypesetting.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ButtonTypesetting.h"
#import "ButtonMenuItem.h"

@implementation ButtonTypesetting

//添加按钮
+ (void)addBtnWithButtonClass:(Class)buttonClass buttonWH:(CGFloat)buttonWH Cloumn:(NSInteger)Cloumn withOriginY:(NSInteger)originY array:(NSArray *)array target:(id)target action:(SEL)action{
    CGFloat btnWH = buttonWH;
    NSInteger cloumn = Cloumn;
    CGFloat margin = (SCREENWIDTH - cloumn * btnWH) / (cloumn + 1);
    CGFloat x = 0;
    CGFloat y = 0;
    int curCloumn = 0;
    int curRow = 0;
    
    for(int i = 0 ;i < array.count; i++){
        //当前所在的列
        curCloumn = i % cloumn;
        //当前所在的行
        curRow = i / cloumn;
        UIButton *button = [[buttonClass alloc] init];
        x = margin + (btnWH + margin) * curCloumn;
        y =(btnWH + margin) * curRow + originY;
        button.frame = CGRectMake(x, y, btnWH, btnWH);
        ButtonMenuItem *item = array[i];
        //设置按钮图片
        [button setImage:item.image forState:UIControlStateNormal];
        //设置按钮的文字
        [button setTitle:item.title forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [target addSubview:button];
    }
}


@end
