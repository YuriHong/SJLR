//
//  AppDelegate.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/9/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "AppDelegate.h"
#import "guideService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [guideService chooseWindowRootViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
