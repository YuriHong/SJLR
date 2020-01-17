//
//  OrderTableViewCell.h
//  test-个人
//
//  Created by 龙波 on 2017/10/25.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CartListModel;


typedef void(^CellSelectedBlock)(BOOL select);
typedef void(^NumberChangedBlock)(NSInteger number);

@interface OrderTableViewCell : UITableViewCell

@property(nonatomic,strong) UIView *myView;

@property(nonatomic,strong) UILabel *titileLabel;
@property(nonatomic,strong) UILabel *priceLabel;

@property(nonatomic,strong) UILabel *numberLabel;
@property(nonatomic,strong) UILabel *nowPriceLabel;
@property(nonatomic,strong) UIImageView *mainImage;
@property (assign,nonatomic)NSInteger Number;


@property (assign,nonatomic)BOOL goodSelected;

//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;

+(instancetype)cellWithTableView:(UITableView *)tableview;


- (void)reloadDataWithModel:(CartListModel*)model;
- (void)cellSelectedWithBlock:(CellSelectedBlock)block;
- (void)numberAddWithBlock:(NumberChangedBlock)block;
- (void)numberCutWithBlock:(NumberChangedBlock)block;

@end
