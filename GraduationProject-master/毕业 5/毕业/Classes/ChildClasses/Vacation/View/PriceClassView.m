//
//  PriceClassView.m
//  毕业
//
//  Created by 龙波 on 2017/11/4.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "PriceClassView.h"


@interface PriceClassView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_GroupArray;//tableview的数据源
    
   
}

@end

@implementation PriceClassView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        
        _GroupArray = @[@"价格升序",@"价格降序"];
        
   
        [self initViews];
    }
    return self;
    
}

-(void)initViews{
    
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableViewOfGroup =tableView;
        self.tableViewOfGroup.backgroundColor = [UIColor whiteColor];
            
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _GroupArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _GroupArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath withWord:_GroupArray[indexPath.row]];
}

@end
