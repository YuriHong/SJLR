//
//  DDMenuController.h
//  校园帮(用户)
//
//  Created by 吴添培 on 2017/8/9.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullDownMenu.h"

@protocol PullDownMenuControllerDelegate <NSObject>

-(void)PullDownMenuControllerWithString:(NSString *)string;

@end

@interface PullDownMenuController : UIViewController
@property(nonatomic, weak) id<PullDownMenuControllerDelegate> delegate;

@end
