//
//  curriculumView.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/9/29.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "WTPListView.h"
#import "CourseCell.h"
#import "majorCell.h"
#import "DetailCourseModel.h"
#import "SchoolsCell.h"
#import "SchoolsModel.h"

@interface WTPListView ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString *nibName;
@property (nonatomic, copy) NSString *identify;
	
@end

@implementation WTPListView

+(instancetype)getWTPListView{
    return [[NSBundle mainBundle] loadNibNamed:@"WTPListView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
   
}

-(void)setNibWithNibName:(NSString *)nibName identify:(NSString *)identify{
    _nibName = nibName;
    _identify = identify;
     [_tableView registerNib:[UINib nibWithNibName:_nibName bundle:nil] forCellReuseIdentifier:_identify];
}

-(void)setLabelText:(NSString *)labelText{
    _labelText = labelText;
    _titleLabel.text = labelText;
}

- (IBAction)moreClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(pushListViewControllerWithTitle:)]) {
        [_delegate pushListViewControllerWithTitle:_labelText];
    }
}

-(void)setArray:(NSArray *)array{
    _array = array;
    [self.tableView reloadData];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_nibName isEqual:@"CourseCell"]) {
        CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify];
        DetailCourseModel *detail = _array[indexPath.row];
        cell.detail = detail;
        return cell;
    }
    else if ([_nibName isEqual:@"majorCell"]){
        majorCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify];
        DetailCourseModel *model = _array[indexPath.row];
        cell.model = model;
        return cell;

    }
    else if ([_nibName isEqual:@"SchoolsCell"]){
        SchoolsCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify];
        SchoolsModel *model = _array[indexPath.row];
        cell.model = model;
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_nibName isEqual:@"CourseCell"] || [_nibName isEqual:@"majorCell"]) {
        DetailCourseModel *detailModel = _array[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%d",detailModel.id];
        
        if ([_delegate respondsToSelector:@selector(pushListDetailViewControllerWithtitle:andID:)]) {
            [_delegate pushListDetailViewControllerWithtitle:_titleLabel.text andID:str];
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(pushListDetailViewControllerWithtitle:andID:)]) {
            [_delegate pushListDetailViewControllerWithtitle:_titleLabel.text andID:nil];
        }
    }
    
}


@end
