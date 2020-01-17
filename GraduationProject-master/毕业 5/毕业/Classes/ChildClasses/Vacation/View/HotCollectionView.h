//
//  HotCollectionView.h
//  毕业
//
//  Created by 龙波 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PassProductId)(NSString *productId);
@interface HotCollectionView : UICollectionView


@property(nonatomic,strong) NSMutableArray *productIdArray;


- (instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize withImageArr:(NSArray *)imagerArr WithProductIdArray:(NSMutableArray *)IdAarry;

@property(nonatomic,strong) PassProductId block;


@end
