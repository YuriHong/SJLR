//
//  InstDetailModel.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/28.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstDetailModel.h"
#import "NSMutableArray+Extension.h"

@implementation InstDetailModel

+(NSMutableArray *)getInstDetailModelArray{
    NSMutableArray *array = [NSMutableArray arrayWithPlistFileResource:@"AllInst"];
    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        InstDetailModel *model = [InstDetailModel mj_objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

@end
