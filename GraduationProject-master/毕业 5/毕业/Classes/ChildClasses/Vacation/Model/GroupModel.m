//
//  GroupModel.m
//  毕业
//
//  Created by 龙波 on 2017/10/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.course = dict[@"course"];
    }
    return self;
}

+ (instancetype)GroupModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}




@end
