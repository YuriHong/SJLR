//
//  onlineCurricllumController.m
//  毕业设计
//
//  Created by 吴添培的黑苹果 on 2017/9/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "onlineCurricllumController.h"
#import "onlineCollectionCell.h"
#import "onlineModel.h"
#import "OnlineDetailController.h"

static NSString *ID = @"Cell";

@interface onlineCurricllumController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionV;
@property(nonatomic,strong)NSMutableArray *modelArray;

@end

@implementation onlineCurricllumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网校课程";
    [self collectionV];
}

-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [onlineModel getModelWithArray];
    }
    return _modelArray;
}


-(UICollectionView *)collectionV{
    if (_collectionV == nil) {
        
        int column = 3;
        CGFloat Screen = [UIScreen mainScreen].bounds.size.width;
        int margin = 10;
        CGFloat itemW = (Screen - margin * (column + 1)) / column;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemW, itemW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 2 * margin;
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, 0, margin);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[onlineCollectionCell class] forCellWithReuseIdentifier:ID];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:collectionView];
        
        self.collectionV = collectionView;
    }
    return _collectionV;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    onlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
   
    cell.model = self.modelArray[indexPath.row];
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    OnlineDetailController *detail = [[OnlineDetailController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
