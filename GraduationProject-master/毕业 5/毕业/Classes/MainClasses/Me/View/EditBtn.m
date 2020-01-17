//
//  EditBtn.m
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "EditBtn.h"

@implementation EditBtn



-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        _keyLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.frame)/5,CGRectGetHeight(self.frame) )];
        _keyLable.backgroundColor = [UIColor clearColor];
        _keyLable.textAlignment =NSTextAlignmentLeft;
        _keyLable.font = [UIFont systemFontOfSize:16];
        _keyLable.textColor = [UIColor blackColor];
        [self addSubview:_keyLable];
        
        _valueLable =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2, 0, CGRectGetWidth(self.frame)/2-15,CGRectGetHeight(self.frame) )];
        _valueLable.backgroundColor = [UIColor clearColor];
//        [_valueLable setTintColor:[UIColor blackColor]];
        [_valueLable setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_valueLable setBackgroundColor:[UIColor clearColor]];
        _valueLable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _valueLable.enabled = NO;
        [self addSubview:_valueLable];
        
        
    }
    return  self;
}

- (void)setUpKey:(NSString *)key image:(UIImage *)image
{
    NSString *icon = @"修改头像";

    if (key == icon) {
        [_keyLable setText:key];
        _valueLable.frame = CGRectMake(CGRectGetWidth(self.frame)-60, 0, 60, 60) ;
        [_valueLable setImage:image forState:UIControlStateNormal];
        _valueLable.enabled = YES;
        _valueLable.clipsToBounds = YES;
        _valueLable.layer.cornerRadius = 30;

    }
}



- (void)setUpKey:(NSString *)key value:(NSString *)value
{
    NSString *icon = @"修改头像";
    if (key == icon ) {
        [_keyLable setText:key];
        _valueLable.frame = CGRectMake(CGRectGetWidth(self.frame)-60, 0, 60, 60) ;
        [_valueLable setImage:[UIImage imageNamed:value] forState:UIControlStateNormal];
        _valueLable.enabled = YES;
        _valueLable.clipsToBounds = YES;
        _valueLable.layer.cornerRadius = 30;
    }else
        [_keyLable setText:key];
    [_valueLable setTitle:value forState:UIControlStateNormal];
    
    
    
    
}

@end
