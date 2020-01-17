//
//  InstCenterView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstDetailModel;
@interface InstCenterView : UIView
@property(nonatomic, strong) InstDetailModel *model;

+(instancetype)getInstCenterView;

@end
