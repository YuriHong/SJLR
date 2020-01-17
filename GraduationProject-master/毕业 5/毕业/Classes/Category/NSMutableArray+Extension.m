//
//  NSMutableArray+Extension.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NSMutableArray+Extension.h"

@implementation NSMutableArray (Extension)

+ (NSMutableArray *)arrayWithPlistFileResource:(NSString *)resource{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    return array;
}

@end
