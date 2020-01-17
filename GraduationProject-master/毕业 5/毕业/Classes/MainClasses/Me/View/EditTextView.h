//
//  EditTextView.h
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTextView.h"
@interface EditTextView : UIView

@property (nonatomic,weak)UIButton *grayBgView;
@property (nonatomic,copy)void (^requestDataBlock)(NSString *text);
@property(nonatomic,strong) NSString *getString;
@property(nonatomic,weak) TopTextView *topTextView;



+(instancetype)showWithController:(UIViewController *)controller;



+(void)showWithController:(UIViewController *)controller andRequestDataBlock:(void(^)(NSString *))requestDataBlock;

@end

