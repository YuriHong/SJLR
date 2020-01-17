//
//  ClassFilterView.h
//  毕业
//
//  Created by 龙波 on 2017/10/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassFilterViewDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withKeyWord:(NSString *)keyWord ;

@end
@interface ClassFilterView : UIView

/**
 *  全部分类的tableView
 */
@property(nonatomic, strong) UITableView *tableViewOfGroup;

/**
 *  每组详情的tableView
 */
@property(nonatomic, strong) UITableView *tableViewOfDetail;

@property (nonatomic, weak) id <ClassFilterViewDelegate> delegate;

@end
