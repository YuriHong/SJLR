//
//  registerTwoController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/24.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "registerTwoController.h"
#import "registerTwoView.h"
#import <SMS_SDK/SMSSDK.h>
#import "registerThreeController.h"

@interface registerTwoController ()
@property(nonatomic,strong)registerTwoView *registerTwo;
@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation registerTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"验证码";
    [self registerTwo];
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
    [_registerTwo.textField becomeFirstResponder];
}

-(registerTwoView *)registerTwo{
    if (_registerTwo == nil) {
        _registerTwo = [registerTwoView getRegisterTwoView];
        _registerTwo.y = 30;
        [_registerTwo.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:_registerTwo];
    }
    return _registerTwo;
}

-(void)buttonClick:(id)sender{
    [SMSSDK commitVerificationCode:_registerTwo.textField.text phoneNumber:_phoneNumber zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            registerThreeController *registerTwo = [[registerThreeController alloc] init];
            registerTwo.phoneNumber = _phoneNumber;
            [self.navigationController pushViewController:registerTwo animated:YES];
        }
        else
        {
            [UIAlertController creatAlertControllerTitle:@"验证失败" withMessage:@"" target:self];

        }
    }];
}



@end
