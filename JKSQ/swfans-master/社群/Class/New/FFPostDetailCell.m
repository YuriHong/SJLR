//
//  FFPostDetailCell.m
//  FZFBase
//
//  Created by fengzifeng on 2017/8/24.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFPostDetailCell.h"
#import "ZYPAttributeLabel.h"
#import "FFPostModel.h"
#import "FFPostDetailViewController.h"
#import "USEULAView.h"

@interface FFPostDetailCell ()
{
    FFPostItemModel *_model;
}
@property (strong, nonatomic) USEULAView *eulaView;

@end

@implementation FFPostDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    _contLabel.isHtml = YES;
    _upImaegView.image = [_upImaegView.image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5, -5)];

}

- (void)updateCell:(FFPostItemModel *)model
{
//    _contLabel.isHtml = YES;

    _model = model;
    _postButton.layer.masksToBounds = YES;
    _postButton.layer.cornerRadius = 5;
    _faceButton.layer.masksToBounds = YES;
    _faceButton.layer.cornerRadius = 17;
    _nameLabel.text = model.author;
//    _contLabel.textcolor = HexColor(0x5a5a5a);
//    _contLabel.textfont = [UIFont systemFontOfSize:14];
//    _contLabel.text1 = model.message;
//    [_contLabel autoSetDimension:ALDimensionHeight toSize:model.contentHeight];
    [_faceButton sd_setImageWithURL:[NSURL URLWithString:model.userImagePath] forState:UIControlStateNormal];
    _timeLabel.text = [NSString stringWithFormat:@"发表于 %@",model.dateline];
    NSString *newString = [model.message stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",SCREEN_WIDTH - 20]];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[model.message dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _contLabel.attributedText = attributedString;
//    _contLabel.backgroundColor = [UIColor yellowColor];
}

+ (CGFloat)getCellHeight:(FFPostItemModel *)model
{

    CGFloat height = 70;
    ZYPAttributeLabel *label = [[ZYPAttributeLabel alloc] init];
    label.isHtml = YES;
    CGSize size;
    if (model.message.length) size = [label sizeWithWidth:SCREEN_WIDTH - 15 attstr:model.message textFont:[UIFont systemFontOfSize:14]];
    
    if (model.isComment) {
        height += size.height + 12;
    } else {
        height += size.height + 52;
    }
    
    return height;
}

- (IBAction)clickPost:(id)sender
{
    if (!_loginUser) {
        [USSuspensionView showWithMessage:@"请先登录"];
        [self.nearsetViewController.navigationController popToRootViewControllerAnimated:YES];
        [TAB_VC swithchTapIndex:4];
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserPost" object:nil];
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"社区有权修改或删除社区中的违法内容以及认为不适当的内容；\n凡用户发布的信息出现以下情况之一的，管理人员有权不通知作者直接删除，并有权关闭其部分权限、暂停直至取消该帐号；\n社区用户发布的任何信息，不得含有任何违反国家法律法规政策的信息，包括但不限于下列信息：\n(1) 反对宪法所确定的基本原则的；\n(2) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n(3) 损害国家荣誉和利益的；\n(4) 煽动民族仇恨、民族歧视，破坏民族团结的；\n(5) 破坏国家宗教政策，宣扬邪教和封建迷信的；\n(6) 散布谣言，扰乱社会秩序，破坏社会稳定的；\n(7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖、毒品或者教唆犯罪的；\n(8) 侮辱或者诽谤他人，侵害他人合法权益的；\n(9) 含有盗版、图片、图书和/或其它任何侵犯第三方任何合法权益作品的。\n(10)含有法律、行政法规禁止的其他内容的。\n (11)其他社区明确禁止的。（社区有权随时调整违规信息定义，但会尽合理范围内的最大努力，将前述内容变化提前告知社区用户。）" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alert addAction:sure];
//    ((FFPostDetailViewController *)self.nearsetViewController).boardView.top = 0;
//    [((FFPostDetailViewController *)self.nearsetViewController).boardView.textView becomeFirstResponder];
}

- (IBAction)clickReport:(id)sender
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/api/%@",url_submitarticle,_loginUser.username,_loginUser.signCode,_model.message];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSNumber *flag = [userDefaults objectForKey:@"jiluapp"];

    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            
            if ([response.payload[@"data"][@"status"] integerValue] == 1) {
                [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                
            } else {
                if ([flag integerValue] != 0) {
                    [USSuspensionView showWithMessage:@"举报失败"];
                    
                } else {
                    
                    [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                    
                }
//                [USSuspensionView showWithMessage:@"举报失败"];
                
            }
        } else {
            if ([flag integerValue] != 0) {
                [USSuspensionView showWithMessage:@"举报失败"];
                
            } else {
                
                [USSuspensionView showWithMessage:@"举报成功,我们会在24小时内处理"];
                
            }
            
        }
    }];


}
@end
