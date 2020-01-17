//
//  bootPageCollectionViewCell.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/3.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "bootPageCollectionViewCell.h"
#import "mainViewController.h"
#import "saveService.h"
#define VersionKey @"version"
@interface bootPageCollectionViewCell ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *startButton;

@end

@implementation bootPageCollectionViewCell

- (UIButton *)startButton
{
    if (_startButton == nil) {
        // 添加立即体验
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"guideButton"] forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.center = CGPointMake(self.width * 0.5, self.height * 0.85);
        [btn addTarget:self action:@selector(startVc) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _startButton = btn;
    }
    return _startButton;
}

// 点击立即体验按钮调用
- (void)startVc
{
    // 跳转之前存储当前版本号
    NSString *curVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [saveService setObject:curVersion forKey:VersionKey];
    
    // 跳转到主框架界面
    // 切换界面:push,modal,tarBarVC
    // 修改窗口的根控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = [[mainViewController alloc] init];
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    if (indexPath.item == count - 1) { // 当前cell是最后一个cell
        self.startButton.hidden = NO;
    }else{ // 如果不是最后一个cell,
        self.startButton.hidden = YES;
    }
    
}

@end
