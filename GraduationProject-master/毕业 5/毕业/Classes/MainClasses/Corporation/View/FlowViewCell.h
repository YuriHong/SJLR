//
//  FlowViewCell.h
//  毕业
//
//  Created by 龙波 on 2017/11/6.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlowViewCellDelegate <NSObject>

- (void)didCarouselIndex:(NSInteger)produId;

@end
@interface FlowViewCell : UITableViewCell

@property(weak,nonatomic) id <FlowViewCellDelegate> delegate;


+(instancetype)cellWithTableView:(UITableView *)tableview;



@end
