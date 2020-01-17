//
//  MassAcidityTextController.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcidityBaseView.h"
#import "UIView+ BorderLine.h"


@interface MassAcidityTextController : UIViewController

@property(nonatomic,strong) AcidityBaseView *timeView;

@property(nonatomic,strong) AcidityBaseView *placeView;

@property(nonatomic,copy) NSString *productID;

@end
