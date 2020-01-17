//
//  UIAlertController+Extention.m
//  毕业设计
//
//  Created by 吴添培的黑苹果 on 2017/9/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "UIAlertController+Extention.h"

@implementation UIAlertController (Extention)

+(void)creatDoneAndCancerAlertControllerTitle:(NSString *_Nullable)title withMessage:(NSString *_Nullable)message target:(nullable id)target callBack: (void(^_Nullable)(UIAlertAction * _Nonnull action))callBack {
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        callBack(action);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        callBack(action);
    }]];
    
    //弹出提示框；
    [target presentViewController:alert animated:true completion:nil];
}

+(void)creatDoneAlertControllerTitle:(NSString *_Nullable)title withMessage:(NSString *_Nullable)message target:(nullable id)target callBack: (void(^_Nullable)(UIAlertAction * _Nonnull action))callBack {
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        callBack(action);
    }]];
    //弹出提示框；
    [target presentViewController:alert animated:true completion:nil];
}

+(void)creatAlertControllerTitle:(NSString *_Nullable)title withMessage:(NSString *_Nullable)message target:(nullable id)target{
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        //弹出提示框；
        [target presentViewController:alert animated:true completion:nil];
}

@end
