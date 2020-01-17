//
//  guideService.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "guideService.h"

#define VersionKey @"version"
#import "BootPageViewController.h"
#import "loginViewController.h"
#import "saveService.h"
#import "mainViewController.h"

@implementation guideService

+ (UIViewController *)chooseWindowRootViewController
{
    // 定义一个窗口的根控制器
    UIViewController *rootVc = nil;
    
    //   获取当前的最新版本号
    NSString *curVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 获取上一次的版本号
    NSString *oldVersion = [saveService objectForKey:VersionKey];
    
    if ([curVersion isEqualToString:oldVersion] == NO) {
        //存储最新版本，并且进入引导页
        //若在引导界面退出程序，则第二次运行不会进入引导页（突然有事，没看引导）
        //所以将存储版本号移动到点击立即体验按钮执行跳转界面的方法中
        //[saveService setObject:curVersion forKey:VersionKey];
        
        BootPageViewController *bootPage = [[BootPageViewController alloc] init];
        
        rootVc = bootPage;
        
    }else{ // 没有最新的版本号
        // 进入登录界面
        mainViewController *main = [[mainViewController alloc] init];
        rootVc = main;
        
        NSString *name = [saveService objectForKey:@"name"];
        NSString *pwd  = [saveService objectForKey:@"pwd"];
        if (name != NULL) {
            NSString *urlString = [NetworkTool willConcatenationString:@"/user/login.do"];
            NSDictionary *params = @{@"username": name,
                                     @"password": pwd  };
            [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {}];
        }
        

        
    }
    return rootVc;
 
}
 


@end
