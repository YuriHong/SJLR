//
//  registerThreeView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/24.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerThreeView : UIView
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *TestingButton;

+(instancetype)getRegisterThreeView;

@end
