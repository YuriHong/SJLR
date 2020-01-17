//
//  GroupModel.h
//  毕业
//
//  Created by 龙波 on 2017/10/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSMutableArray *course;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)GroupModelWithDict:(NSDictionary *)dict;


@end
