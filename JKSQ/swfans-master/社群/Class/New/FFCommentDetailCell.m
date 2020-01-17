//
//  FFPostDetailCell.m
//  FZFBase
//
//  Created by fengzifeng on 2017/8/24.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFCommentDetailCell.h"
#import "ZYPAttributeLabel.h"
#import "FFPostModel.h"
#import "FFPostDetailViewController.h"

@interface FFCommentDetailCell ()
{
    FFPostItemModel *_model;
}
@property (weak, nonatomic) IBOutlet UIButton *jubaoButton;

@property (weak, nonatomic) IBOutlet UIButton *pinbiButton;

@end

@implementation FFCommentDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    _contLabel.isHtml = YES;
    _upImaegView.image = [_upImaegView.image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5, -5)];
//    [self.jubaoButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.jubaoButton.layer.cornerRadius = 3;
//    self.jubaoButton.layer.borderWidth = 0.5;
//    self.jubaoButton.layer.borderColor = [UIColor redColor].CGColor;
//    self.jubaoButton.layer.masksToBounds = YES;
//
//    [self.pinbiButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.pinbiButton.layer.cornerRadius = 3;
//    self.pinbiButton.layer.borderWidth = 0.5;
//    self.pinbiButton.layer.borderColor = [UIColor redColor].CGColor;
//    self.pinbiButton.layer.masksToBounds = YES;
}

- (void)updateCell:(FFPostItemModel *)model
{
//    _contLabel.isHtml = YES;

    _model = model;
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

}

- (IBAction)pingbi:(UIButton *)sender {
    [NSObject pingbiAuthor:_model.pid];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_pinbijubao object:nil];
}

- (IBAction)report:(UIButton *)sender {
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/api/%@",url_submitarticle,_loginUser.username,_loginUser.signCode,_model.message];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSNumber *flag = [userDefaults objectForKey:@"jiluapp"];
    [NSObject pingbiAuthor:_model.pid];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_pinbijubao object:nil];
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

@end
