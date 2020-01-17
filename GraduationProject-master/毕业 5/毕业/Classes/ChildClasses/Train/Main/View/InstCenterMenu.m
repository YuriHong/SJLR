//
//  SYWLCenterMenu.m
//  毕业设计
//
//  Created by 吴添培 on 2017/7/1.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstCenterMenu.h"
#import "ButtonMenu.h"
#import "ButtonMenuItem.h"
#import "ButtonTypesetting.h"

@interface InstCenterMenu ()
@property (nonatomic, copy) NSArray *itemArray;
@end

@implementation InstCenterMenu

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(NSArray *)itemArray{
    if (_itemArray == nil) {
        ButtonMenuItem *item = [ButtonMenuItem itemWithTitle:@"课程列表" image:[UIImage imageNamed:@"47402FE5-6FBD-4A5A-A24F-0E5BF7AF3F07"]];
        ButtonMenuItem *item1 = [ButtonMenuItem itemWithTitle:@"培训机构" image:[UIImage imageNamed:@"367B9C7F-7681-45F5-9CFF-67D098D2A6D3"]];
        ButtonMenuItem *item2 = [ButtonMenuItem itemWithTitle:@"免费课程" image:[UIImage imageNamed:@"FEC739A7-FF1E-499B-A324-905A65B47ED9"]];
        _itemArray = @[item,item1,item2];
     }
    return _itemArray;
}

-(void)setupUI{
    [ButtonTypesetting addBtnWithButtonClass:[ButtonMenu class] buttonWH:90 Cloumn:3 withOriginY:10 array:self.itemArray target:self action:@selector(btnClick:)];
}

-(void)btnClick:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(setPushViewControllerWithButtonTitle:)]) {
            [_delegate setPushViewControllerWithButtonTitle:button.titleLabel.text];
        }
}


@end
