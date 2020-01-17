//
//  ChangeControllerView.m
//  测试
//
//  Created by 吴添培的黑苹果 on 2017/10/10.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ChangeView.h"


static NSString * identify = @"collectionCell";
@interface ChangeView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *hangLabel;
@property (strong, nonatomic) UIColor *toolTintColor;
@property (strong, nonatomic) UIColor *selectedColor;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;

@property (strong, nonatomic) UIBarButtonItem *barButtonItem;

@property (strong, nonatomic) NSArray<__kindof UIView *> *subViewArray;

@property (nonatomic, strong) UIView *ssview;
@end

@implementation ChangeView

-(void)awakeFromNib{
    [super awakeFromNib];
    _toolTintColor = [UIColor blackColor];
    _toolBar.tintColor = _toolTintColor;
    
    _selectedColor = [UIColor redColor];
    _hangLabel.backgroundColor = _selectedColor;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identify];
}

-(void)setArray:(NSArray *)array{
    _array = array;
    [self setupToolBarItem];
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    _hangLabel.backgroundColor = _selectedColor;
}

- (void)setToolBarWithTintColor:(UIColor *)toolTintColor barTintColor:(UIColor *)toolBarTintColor{
    _toolTintColor = toolTintColor;
    _toolBar.tintColor = toolTintColor;
    _toolBar.barTintColor = toolBarTintColor;
}

+ (instancetype)getChangeView{
    return [[NSBundle mainBundle] loadNibNamed:@"ChangeView" owner:nil options:nil][0];
}

-(void)setupToolBarItem{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < _array.count; i++) {
        UIBarButtonItem *item;
        if (i == 0) {
            item = [[UIBarButtonItem alloc] initWithTitle:_array[i][@"title"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick:)];
            _barButtonItem = item;
            _barButtonItem.tintColor = _selectedColor;
        }
        else{
            item = [[UIBarButtonItem alloc] initWithTitle:_array[i][@"title"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick:)];
        }
        NSDictionary * attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HYQuanTangShiJ" size:18]};
        [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
        [mutableArray addObject:item];
    }
    _toolBar.items = mutableArray;
    _subViewArray = _toolBar.subviews;

    _lineLeading.constant = 20;
    _lineWidth.constant = _subViewArray[0].frame.size.width;
    
}

-(void)barButtonClick:(UIBarButtonItem *)barButton{
    for (int i = 0; i < _array.count; i++) {
        if ([_array[i][@"title"] isEqual:barButton.title]) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
}

-(void)setBarButtonItem:(UIBarButtonItem *)barButton{
    _barButtonItem.tintColor = _toolTintColor;
    barButton.tintColor = _selectedColor;
    _barButtonItem = barButton;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX = offsetX + scrollView.frame.size.width * 0.5;
    NSInteger page = offsetX / scrollView.frame.size.width;
    
    [self setBarButtonItem:_toolBar.items[page]];
    
    //下滑线位置变化
    _lineLeading.constant = _subViewArray[page].frame.origin.x;
    _lineWidth.constant = _subViewArray[page].frame.size.width;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    _ssview = _array[indexPath.row][@"view"];
   
    [cell addSubview: _ssview];
    
    return cell;
}





@end
