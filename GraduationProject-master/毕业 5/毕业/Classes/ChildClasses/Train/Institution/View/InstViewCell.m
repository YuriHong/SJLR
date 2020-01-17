//
//  InstViewCell.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "InstViewCell.h"
#import "InstDetailModel.h"
#import "NSString+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>
@class InstViewCell;

@interface InstViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation InstViewCell

+(instancetype)getInstViewCell{
    return [[NSBundle mainBundle] loadNibNamed:@"InstViewCell" owner:nil options:nil].lastObject;
}

-(void)setInstModel:(InstDetailModel *)instModel{
    _instModel = instModel;
    NSString *urlString = [NSString concatenationImageString:instModel.imageName];
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    self.title.text = instModel.name;
    self.address.text = instModel.address;
    self.phone.text = instModel.phone;

}

+(InstViewCell *)creatCellWithTableView:(UITableView *)tableView{
    static NSString *CellID = @"cellId";
    InstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell = [self getInstViewCell];
    
    return cell;
}



@end
