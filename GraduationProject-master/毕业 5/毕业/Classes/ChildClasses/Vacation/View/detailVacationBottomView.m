//
//  detailVacationBottomView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "detailVacationBottomView.h"


@interface detailVacationBottomView ()
@property (weak, nonatomic) IBOutlet UIView *detailView;


@end

@implementation detailVacationBottomView

+(instancetype)getDetailVacationBottomView{
    return [[NSBundle mainBundle] loadNibNamed:@"detailVacationBottomView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self detail];
}

-(void)setDetailString:(NSString *)detailString{
    _detailString = detailString;
    _detail.detailStr = detailString;
   
}

-(detailStrView *)detail{
    if (_detail == nil) {
        _detail = [[detailStrView alloc] init];
        [self.detailView addSubview:_detail];
    }
    return _detail;
}

@end
