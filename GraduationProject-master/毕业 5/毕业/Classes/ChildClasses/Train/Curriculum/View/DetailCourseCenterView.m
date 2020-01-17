//
//  DetailCurriculumCenterView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "DetailCourseCenterView.h"
#import "UIView+ BorderLine.h"
#import "DetailCourseModel.h"
#import "InstDetailModel.h"
#import "NSString+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailCourseCenterView ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *stock;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *inst;
@property (weak, nonatomic) IBOutlet UIImageView *instImageView;
@end

@implementation DetailCourseCenterView

+ (instancetype)getDetailCourseCenterView{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailCourseCenterView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [_button borderForColor:[UIColor blueColor] borderWidth:1 borderType:UIBorderSideTypeAll];
}

- (IBAction)buttonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(pushDetailInstViewController)]) {
        [_delegate pushDetailInstViewController];
    }
}

-(void)setCourseModel:(DetailCourseModel *)courseModel{
    _courseModel = courseModel;
    self.price.text = [NSString stringWithFormat:@"%@",@(courseModel.price)];
    self.stock.text = [NSString stringWithFormat:@"%d",courseModel.stock];
}

-(void)setInstModel:(InstDetailModel *)instModel{
    _instModel = instModel;
    self.address.text = instModel.address;
    self.phone.text = instModel.phone;
    self.inst.text = instModel.name;
    NSString *urlString = [NSString concatenationImageString:instModel.imageName];
    [self.instImageView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
}

@end
