//
//  ForgetTwoController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ForgetTwoController.h"
#import "ForgetThreeController.h"
#import "registerModel.h"

@interface ForgetTwoController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ForgetTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    _label.text = _question;
}

-(void)viewWillAppear:(BOOL)animated{
    [_textField becomeFirstResponder];
}


- (IBAction)buttonClick:(id)sender {
    NSString *urlString = [NetworkTool willConcatenationString:@"/user/forget_check_answer.do"];
    NSDictionary *params = @{
                             @"username": _name,
                             @"question": _question,
                             @"answer": _textField.text
                             };
    if ([_textField.text isEqual:@""]) {
        [UIAlertController creatAlertControllerTitle:@"答案不能为空" withMessage:nil target:self];
    }
    else{
        [[NetworkTool sharedInstance] requestWithURLString:urlString params:params method:POST callBack:^(id data, bool isSuccess) {
            registerModel *dataModel = [registerModel mj_objectWithKeyValues:data];
            if (isSuccess) {
                if (dataModel.status == 0) {
                    ForgetThreeController *forget = [[ForgetThreeController alloc] init];
                    forget.name = _name;
                    forget.forgetToken = dataModel.data;
                    [self.navigationController pushViewController:forget animated:YES];
                }
                if (dataModel.status == 1) {
                    [UIAlertController creatAlertControllerTitle:@"" withMessage:dataModel.msg target:self];
                }
            }
            
        }];

    } 
}



@end
