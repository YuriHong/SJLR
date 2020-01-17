//
//  SYWLCenterMenu.h
//  毕业设计
//
//  Created by 吴添培 on 2017/7/1.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InstCenterMenuDelegate <NSObject>

-(void)setPushViewControllerWithButtonTitle:(NSString *)buttonTitle;

@end

@interface InstCenterMenu : UIView

@property(nonatomic,weak)id<InstCenterMenuDelegate>delegate;

@end
