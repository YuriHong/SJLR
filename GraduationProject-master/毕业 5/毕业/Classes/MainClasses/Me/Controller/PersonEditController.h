//
//  PersonEditController.h
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditBtn.h"
#import "LBUerNetModel.h"

@interface PersonEditController : UIViewController

@property(nonatomic,strong) EditBtn *iconEditBtn;

@property(nonatomic,strong) EditBtn *iphoneEditBtn;
@property(nonatomic,strong) EditBtn *emailEditBtn;
@property(nonatomic,strong) EditBtn *anserEditBtn;
@property(nonatomic,strong) EditBtn *keyEditBtn;

@property(nonatomic, strong) LBUerNetModel *model;

@end
