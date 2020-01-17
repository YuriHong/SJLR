//
//  MassBtnVIew.m
//  毕业
//
//  Created by 龙波 on 2017/11/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "MassBtnVIew.h"

@implementation MassBtnVIew

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-22, 5,80, 80)];
        imageView.image = [UIImage imageNamed:imageStr];
        [self addSubview:imageView];
        
        //
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(17, 15+65, frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
    }
    return self;
}

@end
