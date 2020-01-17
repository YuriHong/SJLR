//
//  detailVacationCenterView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailVacationCenterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
+(instancetype)getDetailVacationCenterView;

@end
