//
//  FFInputePostViewController.m
//  FZFBase
//
//  Created by fengzifeng on 2017/8/26.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFInputePostViewController.h"
#import "MCAboutMeViewController.h"
#import "FFPlateModel.h"
#import "FFActiveChooseView.h"

@interface FFInputePostViewController ()  <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, copy) NSString *fid;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
    
@end

@implementation FFInputePostViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _topConstraint.constant = ([UIApplication sharedApplication].statusBarFrame.size.height == 44) ? 88 : 64;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    self.title = @"发帖";
    _textView.placeholder = @"写文章…";
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    
    UIButton *leftButton = [UIButton newBackArrowNavButtonWithTarget:self action:@selector(clickLeft)];
    [self setNavigationLeftView:leftButton];
    UIButton *rightButton = [UIButton newCloseButtonWithTarget:self action:@selector(clickRight)];
    [self setNavigationRightView:rightButton];
    __weak typeof(self) weakSelf = self;

    [self.view setTapActionWithBlock:^{
        [weakSelf.view endEditing:YES];
    }];
    
    [self requestData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"凡用户发布的信息出现以下情况之一的，管理人员有权不通知作者直接删除，并有权关闭其部分权限、暂停直至取消该帐号；社区用户发布的任何信息，不得含有任何违反国家法律法规政策的信息，包括但不限于下列信息：\n(1) 反对宪法所确定的基本原则的；\n(2) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n(3) 损害国家荣誉和利益的；\n(4) 煽动民族仇恨、民族歧视，破坏民族团结的；\n(5) 破坏国家宗教政策，宣扬邪教和封建迷信的；\n(6) 散布谣言，扰乱社会秩序，破坏社会稳定的；\n(7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖、毒品或者教唆犯罪的；\n(8) 侮辱或者诽谤他人，侵害他人合法权益的；\n(9) 含有盗版、图片、图书和/或其它任何侵犯第三方任何合法权益作品的。\n(10)含有法律、行政法规禁止的其他内容的。\n (11)其他社区明确禁止的。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (FFPlateModel *)requestData
{
    NSDictionary *dict = [userDefaults objectForKey:UserDefaultKey_plateData];

    if (dict.allKeys.count) return [FFPlateModel objectWithKeyValues:dict];
;
    
    [[DrHttpManager defaultManager] getRequestToUrl:url_structedgroups params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            [userDefaults setObject:response.payload forKey:UserDefaultKey_plateData];
        }
    }];
    return nil;
}

- (void)clickRight
{
    [self.view endEditing:YES];

    if (!self.fid.length) {
        [USSuspensionView showWithMessage:@"请选择分区"];
        return;
    } else if (!_textView.text.length) {
        [USSuspensionView showWithMessage:@"请填写内容"];
        return;
    }
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/api/%@/%@",url_submitpost,_loginUser.username,_loginUser.signCode,_textView.text,_fid];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            if ([response.payload[@"data"][@"status"] integerValue] == 1) {
                [USSuspensionView showWithMessage:@"发帖成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [USSuspensionView showWithMessage:@"发帖失败"];
            }
            
        } else {
            [USSuspensionView showWithMessage:@"发帖失败"];
        }
    }];
    
}

- (void)clickLeft
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)textFieldDidChange:(NSNotification *)not
{
    UITextField * textField =  not.object;
    if (![textField isEqual:_textField]) {
        return;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //    [self didClick:nil];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        //        [self didClick:nil];
        return NO;
    }
    
    
    return YES;
}

- (IBAction)clickChoose:(id)sender
{
    [self.view endEditing:YES];
    FFPlateModel * model = [self requestData];

    if (model.data.count) {
        NSMutableArray *strArray = [NSMutableArray new];
        
        for (FFPlateSectionModel *sectionModel in model.data) {
            for (FFPlateItemModel *itemModel in sectionModel.forums) {
                [strArray addObject:itemModel];
            }
        }
        
        [FFActiveChooseView showActiveChooseView:strArray choose:^(FFPlateItemModel *model) {
            self.fid = model.fid;
            [_chooseBtn setTitle:model.oriName forState:UIControlStateNormal];
            [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }];
//        for (FFPlateSectionModel *itemModel in model.data) {
//            [strArray addObject:itemModel.name];
//        }
//        USActionSheet *actionSheet = [USActionSheet initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitleArray:strArray];
//        [actionSheet showWithCompletionBlock:^(NSInteger buttonIndex) {
//            if (buttonIndex < model.data.count) {
//                FFPlateSectionModel *itemModel = model.data[buttonIndex];
//                self.fid = itemModel.fid;
//                [_chooseBtn setTitle:itemModel.name forState:UIControlStateNormal];
//                [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            }
//         }];
    }

}



@end
