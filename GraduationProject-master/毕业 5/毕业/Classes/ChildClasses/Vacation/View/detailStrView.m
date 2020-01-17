//
//  detailStrView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "detailStrView.h"

@interface detailStrView ()


@end

@implementation detailStrView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
       
    }
    return self;
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
    [self addSubview:_textLabel];
}


@end
