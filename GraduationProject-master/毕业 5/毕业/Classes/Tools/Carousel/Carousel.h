//
//  Carousel.h
//  轮播器
//
//  Created by 吴添培的黑苹果 on 2017/9/26.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Carousel;
@protocol CarouselDelegate <NSObject>

@optional
- (void)CarouselView:(Carousel *)carouselView didSelectItemAtIndex:(NSInteger)index;

@end

@interface Carousel : UIView

@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,assign)CGFloat timeInterval;

@property(nonatomic,weak)id<CarouselDelegate> delegate;

@end
