//
//  EditPickView.h
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPickView : UIView
/**
 *  背景图（半透明全屏）
 */
@property (nonatomic,weak)UIView *blackBgView;

/**
 *  下部弹出框的ToolBar
 */
@property (nonatomic,weak)UIToolbar *toolBarView;

/**
 *  弹出框主题背景
 */
@property (nonatomic,weak)UIView *mainBgView;

/**
 *  部门选择PickView
 */
@property (nonatomic,weak)UIPickerView *pickerView;

/**
 *  取消按钮
 */

@property (nonatomic,weak)UIButton *cancelBtn;

/**
 *  确定按钮
 */
@property (nonatomic,weak)UIButton *sureBtn;

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,copy) void (^refreshUserInterface)(NSString *);

@property (nonatomic,copy) void (^dropEditPickerView)();


@end
