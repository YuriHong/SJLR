//
//  PersonInfo.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/14.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "PersonInfo.h"

#define USER_DEFAULT_LOGIN_USER_ID @"USER_DEFAULT_LOGIN_USER_ID"

@interface PersonInfo ()

@end

@implementation PersonInfo

LBSingletonM(PersonInfo)

-(NSNumber *)getLoginUserId
{
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_LOGIN_USER_ID];
    return value;
}

- (void)setLoginUserId:(NSNumber *)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:USER_DEFAULT_LOGIN_USER_ID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)cleanUserToken {
   // [UerNetModel getLoginUserModel].jwt = @"";
      [self setLoginUserId:@0];
}


@end
