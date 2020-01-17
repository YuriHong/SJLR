//
//  SYWLMenuItem.h
//  毕业设计
//
//  Created by 吴添培 on 2017/7/1.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ButtonMenuItem : NSObject
//图片
@property (nonatomic, strong) UIImage *image;
//标题
@property (nonatomic, strong) NSString *title;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
