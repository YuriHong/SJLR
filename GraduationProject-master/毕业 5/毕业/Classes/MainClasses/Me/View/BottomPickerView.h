//
//  BottomPickerView.h
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditPickView.h"
@interface BottomPickerView : UIView
@property (nonatomic,weak)UIView *grayBgView;
@property (nonatomic,weak)EditPickView *editView;
@property (nonatomic,weak)UIViewController *controller;
@property (nonatomic,copy)void (^bottomResultPresent)(NSString *);
@property (nonatomic,strong)UITapGestureRecognizer *recognizer;


+(instancetype)showWithController:(UIViewController *)controller andData:(NSArray *)data;
-(instancetype)initWithController:(UIViewController *)controller;

+(void)showEditPickerViewWithController:(UIViewController *)controller andData:(NSArray *)data andBlock:(void (^)(NSString *temp))bottomResultPresent;

@end
