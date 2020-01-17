//
//  TopTextView.h
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopTextView : UIView

@property (nonatomic,weak)UITextView *textView;
@property (nonatomic,weak)UIButton *submitBtn;
@property (nonatomic,weak)UIButton *cancelBtn;

@property (nonatomic,weak)UILabel *titleLabel;



@property (nonatomic,copy) void(^submitBlock)(NSString * text);
@property (nonatomic,copy) void(^closeBlock)();


@end

