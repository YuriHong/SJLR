//
//  LBUerNetModel.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/21.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBUerNetModel : NSObject

@property(nonatomic,copy) NSString *answer;

@property(nonatomic,copy) NSString *email;
@property (nonatomic, strong) NSNumber *id;
@property(nonatomic,copy) NSString *password;
@property (nonatomic, copy) NSString *phone;
@property(nonatomic,copy) NSString *question;
@property(nonatomic,copy) NSNumber *role;

@property(nonatomic,copy) NSString *username;

- (void)saveToFile;
+ (instancetype)getLoginUserModel;
- (void)logout;



@end
