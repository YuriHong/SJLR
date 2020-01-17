//
//  PasswordController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "PasswordController.h"
#import <JKCountDownButton/JKCountDownButton.h>
#import <SMS_SDK/SMSSDK.h>
#import "PasswordNextController.h"

@interface PasswordController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation PasswordController

int replacementStringSum = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"获取验证码";
    
    _nextButton.enabled = NO;
    _nextButton.backgroundColor = [UIColor grayColor];
    _textField.delegate = self;
    
    NSString *tel = [_phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _label.text = [NSString stringWithFormat:@"是否向绑定手机号码为%@的手机发送验证码请求？",tel];
}

- (IBAction)countDown:(JKCountDownButton *)sender {
    [self GetAuthenticationCode];
    sender.enabled = NO;
    sender.backgroundColor = [UIColor grayColor];
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:60];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"还有%zd秒才能重新发送",second];
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        countDownButton.backgroundColor = [UIColor blueColor];
        return @"重新获取";
        
    }];
}

-(void)GetAuthenticationCode{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneStr zone:@"86" result:^(NSError *error) {
        if (error)
        {
            [UIAlertController creatAlertControllerTitle:@"获取验证码失败" withMessage:@"" target:self];
        }
    }];
}

- (IBAction)nextButtonClick:(id)sender {
    [SMSSDK commitVerificationCode:_textField.text phoneNumber:_phoneStr zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            PasswordNextController *next = [[PasswordNextController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
        }
        else
        {
            [UIAlertController creatAlertControllerTitle:@"验证失败" withMessage:@"验证码错误" target:self];
            
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqual:@""]) {
        if (replacementStringSum != 0) {
            replacementStringSum--;
        }
    }
    else{
        replacementStringSum++;
    }
    
    if (replacementStringSum == 4) {
        _nextButton.enabled = YES;
        _nextButton.backgroundColor = [UIColor blueColor];
    }
    else{
        _nextButton.enabled = NO;
        _nextButton.backgroundColor = [UIColor grayColor];
    }
    return YES;
}

@end
