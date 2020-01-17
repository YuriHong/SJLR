//
//  saveService.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "saveService.h"

@implementation saveService
//存储
+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName
{
    // 有最新的版本号
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
}
//读取
+ (nullable id)objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}
@end
