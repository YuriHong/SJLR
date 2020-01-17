//
//  AcidityBaseView.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcidityBaseView : UIView

@property(nonatomic,strong) UILabel *keyLabel;

@property(nonatomic,strong) UILabel *valueLabel;

- (void)setupKey:(NSString *)key Value:(NSString *)value;


@end
