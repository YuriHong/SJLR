//
//  InstituteViewCell.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstituteViewCell.h"
#import "ButtonMenu.h"
#import "ButtonTypesetting.h"

@interface InstituteViewCell ()
@property (nonatomic, strong) UIView *view;

@end

@implementation InstituteViewCell

-(UIView *)view{
    if (_view == nil) {
        _view = [[UIView alloc] initWithFrame:self.bounds];
        _view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_view];
    }
    return _view;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    [self view];
    //ButtonMenu *button = [ButtonMenu buttonWithType:UIButtonTypeCustom];
    [ButtonTypesetting addBtnWithButtonClass:[ButtonMenu class] buttonWH:90 Cloumn:4 withOriginY:30 array:array target:self action:@selector(click:)];
}

-(void)click:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(getButtonTitle:)]) {
        [_delegate getButtonTitle:button.titleLabel.text];
    }
}

@end
