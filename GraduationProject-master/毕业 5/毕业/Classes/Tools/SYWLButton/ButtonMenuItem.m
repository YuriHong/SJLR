//
//  SYWLMenuItem.m
//  毕业设计
//
//  Created by 吴添培 on 2017/7/1.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ButtonMenuItem.h"

@implementation ButtonMenuItem
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image{
    
    ButtonMenuItem *item = [[self alloc] init];
    item.title = title;
    item.image = image;
    
    return item;
}

@end
