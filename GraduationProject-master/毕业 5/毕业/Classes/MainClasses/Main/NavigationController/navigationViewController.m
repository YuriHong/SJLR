//
//  navigationViewController.m
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/7/31.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "navigationViewController.h"
#import "UIImage+Image.h"
#import "NewsViewController.h"

@interface navigationViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) id popDelegate;

@end

@implementation navigationViewController
// 什么调用:第一个次使用这个类或者它的子类的时候  initialize
+ (void)load
{
    if (self == [navigationViewController class]) {
        
        // 获取当前整个应用程序下的所有导航条的外观 UINavigationBar *navBar = [UINavigationBar appearance];
        // 获取当前类下面的导航条
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        // 设置导航条背景图片
        UIImage *image = [UIImage imageWithColor:RGBColor(5, 54, 102)];
        [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        // 设置导航条文字标题
        NSMutableDictionary *title = [NSMutableDictionary dictionary];
        title[NSFontAttributeName] = [UIFont fontWithName:@"HYQuanTangShiJ" size:20];
        title[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [[UINavigationBar appearance] setTitleTextAttributes:title];
        navBar.titleTextAttributes = title;
    }
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

//恢复滑动返回功能
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.childViewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

//重写push方法，达到设置每一个push后的viewController左边按钮为'<'，，ViewController就是下一个栈顶控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //push过后隐藏底部条  （必须是push之前隐藏）
    if (self.childViewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
    if (self.childViewControllers.count > 1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalImageName:@"navback"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
}



-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
