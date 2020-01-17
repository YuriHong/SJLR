//
//  AcidityBaseView.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "AcidityBaseView.h"

@implementation AcidityBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame)/3, CGRectGetHeight(self.frame) )];
        _keyLabel.backgroundColor = [UIColor clearColor];
        _keyLabel.textAlignment = NSTextAlignmentLeft;
        _keyLabel.font = [UIFont systemFontOfSize: 16];
        _keyLabel.textColor  = [UIColor blackColor];
        [self addSubview:_keyLabel];
        
        _valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/3, 0, 2*CGRectGetWidth(self.frame)/3, CGRectGetHeight(self.frame) )];
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.textAlignment = NSTextAlignmentLeft;
        _valueLabel.font = [UIFont systemFontOfSize:16];
        _valueLabel.textColor = [UIColor grayColor];
        [self addSubview:_valueLabel];
        
    }
    return self;
}

-(void)setupKey:(NSString *)key Value:(NSString *)value
{
    [_keyLabel setText:key];
    [_valueLabel setText:value];
}


@end
