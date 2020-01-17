//
//  InstCenterView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstCenterView.h"
#import "InstDetailModel.h"

@interface InstCenterView ()
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation InstCenterView

-(void)setModel:(InstDetailModel *)model{
    _model = model;
    self.address.text = _model.address;
    self.phone.text = _model.phone;

    
}

+(instancetype)getInstCenterView{
    return [[NSBundle mainBundle] loadNibNamed:@"InstCenterView" owner:nil options:nil][0];
}

@end
