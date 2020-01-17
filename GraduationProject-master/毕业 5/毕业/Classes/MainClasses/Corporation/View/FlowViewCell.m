//
//  FlowViewCell.m
//  毕业
//
//  Created by 龙波 on 2017/11/6.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "FlowViewCell.h"
#import "Carousel.h"

#define kflowviewcell @"flowviewCellId"

@interface FlowViewCell ()<CarouselDelegate,FlowViewCellDelegate>

@end

@implementation FlowViewCell




+(instancetype)cellWithTableView:(UITableView *)tableview
{
    FlowViewCell *cell = [tableview dequeueReusableCellWithIdentifier: kflowviewcell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        Carousel *carousel = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 130)];
        carousel.timeInterval = 2.0;
        //图片
        carousel.delegate = self;
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Masscarousel" ofType:@"plist"];
        NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        carousel.imageArray = array;
        [self.contentView addSubview:carousel];
    }
    return self;
}

- (void)CarouselView:(Carousel *)carouselView didSelectItemAtIndex:(NSInteger)index
{
    [self didCarouselIndex:index];
}

-(void)didCarouselIndex:(NSInteger)produId
{
    if ([self.delegate respondsToSelector:@selector(didCarouselIndex:)]) {
        [self.delegate didCarouselIndex:produId];
    }
}


@end
