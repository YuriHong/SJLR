//
//  VaCarouselCell.h
//  毕业
//
//  Created by 龙波 on 2017/10/12.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VaCarouselCellDelegate <NSObject>

-(void)didSelectAtIndexCarousel:(NSInteger)toIndex;

@end

@interface VaCarouselCell : UITableViewCell


@property(nonatomic,weak)id<VaCarouselCellDelegate>delegate;

+(instancetype)cellWithTableView:(UITableView *)tableview;
@end
