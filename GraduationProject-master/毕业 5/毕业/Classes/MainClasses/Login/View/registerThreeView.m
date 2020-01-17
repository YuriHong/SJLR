//
//  registerThreeView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/24.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "registerThreeView.h"

@implementation registerThreeView

+(instancetype)getRegisterThreeView{
    return [[NSBundle mainBundle] loadNibNamed:@"registerThreeView" owner:nil options:nil][0];
}

@end
