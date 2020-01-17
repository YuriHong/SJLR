//
//  registerTwoView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/24.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "registerTwoView.h"

@implementation registerTwoView

+(instancetype)getRegisterTwoView{
    return [[NSBundle mainBundle] loadNibNamed:@"registerTwoView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

@end
