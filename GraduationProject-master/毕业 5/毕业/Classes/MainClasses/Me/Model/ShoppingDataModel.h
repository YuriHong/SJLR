//
//  ShoppingDataModel.h
//  test-个人
//
//  Created by 龙波 on 2017/10/29.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingDataModel : NSObject

@property(nonatomic,strong) NSMutableArray *list;
@property(nonatomic,strong) NSString *endRow;
@property(nonatomic,strong) NSString *firstPage;
@property(nonatomic,strong) NSString *hasNextPage;
@property(nonatomic,strong) NSString *hasPreviousPage;
@property(nonatomic,strong) NSString *isFirstPage;
@property(nonatomic,strong) NSString *isLastPage;
@property(nonatomic,strong) NSString *lastPage;
@property(nonatomic,strong) NSString *navigatePages;
@property(nonatomic,strong) NSMutableArray *navigatepageNums;
@property(nonatomic,strong) NSString *nextPage;
@property(nonatomic,strong) NSString *orderBy;
@property(nonatomic,strong) NSString *pageNum;
@property(nonatomic,strong) NSString *pageSize;
@property(nonatomic,strong) NSString *pages;
@property(nonatomic,strong) NSString *prePage;
@property(nonatomic,strong) NSString *size;
@property(nonatomic,strong) NSString *startRow;
@property(nonatomic,strong) NSString *total;





@end
