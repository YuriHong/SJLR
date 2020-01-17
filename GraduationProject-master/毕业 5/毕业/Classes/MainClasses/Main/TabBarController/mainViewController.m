//
//  mainViewController.m
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/7/31.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "mainViewController.h"
#import "navigationViewController.h"
#import "homePageViewController.h"
#import "MassViewController.h"
#import "NewsViewController.h"
#import "PersonController.h"
#import "UIImage+Image.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBarTintColor:RGBColor(5, 54, 102)];
    [self setChildView];
}

//该类或其子类只支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void)setChildView{
    homePageViewController *firstVc = [[homePageViewController alloc]init];
    [self setOneChildViewController:firstVc addImage:@"tabbar_home" addTitle:@"首页"];
    
    NewsViewController *secondVc = [[NewsViewController alloc]init];
    [self setOneChildViewController:secondVc addImage:@"tabbar_new" addTitle:@"新闻"];
    
    MassViewController *thirdVc = [[MassViewController alloc]init];
    [self setOneChildViewController:thirdVc addImage:@"tabbar_corporation" addTitle:@"社团"];
    
    PersonController *fourVc = [[PersonController alloc]init];
    [self setOneChildViewController:fourVc addImage:@"tabbar_profile" addTitle:@"我" ];
    
}

-(void)setOneChildViewController:(UIViewController *)vc addImage:(NSString *)imageName addTitle:(NSString *)title{
    vc.title = title;
    self.tabBar.tintColor = [UIColor orangeColor];
    
    navigationViewController  *nav = [[navigationViewController alloc]initWithRootViewController:vc];
    nav.tabBarItem.image = [UIImage imageWithOriginalImageName:imageName];
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:[NSString stringWithFormat:@"%@_highlighted",imageName]];
    
    [self addChildViewController:nav];
}




@end
