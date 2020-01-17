//
//  NoticCell.h
//  毕业设计
//
//  Created by 龙波 on 2017/9/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticCell : UITableViewCell
@property(nonatomic,strong) UITextView *noticeLabel;


+(instancetype)cellWithTabelView:(UITableView *)tableview;
@end
