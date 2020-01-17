//
//  AllCourse.m
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "menuModel.h"
#import "NSMutableArray+Extension.h"

@implementation menuModel

+ (NSMutableArray *)getMenuMessageWithPlistResource:(NSString *)resource{
    NSMutableArray *array = [NSMutableArray arrayWithPlistFileResource:resource];
    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        menuModel *Model = [[menuModel alloc]init];
        Model.firstName = [dict objectForKey:@"firstName"];
        Model.secondMenu = [dict objectForKey:@"secondMenu"];
        [modelArray addObject:Model];
    }
    
    return modelArray;
}

@end
