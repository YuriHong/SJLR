//
//  InstTopView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstTopView.h"
#import "InstDetailModel.h"
#import "NSString+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface InstTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *courseCount;

@end

@implementation InstTopView

-(void)setModel:(InstDetailModel *)model{
    _model = model;
    NSString *urlString = [NSString concatenationImageString:model.imageName];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.title.text = model.name;
    self.courseCount.text = [NSString stringWithFormat:@"%ld",(unsigned long)model.courseID.count];
}

+(instancetype)getInstTopView{
    return [[NSBundle mainBundle] loadNibNamed:@"InstTopView" owner:nil options:nil].lastObject;
}

@end
