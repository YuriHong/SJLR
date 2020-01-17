//
//  LbListImageVIew.m
//  test_product
//
//  Created by 龙波 on 2017/11/6.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "LbListImageVIew.h"
#import "UIView+SYWLExtension.h"
#import "LbListImageVIew.h"
#import "JLPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kStatusImageWidth 170
#define kStatusImageHeight 150
#define kStatusImageMargin 10

@interface LbListImageVIew()
/**
 *  imageViews
 */
@property (nonatomic,strong) NSMutableArray *imageViews;
/**
 *  URL数组
 */

@property(nonatomic,strong) NSArray *imageUrl;

@end

@implementation LbListImageVIew

-(NSMutableArray *)imageViews{
    
    if (_imageViews==nil) {
        
        _imageViews = [NSMutableArray array];
        
    }
    
    return _imageViews;
    
}


- (instancetype)initWithFrame:(CGRect)frame WithData:(NSString *)imageUrlData
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.创建子视图
        [self initData:imageUrlData];
        [self setupImageViews];
        
    }
    return self;
}
//处理传过来的imageS字符串
- (void)initData:(NSString *)imageUrlData
{
    NSString *str =  imageUrlData;
    NSArray *array = [str componentsSeparatedByString:@"\\"];
    NSMutableArray *imageUrlArrayName =[array mutableCopy];
    [imageUrlArrayName removeObjectAtIndex:0];
    NSMutableArray *imageUrlArray =[NSMutableArray array];
    [imageUrlArray removeAllObjects];
    for (int i = 0; i < imageUrlArrayName.count; i++) {
        NSString *urlStr = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",imageUrlArrayName[i]];
        [imageUrlArray addObject:urlStr];
        
    }
    
    NSLog(@"%@",imageUrlArray);
    _imageUrl =imageUrlArray;
}

#pragma mark 创建子视图

-(void)setupImageViews{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 80)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.showsHorizontalScrollIndicator = NO; // 水平方向
    mainView.showsVerticalScrollIndicator = NO; // 垂直方向
    [self addSubview:mainView];
    
    for (int i = 0; i<_imageUrl.count;  i++) {
        
        //1.创建imageView
        UIImageView *child = [[UIImageView alloc] init];
        child.userInteractionEnabled = YES;
        [child sd_setImageWithURL:_imageUrl[i]];
    
     //   child.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        child.clipsToBounds = YES;
        child.contentMode = UIViewContentModeScaleAspectFill;
        child.tag = i;
        
        //2.添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [child addGestureRecognizer:tap];
        
        //3.设置frame
        // 3.1 列数
        int column = i%2;
        // 3.2 行数
        int row = i/2;
        // 3.3 很据列数和行数算出x、y
        int childX = column * (kStatusImageWidth + kStatusImageMargin);
        int childY = row * (kStatusImageHeight + kStatusImageMargin);
        child.frame = CGRectMake(childX+25, childY+5, kStatusImageWidth, kStatusImageHeight);
        mainView.contentSize = CGSizeMake(0,child.bottomY+20+64);

        [mainView addSubview:child];
        
        [self.imageViews addObject:child];
        
    }
    
}

#pragma mark 图片点击

-(void)imageTap:(UITapGestureRecognizer *)tap{
    
    //1.创建JLPhoto数组
    NSMutableArray *photos = [NSMutableArray array];
    
    for (int i=0; i<self.imageViews.count; i++) {
        
        UIImageView *child = self.imageViews[i];
        JLPhoto *photo = [[JLPhoto alloc] init];
        //1.1设置原始imageView
        photo.sourceImageView = child;
        //1.2设置大图URL
        photo.bigImgUrl = self.imageUrl[i];
        //1.3设置图片tag
        photo.tag = i;
        [photos addObject:photo];
        
    }
    
    //2. 创建图片浏览器
    JLPhotoBrowser *photoBrowser = [JLPhotoBrowser photoBrowser];
    //2.1 设置JLPhoto数组
    photoBrowser.photos = photos;
    //2.2 设置当前要显示图片的tag
    photoBrowser.currentIndex = (int)tap.view.tag;
    //2.3 显示图片浏览器
    [photoBrowser show];
}
@end
