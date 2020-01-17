//
//  SYWLButton.m
//  毕业设计
//
//  Created by 吴添培 on 2017/7/1.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ButtonMenu.h"

@implementation ButtonMenu

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUP];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}

//按钮的初始化
- (void)setUP{
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"HYQuanTangShiJ" size:18];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)setHighlighted:(BOOL)highlighted{
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.8;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    CGFloat labelX = imageX;
    CGFloat labelY = imageH;
    CGFloat labelW = imageW;
    CGFloat labelH = self.bounds.size.height - imageH;
    
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

@end
