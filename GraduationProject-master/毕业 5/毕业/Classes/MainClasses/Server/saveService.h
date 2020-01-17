//
//  saveService.h
//  校园帮
//
//  Created by 吴添培 on 2017/7/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface saveService : NSObject
+ (void)setObject:(nullable id)value forKey:(NSString *_Nullable)defaultName;

+ (nullable id)objectForKey:(NSString *_Nonnull)defaultName;
@end
