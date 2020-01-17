//
//  UIAlertController+Extention.h
//  毕业设计
//
//  Created by 吴添培的黑苹果 on 2017/9/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extention)

+ (void)creatDoneAndCancerAlertControllerTitle:(NSString *_Nullable)title withMessage:(NSString *_Nullable)message target:(nullable id)target callBack: (void(^_Nullable)(UIAlertAction * _Nonnull action))callBack;

+(void)creatDoneAlertControllerTitle:(NSString *_Nullable)title withMessage:(NSString *_Nullable)message target:(nullable id)target callBack: (void(^_Nullable)(UIAlertAction * _Nonnull action))callBack;

+(void)creatAlertControllerTitle:(NSString *_Nullable)title withMessage:(NSString *_Nullable)message target:(nullable id)target;

@end
