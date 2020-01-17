//
//  AllOrderFooterView.m
//  test-个人
//
//  Created by 龙波 on 2017/10/31.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "AllOrderFooterView.h"

@interface AllOrderFooterView ()

@property(nonatomic,strong) UIButton *payBtn;


@end

@implementation AllOrderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setupUI
{
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 4*SCREENWIDTH/5, SCREENWIDTH/5, 40) ;
    button.backgroundColor = RandColor;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _payBtn = button;
    [self.contentView addSubview:button];
    
}

-(void)btnClick:(id)sender{
    
}

@end
