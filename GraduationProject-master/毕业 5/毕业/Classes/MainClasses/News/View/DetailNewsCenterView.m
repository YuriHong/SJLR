//
//  DetailNewsCenterView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/22.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailNewsCenterView.h"

@implementation DetailNewsCenterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupAttrLabel];
    }
    return self;
}

-(void)setupAttrLabel{
    [self attributedLabel];
}

-(void)setJsonStr:(NSString *)jsonStr{
    _jsonStr = jsonStr;
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonStr ofType:@"json"];
    
    [self parseJsonFileWithPath:path];
    
    [_attributedLabel sizeToFit];
}

-(TYAttributedLabel *)attributedLabel{
    if (_attributedLabel == nil) {
        _attributedLabel = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
        _attributedLabel.backgroundColor = RGBColor(231, 231, 231);
        _attributedLabel.delegate = self;
        [self addSubview:_attributedLabel];
    }
    return _attributedLabel;
}

- (void)parseJsonFileWithPath:(NSString *)filePath
{
    NSArray *textStorageArray = [TYTextStorageParser parseWithJsonFilePath:filePath];
    
    if (textStorageArray.count > 0) {
        [_attributedLabel appendTextStorageArray:textStorageArray];
    }
}

#pragma mark - TYAttributedLabelDelegate

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextStorage atPoint:(CGPoint)point
{
    if ([TextStorage isKindOfClass:[TYLinkTextStorage class]]) {
        NSString *linkStr = ((TYLinkTextStorage*)TextStorage).linkData;
        
        if ([linkStr hasPrefix:@"http"]) {
            [ [ UIApplication sharedApplication] openURL:[ NSURL URLWithString:linkStr]];
        }else {
            //NSLog(@"123");
        }
    }
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    //NSLog(@"%@",attributedLabel);
}

@end
