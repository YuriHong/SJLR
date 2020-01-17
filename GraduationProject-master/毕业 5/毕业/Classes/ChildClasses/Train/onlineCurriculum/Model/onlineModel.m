//
//  onlineModel.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/8.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "onlineModel.h"
#import "NSMutableArray+Extension.h"


@implementation onlineModel

+ (NSMutableArray *)getModelWithArray{
    NSMutableArray *array = [NSMutableArray arrayWithPlistFileResource:@"onlineData"];
    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        onlineModel *model = [onlineModel mj_objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    
    return modelArray;
    
    
}

@end
