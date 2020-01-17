//
//  PriceClassView.h
//  毕业
//
//  Created by 龙波 on 2017/11/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceClassViewDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withWord:(NSString *)Word ;


@end

@interface PriceClassView : UIView

@property(nonatomic, strong) UITableView *tableViewOfGroup;
@property (nonatomic, weak) id <PriceClassViewDelegate> delegate;

@end
