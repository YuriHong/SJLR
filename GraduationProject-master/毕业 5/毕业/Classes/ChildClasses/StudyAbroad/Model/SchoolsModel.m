//
//  SchoolsModel.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/30.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SchoolsModel.h"
#import "NSMutableArray+Extension.h"

@implementation SchoolsModel

+(NSMutableArray *)getSchoolsModelArray{
    NSMutableArray *array = [NSMutableArray arrayWithPlistFileResource:@"schools"];
    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        SchoolsModel *model = [SchoolsModel mj_objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

@end
