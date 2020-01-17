//
//  AllOrderFooterView.h
//  test-个人
//
//  Created by 龙波 on 2017/10/31.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickBlock)(BOOL select);


@interface AllOrderFooterView : UITableViewHeaderFooterView

@property (copy,nonatomic)buttonClickBlock dwqClickBlock;


@end
