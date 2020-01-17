//
//  detailVacationBottomView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/11/7.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailStrView.h"

@interface detailVacationBottomView : UIView

@property(nonatomic, copy) NSString *detailString;
@property (strong, nonatomic) detailStrView *detail;

+(instancetype)getDetailVacationBottomView;

@end
