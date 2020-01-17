//
//  AllImageController.m
//  test_product
//
//  Created by 龙波 on 2017/11/6.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "AllImageController.h"
#import <SDImageCache.h>
#import "SDWebImageManager.h"
#import "LbListImageVIew.h"
//屏幕宽高
#define SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT      [UIScreen mainScreen].bounds.size.height


@interface AllImageController ()

@end

@implementation AllImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LbListImageVIew *imageListView = [[LbListImageVIew alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)WithData:self.imageUrlArray];
    [self.view addSubview:imageListView];

}




@end
