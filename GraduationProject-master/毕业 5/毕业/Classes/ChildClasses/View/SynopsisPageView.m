//
//  ChildDetailInstView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/11.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "SynopsisPageView.h"
#import "UIView+SYWLExtension.h"

@interface SynopsisPageView ()
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIScrollView *ScrollView;

@end

@implementation SynopsisPageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self ScrollView]; 
    }
    return self;
}

-(UIScrollView *)ScrollView{
    if (_ScrollView == nil) {
        _ScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _ScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_ScrollView];
    }
    return _ScrollView;
}

-(void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    detailStr = [detailStr stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r\n"];
    _textLabel = [[UILabel alloc] init];
    _textLabel.x = 10;
    _textLabel.y = 10;
    _textLabel.width = SCREENWIDTH - 2 * _textLabel.x;
    _textLabel.numberOfLines = 0;
    _textLabel.font = [UIFont fontWithName:@"HYQuanTangShiJ" size:16];
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;
    CGFloat emptylen = _textLabel.font.pointSize * 2;
    paraStyle01.firstLineHeadIndent = emptylen;
    paraStyle01.lineSpacing = 5.0f;
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:detailStr attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    _textLabel.attributedText = attrText;
    [_textLabel sizeToFit];
    [_ScrollView addSubview:_textLabel];
    
    _ScrollView.contentSize = CGSizeMake(0, _textLabel.bottomY + 20);
}

@end

