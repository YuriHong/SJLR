//
//  MassTableViewCell.m
//  毕业设计
//
//  Created by 龙波 on 2017/8/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "MassTableViewCell.h"
#import "MassMainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define kmasstabeleCell @"masstableCellID"
@implementation MassTableViewCell

+(instancetype)cellWithTabelView:(UITableView *)tableview
{
    
    MassTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier: kmasstabeleCell];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myView = [[UIView alloc]init];
        [self.myView setBackgroundColor:[UIColor whiteColor]];
        
        
        
        //社团活动的标题
        self.titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5+10, 40, SCREEN_WIDTH*0.5-20, 22)];
        self.titileLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
        self.titileLabel.textColor = [UIColor blackColor];
        
        self.titileLabel.numberOfLines = 0;
        
        //社团活动的标题照片
        self.titileImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH * 0.5, SCREEN_WIDTH*0.5-60)];
        self.titileImage.contentMode = UIViewContentModeScaleToFill;

        
        //社团活动时间
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5+10, 75, SCREEN_WIDTH*0.5-80, 17)];
        self.timeLabel.font = [UIFont systemFontOfSize:12.0];
        self.timeLabel.textColor = COLOR(139, 139, 139, 1);
        self.timeLabel.numberOfLines = 0;
        
        //社团活动的地点
        self.placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5+10, 95, SCREEN_WIDTH*0.5-80, 17)];
        self.placeLabel.font = [UIFont systemFontOfSize:12.0];
        self.placeLabel.textColor = COLOR(139, 139, 139, 1);
        self.placeLabel.numberOfLines = 0;
        
        
        //社团名字
        self.MassnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5+10, 115, SCREEN_WIDTH*0.5, 17)];
        self.MassnameLabel.font = [UIFont systemFontOfSize:12.0];
        self.MassnameLabel.textColor = COLOR(139, 139, 139, 1);
        self.MassnameLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_myView];
        [self.myView addSubview:_titileLabel];
        [self.myView addSubview:_titileImage];
        [self.myView addSubview:_timeLabel];
        [self.myView addSubview:_placeLabel];
        [self.myView addSubview:_MassnameLabel];
        
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(132, rect.size.height, rect.size.width-132, (1/[UIScreen mainScreen].scale))); //SINGLE_LINE_HEIGHT 为线的高度
}

-(void)reloadDataWithModel:(MassMainModel *)model
{
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",model.mainImage];
    [self.titileImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.titileLabel.text = model.name;
    self.placeLabel.text = model.subtitle;
    
}




@end
