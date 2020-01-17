//
//  HotCollectionView.m
//  毕业
//
//  Created by 龙波 on 2017/10/13.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "HotCollectionView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailVacationController.h"
#define kHotCollectionViewCell @"hotcollectionviewCellID"
@interface HotCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) CGSize ItemSize;
@property (nonatomic, strong) NSArray *ImageArray;


@end

@implementation HotCollectionView

-(UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = self.ItemSize;
        _layout.minimumLineSpacing = 10.0;
        _layout.minimumInteritemSpacing =0.0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    return _layout;
    
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize withImageArr:(NSArray *)imagerArr WithProductIdArray:(NSMutableArray *)IdAarry
{
    self.productIdArray = IdAarry;
    _ItemSize = itemSize;
    if (self = [super initWithFrame:frame collectionViewLayout:self.layout]) {
        _ImageArray = imagerArr;
        self.bounces = NO;
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: kHotCollectionViewCell];
        
    }
    return self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ImageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotCollectionViewCell forIndexPath:indexPath];
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",_ImageArray[indexPath.row]];
    UIImageView *imageV =[[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    CGRect imageFrame = imageV.frame;
    imageFrame.size = _ItemSize;
    imageV.frame = imageFrame;
    
//    UILabel *nameLabel = [[UILabel alloc]initWithFrame:<#(CGRect)#>];
    [cell.contentView addSubview:imageV];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了%@",self.productIdArray[indexPath.row]);
    self.block(self.productIdArray[indexPath.row]);
    
}


@end
