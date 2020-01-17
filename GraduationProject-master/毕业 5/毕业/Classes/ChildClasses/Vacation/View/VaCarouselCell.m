//
//  VaCarouselCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/12.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "VaCarouselCell.h"
#import "Carousel.h"

#define kVaCarouselCell @"vacarouselCellID"

@interface VaCarouselCell ()

@end

@implementation VaCarouselCell


+(instancetype)cellWithTableView:(UITableView *)tableview
{
    VaCarouselCell *cell = [tableview dequeueReusableCellWithIdentifier: kVaCarouselCell];

    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        Carousel *carousel = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH ,180)];
       // carousel.delegate = self;
        //图片
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"carousel" ofType:@"plist"];
        NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        carousel.imageArray = array;
        
        [self addSubview:carousel];

    }
    return self;
}




@end
