//
//  detailVacationTopView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "detailVacationTopView.h"
#import "UIView+ BorderLine.h"

@implementation detailVacationTopView

+(instancetype)getDetailVacationTopView{
    return [[NSBundle mainBundle] loadNibNamed:@"detailVacationTopView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [_moreLabel borderForColor:[UIColor lightGrayColor] borderWidth:2 borderType:UIBorderSideTypeAll];
}

@end
