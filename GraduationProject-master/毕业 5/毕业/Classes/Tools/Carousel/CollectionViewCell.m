//
//  CollectionViewCell.m
//  测试轮播器
//
//  Created by 吴添培 on 2017/6/27.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation CollectionViewCell

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

@end
