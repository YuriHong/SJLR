//
//  AllCourse.h
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface menuModel : NSObject

@property(nonatomic,copy)NSString *firstName;
@property(nonatomic,strong)NSArray *secondMenu;

+ (NSMutableArray *)getMenuMessageWithPlistResource:(NSString *)resource;

@end
