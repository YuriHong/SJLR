//
//  menuButton.m
//  搜索下拉
//
//  Created by 吴添培 on 2017/8/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "menuButton.h"

@implementation menuButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.frame.origin.x < self.titleLabel.frame.origin.x) {
        
        //self.titleLabel.x = self.imageView.x;
        CGRect frame1 = self.titleLabel.frame;
        frame1.origin.x = self.imageView.frame.origin.x;
        self.titleLabel.frame = frame1;
        
        //self.imageView.x = self.titleLabel.maxX + 10;
        CGRect frame2 = self.imageView.frame;
        frame2.origin.x = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 10;
        self.imageView.frame = frame2;

    }
}

@end
