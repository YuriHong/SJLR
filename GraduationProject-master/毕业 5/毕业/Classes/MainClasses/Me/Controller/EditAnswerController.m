//
//  EditAnswerController.m
//  毕业
//
//  Created by 龙波 on 2017/11/6.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "EditAnswerController.h"
#import "UIView+SYWLExtension.h"
#import <SMS_SDK/SMSSDK.h>
@interface EditAnswerController ()<UITextFieldDelegate>
@property(nonatomic,strong) NSString *questionStr;
@property(nonatomic,strong) NSString *answerStr;
@property(nonatomic,strong) UITextField *VerifyField;
@property(nonatomic,strong) UITextField *quesetionField;
@property(nonatomic,strong) UITextField *answerField;
@property(nonatomic,strong) UIButton *okBtn;

@end

@implementation EditAnswerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =@"修改问题";
    [self initUI];
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_iphoneStr zone:@"86" result:^(NSError *error) {
        if (error)
        {
             [UIAlertController creatAlertControllerTitle:@"获取验证码失败" withMessage:@"" target:self];
        }
    }];
}

- (void)initUI{

    NSString *tel = [_iphoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    NSLog(@"tel:%@",tel);
    
    UILabel *notice = [[UILabel alloc]initWithFrame:CGRectMake(25, 70, 350, 35)];
    notice.text = [NSString stringWithFormat:@"已向%@发送了验证码，请输入验证码",tel];
    notice.textColor = [UIColor blackColor];
    notice.backgroundColor = [UIColor clearColor];
    [self.view addSubview:notice];
    
    UITextField *VerifyField = [[UITextField alloc]initWithFrame:CGRectMake(100, 120, 100, 40)];
    VerifyField.placeholder = @"验证码";
    VerifyField.borderStyle = UITextBorderStyleRoundedRect;
    VerifyField.delegate = self;
    _VerifyField = VerifyField;
    [self.view addSubview:VerifyField];
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(VerifyField.rightX+10, VerifyField.y, 50, 40)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.backgroundColor = [UIColor blueColor];
    okBtn.layer.cornerRadius = 5;
    [okBtn setTintColor:[UIColor blackColor]];
    [okBtn addTarget:self action:@selector(finishidVerify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    _okBtn = okBtn;
    
    UITextField *answerField = [[UITextField alloc]initWithFrame:CGRectMake(100, 240, 160, 35)];
    answerField.placeholder = @"请输入答案";
    answerField.borderStyle  = UITextBorderStyleBezel;
    answerField.hidden = YES;
    answerField.delegate=self;
    [self.view addSubview:answerField];
    _answerField = answerField;
    
    
    UITextField *quesetionField = [[UITextField alloc]initWithFrame:CGRectMake(100, 190, 160, 35)];
    quesetionField.placeholder = @"请输入问题";
    quesetionField.borderStyle  = UITextBorderStyleBezel;
    quesetionField.hidden = YES;
    quesetionField.delegate = self;
    [self.view addSubview:quesetionField];
    _quesetionField = quesetionField;
}

-(void)finishidVerify
{
    [SMSSDK commitVerificationCode:_VerifyField.text phoneNumber:_iphoneStr zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            _VerifyField.hidden = YES;
            _okBtn.hidden = YES;
            _quesetionField.hidden = NO;
            _answerField.hidden = NO;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(update:)];
        }
        else
        {
            [UIAlertController creatAlertControllerTitle:@"验证失败" withMessage:@"" target:self];
            
        }
    }];

}

-(void)update:(id)sender{
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/update_information.do"];
    NSDictionary *params = @{@"question": _quesetionField.text,
                             @"answer": _answerField.text};
    [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
        if (isSuccess) {
            self.question(_quesetionField.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [UIAlertController creatAlertControllerTitle:@"网络异常" withMessage:@"" target:self];

        }
        
     }];

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
      [self.view endEditing:YES];
}

@end
