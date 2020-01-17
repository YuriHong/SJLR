//
//  ForgetViewController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ForgetViewController.h"
#import "ForgetTwoController.h"
#import "UIImage+Image.h"
#import "registerModel.h"
#import "NSString+Extension.h"

@interface ForgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationbar];
}

-(void)viewWillAppear:(BOOL)animated{
    [_textField becomeFirstResponder];
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}

- (IBAction)buttonClick:(id)sender {
    NSString *str = _textField.text;
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/forget_get_question.do"];
    NSDictionary *params = @{
                             @"username": str
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
            [UIAlertController creatAlertControllerTitle:@"检测结果" withMessage:@"用户名超出长度,汉字不能大于8个，或者字符不能大于16个" target:self];
        }
        else{
            [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
                registerModel *dataModel = [registerModel mj_objectWithKeyValues:data];
                if (isSuccess) {
                    if (dataModel.status == 0) {
                        ForgetTwoController *forget = [[ForgetTwoController alloc] init];
                        forget.question = dataModel.data;
                        forget.name = _textField.text;
                        [self.navigationController pushViewController:forget animated:YES];
                    }
                    if (dataModel.status == 1) {
                        [UIAlertController creatAlertControllerTitle:nil withMessage:dataModel.msg target:self];
                    }
                }
                
            }];
        }
    }

    
 
}

-(void)setupNavigationbar{
    self.navigationItem.title = @"忘记密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginalImageName:@"navback"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick:)];
}

-(void)barButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
