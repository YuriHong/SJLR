//
//  KindSubclassFilterCell.m
//  毕业
//
//  Created by 龙波 on 2017/10/17.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "KindSubclassFilterCell.h"
#import "MerchantCataGroupModel.h"
@implementation KindSubclassFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath model:(MerchantCataGroupModel *)model{
    static NSString *kkindSubclassFilter = @"JFKindSubclassFilterCellID";
    KindSubclassFilterCell *cell = [tableView dequeueReusableCellWithIdentifier: kkindSubclassFilter];
    if (cell == nil) {
        cell = [[KindSubclassFilterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kkindSubclassFilter];
    }
    
    
    /*用这个方法给子分类 赋值的话 不能识别是哪一行的 所以用传NSIndexPath
     for (NSDictionary  *dict  in  model.list) {
     cell.textLabel.text = dict [@"name"];
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", dict [@"count"]];
     }
     */
    
    cell.textLabel.text = model.course[indexPath.row];
    NSLog(@"%@",model.course[indexPath.row]);
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [model.list [indexPath.row] objectForKey:@"count"]];
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    cell.backgroundColor = RGBColor(242, 242, 242);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
@end
