//
//  detailVacationCenterView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "detailVacationCenterView.h"
#import "UIView+ BorderLine.h"

@implementation detailVacationCenterView

+(instancetype)getDetailVacationCenterView{
    return [[NSBundle mainBundle] loadNibNamed:@"detailVacationCenterView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [_button borderForColor:[UIColor redColor] borderWidth:1 borderType:UIBorderSideTypeAll];
}

@end
