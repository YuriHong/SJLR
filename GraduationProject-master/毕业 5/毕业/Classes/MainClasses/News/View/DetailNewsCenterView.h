//
//  DetailNewsCenterView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/22.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYAttributedLabel/TYAttributedLabel.h>
#import "TYTextStorageParser.h"

@interface DetailNewsCenterView : UIView <TYAttributedLabelDelegate>
@property (nonatomic, strong) TYAttributedLabel *attributedLabel;
@property (nonatomic, strong) NSString *jsonStr;

@end
