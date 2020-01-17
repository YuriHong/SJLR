//
//  ForgetThreeController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ForgetThreeController.h"
#import "registerModel.h"

@interface ForgetThreeController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *sureTextField;


@end

@implementation ForgetThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [_accountTextField becomeFirstResponder];
}

- (IBAction)button:(id)sender {
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/forget_reset_password.do"];
    NSDictionary *params = @{
                             @"username": _name,
                             @"forgetToken": _forgetToken,
                             @"passwordNew": _accountTextField.text
                             };
    if ([_accountTextField.text isEqual:@""]){
        [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:@"密码不能为空" target:self];
    }
    else if (_accountTextField.text.length < 8 || _accountTextField.text.length > 16){
        [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:@"密码不能少于8个或者不能大于16个字符" target:self];
    }
    else if (![_accountTextField.text isEqual:_sureTextField.text]){
        [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:@"密码不一致" target:self];
    }
    else{
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            if (isSuccess) {
                registerModel *dataModel = [registerModel mj_objectWithKeyValues:data];
                if (dataModel.status == 0) {
                    [UIAlertController creatDoneAlertControllerTitle:@"修改结果" withMessage:dataModel.msg target:self callBack:^(UIAlertAction * _Nonnull action) {
                        UIViewController *forget = self.navigationController.childViewControllers[0];
                        [forget dismissViewControllerAnimated:YES completion:nil];
                    }];

                }
                else{
                    [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:dataModel.msg target:self];
                }
            }
            
            
        }];
        
    }
    

}


@end
