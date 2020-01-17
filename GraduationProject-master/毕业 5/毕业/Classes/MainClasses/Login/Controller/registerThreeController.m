//
//  registerThreeController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/24.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "registerThreeController.h"
#import "registerThreeView.h"
#import "registerModel.h"
#import "NSString+Extension.h"

@interface registerThreeController ()<UITextFieldDelegate>
@property (nonatomic, strong) registerThreeView *registerThree;
@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation registerThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"昵称密码";
    [self registerThree];
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

-(registerThreeView *)registerThree{
    if (_registerThree == nil) {
        _registerThree = [registerThreeView getRegisterThreeView];
        _registerThree.y = 84;
        [_registerThree.TestingButton addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];
        [_registerThree.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _registerThree.accountTextField.delegate = self;
        [self.imageView addSubview:_registerThree];
    }
    return _registerThree;
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}

//MARK: - 检测
-(void)testButton:(id)sender{
    NSString *str = _registerThree.accountTextField.text;
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/check_valid.do"];
    NSDictionary *params = @{
                             @"str": str,
                             @"type": @"username"
                             };
    if ([str isEqual:@""]) {
        [UIAlertController creatAlertControllerTitle:@"检测结果" withMessage:@"用户名不能为空" target:self];
    }
    else{
        NSString *firstStr = [str substringToIndex:1];
        if ([self isPureInt:firstStr]) {
            [UIAlertController creatAlertControllerTitle:@"检测结果" withMessage:@"用户名不能以数字开头" target:self];
        }
        else if ([NSString getByteString:str] > 16 ){
            [UIAlertController creatAlertControllerTitle:@"检测结果" withMessage:@"用户名超出长度" target:self];
        }
        else{
            [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
                registerModel *dataModel = [registerModel mj_objectWithKeyValues:data];
                if (isSuccess == YES) {
                    [UIAlertController creatAlertControllerTitle:@"检测结果" withMessage:dataModel.msg target:self];
                }
                else{
                   [UIAlertController creatAlertControllerTitle:@"检测结果" withMessage:@"网络异常" target:self];
                }
            }];
        }
    }
}

//MARK: -注册
-(void)buttonClick:(id)sender{
    NSString *str = _registerThree.accountTextField.text;
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/register.do"];
    NSDictionary *params = @{
                             @"username": _registerThree.accountTextField.text,
                             @"password": _registerThree.PwdTextField.text,
                             @"phone": _phoneNumber
                             };

    if ([_registerThree.accountTextField.text isEqual:@""]) {
        [UIAlertController creatAlertControllerTitle:@"注册结果" withMessage:@"用户名不能为空" target:self];
    }
    else{
        NSString *firstStr = [str substringToIndex:1];
        if ([self isPureInt:firstStr]) {
            [UIAlertController creatAlertControllerTitle:@"注册结果" withMessage:@"用户名不能以数字开头" target:self];
        }
        else if ([_registerThree.PwdTextField.text isEqual:@""]){
            [UIAlertController creatAlertControllerTitle:@"注册结果" withMessage:@"密码不能为空" target:self];
        }
        else if (_registerThree.PwdTextField.text.length < 8 || _registerThree.PwdTextField.text.length > 16){
            [UIAlertController creatAlertControllerTitle:@"注册结果" withMessage:@"密码不能少于8个或者不能大于16个字符" target:self];
        }
        else if (![_registerThree.PwdTextField.text isEqual:_registerThree.surePwdTextField.text]){
            [UIAlertController creatAlertControllerTitle:@"注册结果" withMessage:@"密码不一致" target:self];
        }
        else{
            [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
                registerModel *dataModel = [registerModel mj_objectWithKeyValues:data];
                if (isSuccess) {
                    if (dataModel.status == 0) {
                        [UIAlertController creatDoneAlertControllerTitle:@"注册结果" withMessage:@"注册成功" target:self callBack:^(UIAlertAction * _Nonnull action) {
                            UIViewController *rist = self.navigationController.childViewControllers[0];
                            [rist dismissViewControllerAnimated:YES completion:nil];
                        }];
                    }
                    if (dataModel.status == 1) {
                        [UIAlertController creatAlertControllerTitle:@"注册结果" withMessage:@"用户名已存在" target:self];
                    }
                }
                
            }];
            
        }

    }
    
   
}

@end
