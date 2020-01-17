//
//  PersonEditController.m
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//#import <SMS_SDK/SMSSDK.h>


#import "PersonEditController.h"
#import <SMS_SDK/SMSSDK.h>
#import "EditAnswerController.h"
//#import "LBStringValidateUtil.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "PasswordController.h"


@interface PersonEditController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak)UIView *grayBgView;
@property (nonatomic,weak)UILabel *label;
@property (nonatomic,weak)UIButton *button;
@property (nonatomic,weak)UIButton *button1;
@property(nonatomic,strong) UIButton *nameButton;
@property(nonatomic,strong) NSString *iphoneNo;

@property(nonatomic,strong) UITextField *test;

@end

@implementation PersonEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iphoneNo = @"17912866578";
    CGFloat btnH = 60;
    self.navigationItem.title = @"个人信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _keyEditBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0, btnH, SCREENWIDTH, btnH)];
    [_keyEditBtn addTarget:self action:@selector(keyEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_keyEditBtn];
    
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_keyEditBtn.frame), SCREENWIDTH -25, 1)];
    lineView3.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lineView3];
    
    _iphoneEditBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0,btnH*4, SCREENWIDTH, btnH)];
  //  [_iphoneEditBtn addTarget:self action:@selector(editIphone) forControlEvents:UIControlEventTouchUpInside];
 //   [self.view addSubview:_iphoneEditBtn];
    
    
    
    _emailEditBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0,btnH*3, SCREENWIDTH, btnH)];
    [_emailEditBtn addTarget:self action:@selector(editEmaile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_emailEditBtn];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_emailEditBtn.frame) , SCREENWIDTH-25,1)];
    lineView5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView5];
    _anserEditBtn =[[EditBtn alloc]initWithFrame:CGRectMake(0,btnH*2, SCREENWIDTH, btnH)];
    [_anserEditBtn addTarget:self action:@selector(senderVerify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_anserEditBtn];
    
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_anserEditBtn.frame), SCREENWIDTH -25, 1)];
    lineView4.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lineView4];
    
    //[_iconEditBtn setUpKey:@"修改头像" value:@"头3"];
   // [_iphoneEditBtn setUpKey:@"修改手机号" value:_model.phone];
    [_emailEditBtn setUpKey:@"修改邮箱" value:_model.email];
    [_anserEditBtn setUpKey:@"修改问题" value:_model.question];
    [_keyEditBtn setUpKey:@"修改密码" value:@""];
}


- (void)editIcon{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:0 handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alertVC addAction:cancel];
    //    [alertVC addAction:camera];
    [alertVC addAction:picture];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}
#pragma mark -------UIImagePickerControllerDelegate代理实现--------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString *)kUTTypeImage] && picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [_iconEditBtn setUpKey:@"修改头像" image:img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    }
}



/*

-(void)editIphone
{

       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"修改手机号" preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *userNameTextField = alertController.textFields.firstObject;
            
            [_iphoneEditBtn setUpKey:@"修改手机号" value:userNameTextField.text];
            NSLog(@"用户名 = %@，",userNameTextField.text);
    
        }]];
    
        //增加取消按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
        //定义第一个输入框；
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"昵称";
        }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}
*/
- (void)editEmaile{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"修改邮箱" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        [_emailEditBtn setUpKey:@"修改邮箱" value:userNameTextField.text];
        NSLog(@"用户名 = %@，",userNameTextField.text);
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"邮箱";
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];

}


- (void)senderVerify
{
    EditAnswerController *qc = [[EditAnswerController alloc]init];
    qc.iphoneStr = _model.phone;
    qc.question = ^(NSString *questionstr) {
        [_anserEditBtn setUpKey:@"修改问题" value:questionstr];

    };
    [self.navigationController pushViewController:qc animated:YES];

}

//MARK: -修改密码
-(void)keyEdit
{
    PasswordController *password = [[PasswordController alloc] init];
    password.phoneStr = _model.phone;
    [self.navigationController pushViewController:password animated:YES];
    
}
//-(void)finishidVerify:(NSString *)VerifyText
//{
//    [SMSSDK commitVerificationCode:VerifyText phoneNumber:_model.phone zone:@"86" result:^(NSError *error) {
//        
//        if (!error)
//        {
//            [self editAnswer];
//        }
//        else
//        {
//            [UIAlertController creatAlertControllerTitle:@"验证失败" withMessage:@"" target:self];
//            
//        }
//    }];
//
//}
//
//- (void)editAnswer
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入手机验证码" preferredStyle:UIAlertControllerStyleAlert];
//    //增加确定按钮；
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //获取第1个输入框；
//        UITextField *questionTextField = alertController.textFields.firstObject;
//        UITextField *answerTextFiele = alertController.textFields.lastObject;
//        NSLog(@"问题 = %@，答案==%@，",questionTextField.text,answerTextFiele.text);
//        
//        
//    }]];
//    
//    //增加取消按钮；
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
//    
//    //定义第一个输入框；
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"邮箱";
//    }];
//
//}

@end

