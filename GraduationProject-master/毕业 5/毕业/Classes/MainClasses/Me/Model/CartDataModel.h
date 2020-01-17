//
//  CartDataModel.h
//  test-个人
//
//  Created by 龙波 on 2017/10/25.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartDataModel : NSObject
@property (assign,nonatomic)BOOL select;


@property(nonatomic,copy) NSNumber *allChecked;
@property(nonatomic,strong) NSMutableArray *cartProductVoList;
@property(nonatomic,strong) NSNumber *cartTotalPrice;
@property(nonatomic,strong) NSString *imageHost;


@end
