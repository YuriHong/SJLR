//
//  LoginView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/23.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()


@end

@implementation LoginView

+(instancetype)getLoginView{
    return [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

@end
