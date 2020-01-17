//
//  LBMacro.h
//  毕业设计
//
//  Created by 龙波 on 2017/8/23.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#ifndef LBMacro_h
#define LBMacro_h
//屏幕宽高
#define SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT      [UIScreen mainScreen].bounds.size.height

//颜色
#define RGBColor(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define RGBAColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A/1.0]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//Objective-C.gitignore
#import "PersonInfo.h"
#import "BiFileUtil.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

//网络请求
#import "NetworkTool.h"

//部分分类
#import "UIView+SYWLExtension.h"
#import "UIAlertController+Extention.h"

#endif /* LBMacro_h */
