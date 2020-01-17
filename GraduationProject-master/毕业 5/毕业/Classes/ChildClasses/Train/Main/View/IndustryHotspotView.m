//
//  IndustryHotspotView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/9/28.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "IndustryHotspotView.h"
#import "DetailNewsModel.h"

@interface IndustryHotspotView ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger number;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnCenterY;
@property (strong, nonatomic) DetailNewsModel *hotModel;

@end

@implementation IndustryHotspotView

+ (instancetype)getIndustryHotspotView{
    return [[NSBundle mainBundle] loadNibNamed:@"IndustryHotspotView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.clipsToBounds = YES;
}


-(void)setList:(NSArray *)list{
    _list = list;
    _number = 0;
    _hotModel = list[0];
    _label.text = _hotModel.title;
    [self timer];
}

-(NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(animation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(clickLineRightWithtitle:)]) {
        [_delegate clickLineRightWithtitle:_hotModel.title];
    }

}


-(void)animation{
    [UIView animateWithDuration:0.5 animations:^{
        _button.enabled = NO;
        _centerY.constant = -60;
        _btnCenterY.constant = -60;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        _centerY.constant = 60;
        _btnCenterY.constant = 60;
        [self layoutIfNeeded];
        _hotModel = _list[_number];
        _label.text = _hotModel.title;
        [UIView animateWithDuration:0.5 animations:^{
            _centerY.constant = 0;
            _btnCenterY.constant = 0;
            _button.enabled = YES;
           [self layoutIfNeeded];
        }];
    }];
    if (_number == 1) {
        _number = -1;
    }
    _number += 1;
}

-(void)dealloc{
    [self.timer invalidate];
}



@end
