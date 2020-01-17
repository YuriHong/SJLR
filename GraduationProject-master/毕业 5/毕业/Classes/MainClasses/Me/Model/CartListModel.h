//
//  CartListModel.h
//  test-个人
//
//  Created by 龙波 on 2017/10/25.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CartListModel : NSObject

@property (nonatomic,assign) BOOL select;


@property(nonatomic,strong) NSNumber *id;
@property(nonatomic,strong) NSString *limitQuantity;
@property(nonatomic,strong) NSNumber *productChecked;
@property(nonatomic,strong) NSNumber *productId;
@property(nonatomic,strong) NSString *productMainImage;
@property(nonatomic,strong) NSString *productName;
@property(nonatomic,strong) NSNumber *productPrice;
@property(nonatomic,strong) NSNumber *productStatus;
@property(nonatomic,strong) NSNumber *productStock;
@property(nonatomic,strong) NSArray *productSubtitle;
@property(nonatomic,strong) NSString *productTotalPrice;
@property(nonatomic,strong) NSNumber *quantity;
@property(nonatomic,strong) NSNumber *userId;
@property(nonatomic,strong) NSNumber *orderNo;








@end
