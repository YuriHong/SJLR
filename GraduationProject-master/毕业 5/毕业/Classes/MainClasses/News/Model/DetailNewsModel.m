//
//  DetailNewsModel.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/23.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailNewsModel.h"

@implementation DetailNewsModel

+ (NSMutableArray *)getDetailNewsModelArray{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailNews.plist" ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in plistArray) {
        DetailNewsModel *news = [DetailNewsModel mj_objectWithKeyValues:dict];
        [modelArray addObject:news];
    }
    return modelArray;
}


@end
