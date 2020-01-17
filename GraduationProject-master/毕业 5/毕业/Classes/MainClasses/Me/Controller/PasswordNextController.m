//
//  PasswordNextController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/15.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "PasswordNextController.h"
#import "PasswordModel.h"
#import "saveService.h"
@interface PasswordNextController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *newsPassword;
@property (weak, nonatomic) IBOutlet UITextField *surePassword;


@end

@implementation PasswordNextController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)sureButtonClick:(id)sender {
    NSString *oldStr = _oldPassword.text;
    NSString *newsStr = _newsPassword.text;
    NSString *sureStr = _surePassword.text;
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/reset_password.do"];
    NSDictionary *params = @{@"passwordOld": oldStr,
                             @"passwordNew": newsStr};
    
    if ([oldStr isEqual:@""] || [newsStr isEqual:@""]) {
        [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:@"密码不能为空" target:self];
    }
    else if(oldStr.length < 8 || oldStr.length > 16 || newsStr.length < 8 || newsStr.length > 16){
        [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:@"密码不能少于8个或者不能大于16个字符" target:self];
    }
    else if (![newsStr isEqual:sureStr]){
        [UIAlertController creatAlertControllerTitle:@"修改结果" withMessage:@"密码不一致" target:self];
    }
    else{
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            if (isSuccess) {
                PasswordModel *model = [PasswordModel mj_objectWithKeyValues:data];
                if (model.status == 0) {
                    [UIAlertController creatDoneAlertControllerTitle:@"修改成功" withMessage:nil target:self callBack:^(UIAlertAction * _Nonnull action) {
                        [saveService setObject:newsStr forKey:@"pwd"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }];
                }
                else{
                    [UIAlertController creatAlertControllerTitle:model.msg withMessage:nil target:self];
                }
            }
            else{
                [UIAlertController creatAlertControllerTitle:@"网络异常" withMessage:@"" target:self];
                
            }
            
        }];
    }
    
    
}


@end
