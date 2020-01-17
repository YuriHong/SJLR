//
//  registerController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/23.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "registerController.h"
#import "registerOne.h"
#import <SMS_SDK/SMSSDK.h>
#import "registerTwoController.h"
#import "UIImage+Image.h"

@interface registerController ()
@property(nonatomic, weak) UITextField *textField;
@property(nonatomic, strong) registerOne *one;
@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation registerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationbar];
    [self one];
    
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login"]];
        _imageView.frame = self.view.bounds;
        _imageView.userInteractionEnabled = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

-(void)viewWillAppear:(BOOL)animated{
    [_one.phoneTextField becomeFirstResponder];
}

-(registerOne *)one{
    if (_one == nil) {
        _one = [registerOne getregisterOne];
        _one.y = 30;
        [_one.nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:_one];
    }
    return _one;
}

-(void)buttonClick:(id)sender{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_one.phoneTextField.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            registerTwoController *registerTwo = [[registerTwoController alloc] init];
            registerTwo.phoneNumber = _one.phoneTextField.text;
            [self.navigationController pushViewController:registerTwo animated:YES];
        }
        else
        {
            [UIAlertController creatAlertControllerTitle:@"获取验证码失败" withMessage:@"" target:self];
        }
    }];
}

-(void)setupNavigationbar{
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginalImageName:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(click)];
}

-(void)click{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
