//
//  NationalityMenuView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "NationalityMenuView.h"
#import "ButtonMenu.h"
#import "ButtonMenuItem.h"
#import "ButtonTypesetting.h"

@interface NationalityMenuView ()
@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation NationalityMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(NSArray *)itemArray{
    if (_itemArray == nil) {
        ButtonMenuItem *item = [ButtonMenuItem itemWithTitle:@"学校" image:[UIImage imageNamed:@"367B9C7F-7681-45F5-9CFF-67D098D2A6D3"]];
        ButtonMenuItem *item1 = [ButtonMenuItem itemWithTitle:@"专业" image:[UIImage imageNamed:@"47402FE5-6FBD-4A5A-A24F-0E5BF7AF3F07"]];
        _itemArray = @[item,item1];
        
    }
    return _itemArray;
}

-(void)setupUI{
    [ButtonTypesetting addBtnWithButtonClass:[ButtonMenu class] buttonWH:90 Cloumn:3 withOriginY:10 array:self.itemArray target:self action:@selector(btnClick:)];
    
}

-(void)btnClick:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(setPushViewControllerWithTitle:)]) {
        [_delegate setPushViewControllerWithTitle:button.titleLabel.text];
    }
    
}

@end
