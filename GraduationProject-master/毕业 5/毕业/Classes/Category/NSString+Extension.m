//
//  NSString+byte.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extention)

+(NSUInteger)getByteString:(NSString *)str{
    NSUInteger characterLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0, l = [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i < l; i++) {
        if (*p) {
            characterLength++;
        }
        p++;
    }
    return characterLength;
}

+(NSString *)concatenationImageString:(NSString *)string{
    NSString *urlString = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",string];
    return urlString;
}

@end
