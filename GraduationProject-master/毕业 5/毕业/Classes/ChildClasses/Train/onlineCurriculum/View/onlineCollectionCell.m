//
//  onlineCollectionCell.m
//  毕业设计
//
//  Created by 吴添培的黑苹果 on 2017/9/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "onlineCollectionCell.h"

@interface onlineCollectionCell()
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation onlineCollectionCell

-(void)setModel:(onlineModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.imgView.image = [UIImage imageNamed:model.imageName];
}

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        
        [self.contentView addSubview: _imgView];
    }
    return _imgView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.8;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    self.imgView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    CGFloat labelX = imageX;
    CGFloat labelY = imageH;
    CGFloat labelW = imageW;
    CGFloat labelH = self.bounds.size.height - imageH;
    
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}



@end
