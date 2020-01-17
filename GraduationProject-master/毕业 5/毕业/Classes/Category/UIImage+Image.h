//
//  UIImage+Image.h
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/8/8.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// 给定一个最原始的图片名称生成一个原始的图片(防止被渲染)
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
