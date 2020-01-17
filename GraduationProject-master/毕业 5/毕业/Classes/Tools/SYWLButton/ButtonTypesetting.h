//
//  ButtonTypesetting.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonTypesetting : UIButton

+ (void)addBtnWithButtonClass:(Class)buttonClass buttonWH:(CGFloat)buttonWH Cloumn:(NSInteger)Cloumn withOriginY:(NSInteger)originY array:(NSArray *)array target:(id)target action:(SEL)action;

@end
