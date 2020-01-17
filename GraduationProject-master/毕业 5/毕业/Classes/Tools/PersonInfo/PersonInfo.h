//
//  PersonInfo.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/14.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBShareSing.h"
@interface PersonInfo : NSObject


LBSingletonH(PersonInfo)

// 登录用户ID
- (NSNumber *)getLoginUserId;
- (void)setLoginUserId:(NSNumber *)value;

// 退出登录
- (void)cleanUserToken;

@end
