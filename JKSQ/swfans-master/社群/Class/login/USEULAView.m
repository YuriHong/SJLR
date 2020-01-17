//
//  USEULAView.m
//  JKSQ
//
//  Created by YU on 2019/8/7.
//  Copyright © 2019 fengzifeng. All rights reserved.
//

#import "USEULAView.h"

@interface USEULAView ()

@property (copy, nonatomic) EulaViewAction eulaAction;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation USEULAView

+ (instancetype)eulaView {
    return [[[NSBundle mainBundle]loadNibNamed:@"USEULAView" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.backgroundColor = [UIColor clearColor];
    self.contentTextView.layer.borderWidth = 0.5;
    self.contentTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.contentView.layer.cornerRadius = 4;
    self.contentView.layer.masksToBounds = YES;
}

- (void)configureAtion:(EulaViewAction)action
{
    self.eulaAction = action;
    self.contentTextView.editable = NO;
}

- (void)loadTextFromFile:(NSString *)name type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    self.contentTextView.text = str;
}

- (IBAction)sendAction:(UIButton *)sender {
    if (_eulaAction) {
        // 1 同意
        _eulaAction(sender.tag);
    }
}



@end
