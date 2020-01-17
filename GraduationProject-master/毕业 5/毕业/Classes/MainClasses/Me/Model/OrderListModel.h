//
//  OrderListModel.h
//  test-个人
//
//  Created by 龙波 on 2017/11/1.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject

@property(nonatomic,strong) NSString *orderNo;

@property(nonatomic,strong) NSString *payment;

@property(nonatomic,strong) NSString *status;

@property(nonatomic,strong) NSString *statusDesc;





@property(nonatomic,strong) NSMutableArray *orderItemVoList;



@end
