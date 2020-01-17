//
//  Cover.m
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "Cover.h"

@implementation Cover

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_clickCover) {
        _clickCover();
    }
}

@end
