//
//  DetailNewsTopView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/22.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailNewsTopView.h"

@implementation DetailNewsTopView

+(instancetype)getDetailNewsTopView{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailNewsTopView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

@end
