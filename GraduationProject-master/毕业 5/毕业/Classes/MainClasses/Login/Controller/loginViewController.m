//
//  loginVIewController.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "loginViewController.h"
#import "mainViewController.h"
#import "LBUerNetModel.h"
#import "UerBaseModel.h"
#import "LoginView.h"
#import "registerController.h"
#import "ForgetViewController.h"
#import "navigationViewController.h"
#import "saveService.h"
#import "NSString+Extension.h"

@interface loginViewController ()<UITextFieldDelegate>
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) LoginView *loginView;

@end

@implementation loginViewController

//该类或其子类只支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(LoginView *)loginView{
    if (_loginView == nil) {
        _loginView = [LoginView getLoginView];
        _loginView.centerX = self.view.centerX;
        _loginView.y = 150;
        [_loginView.registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.forgetButton addTarget:self action:@selector(forgetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

-(void)forgetButtonClick:(id)sender{
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    navigationViewController *nav = [[navigationViewController alloc] initWithRootViewController:forget];
    [self presentViewController:nav animated:YES completion:nil];
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}

-(void)loginButtonClick:(id)sender{
    NSString *userStr = _loginView.accountTextField.text;
    NSString *pwdStr = _loginView.pwdTextField.text;
   
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/login.do"];
    NSDictionary *params = @{@"username": userStr,
                             @"password": pwdStr};
    if ([userStr isEqual:@""]) {
        [UIAlertController creatAlertControllerTitle:@"登录结果" withMessage:@"请输入用户名" target:self];
    }
    else if ([self isPureInt:[userStr substringToIndex:1]]) {
        [UIAlertController creatAlertControllerTitle:@"登录结果" withMessage:@"用户名不能以数字开头" target:self];
    }
    else if ([NSString getByteString:userStr] > 16 ){
        [UIAlertController creatAlertControllerTitle:@"登录结果" withMessage:@"用户名超出长度,汉字不得大于8个，或者字符不能大于16个" target:self];
    }
    else if ([pwdStr isEqual:@""]){
        [UIAlertController creatAlertControllerTitle:@"登录结果" withMessage:@"请输入密码" target:self];
    }
    else if (pwdStr.length < 8 || pwdStr.length > 16){
        [UIAlertController creatAlertControllerTitle:@"登录结果" withMessage:@"密码不能少于8个或者不能大于16个字符" target:self];
    }
    else{
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            if (isSuccess == YES) {
                UerBaseModel *baseModel = [UerBaseModel mj_objectWithKeyValues:data];
                if (baseModel.status.boolValue == 0) {
                    LBUerNetModel *netModel = [LBUerNetModel mj_objectWithKeyValues:baseModel.data];
                    [[PersonInfo sharePersonInfo]setLoginUserId:netModel.id];
                    
                    [UIAlertController creatDoneAlertControllerTitle:@"登录成功" withMessage:baseModel.msg target:self callBack:^(UIAlertAction * _Nonnull action) {
                        [saveService setObject:userStr forKey:@"name"];
                        [saveService setObject:pwdStr forKey:@"pwd"];
                        [saveService setObject:@"1" forKey:@"login"];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                }
                if (baseModel.status.boolValue == 1) {
                    [UIAlertController creatAlertControllerTitle:@"登录失败" withMessage:baseModel.msg target:self];
                    
                }
            }
            else{
                [UIAlertController creatAlertControllerTitle:@"登录失败" withMessage:@"网络异常" target:self];
            }
        }];

    }
    
}

-(void)registerButtonClick:(id)sender{
    registerController *rgst = [[registerController alloc] init];
    navigationViewController *nav = [[navigationViewController alloc] initWithRootViewController:rgst];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![_loginView.accountTextField isExclusiveTouch] || ![_loginView.pwdTextField isExclusiveTouch]) {
        [_loginView.accountTextField resignFirstResponder];
        [_loginView.pwdTextField resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageView];
    [self titleLabel];
    [self loginView];

}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login"]];
        _imageView.frame = self.view.bounds;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(0, 60, SCREENWIDTH, 30);
        _titleLabel.text = @"校园帮";
        _titleLabel.font = [UIFont systemFontOfSize:24];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end


