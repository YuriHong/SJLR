//
//  OrderFooterView.h
//  test-个人
//
//  Created by 龙波 on 2017/10/26.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickBlock)(BOOL select);
@interface OrderFooterView : UITableViewHeaderFooterView

@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)buttonClickBlock dwqClickBlock;
@property (assign,nonatomic)BOOL select;
@property(nonatomic,copy) NSString *statusTitle;

@end
