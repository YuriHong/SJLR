//
//  BootPageViewController.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/3.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "BootPageViewController.h"
#import "bootPageCollectionViewCell.h"

static NSString *ID = @"Cell";
@interface BootPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionV;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSArray *array;

@end

@implementation BootPageViewController

-(NSArray *)array{
    if (_array == nil) {
        //_array = [NSArray array];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bootPage" ofType:@"plist"];
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistPath];
        _array = array;
    }
    return _array;
}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = _array.count;
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_array.count];
        _pageControl.bounds = CGRectMake(0, 0, pageControlSize.width, pageControlSize.height);
        _pageControl.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.95);
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPage = 0;
        _pageControl.enabled = NO;
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

-(UICollectionView *)collectionV{
    if (_collectionV == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[bootPageCollectionViewCell class] forCellWithReuseIdentifier:ID];
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.bounces = NO;
        [self.view insertSubview:collectionView atIndex:0];
        
        self.collectionV = collectionView;
    }
    return _collectionV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self array];
    [self collectionV];
    [self pageControl];
   
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX = offsetX + scrollView.frame.size.width * 0.5;
    NSInteger page = offsetX / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    bootPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:_array[indexPath.row]];
    
    [cell setIndexPath:indexPath count:_array.count];
    
    return cell;
    
}
@end
