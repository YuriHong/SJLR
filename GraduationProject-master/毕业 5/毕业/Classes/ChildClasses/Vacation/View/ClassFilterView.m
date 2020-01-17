//
//  ClassFilterView.m
//  毕业
//
//  Created by 龙波 on 2017/10/16.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "ClassFilterView.h"
#import "KindFilterCell.h"
#import "GroupModel.h"
#import "MerchantCataGroupModel.h"
#import "KindSubclassFilterCell.h"
@interface ClassFilterView ()<UITableViewDataSource, UITableViewDelegate>
{
//    NSMutableArray *_bigGroupArray;//左边分组tableview的数据源
    NSMutableArray *_smallGroupArray;//右边分组tableview的数据源
    
    NSInteger _bigSelectedIndex;
    NSInteger _smallSelectedIndex;
}
@property(nonatomic,strong) NSMutableArray *bigGroupArray;

@end

@implementation ClassFilterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        
        
        
//        _bigGroupArray = groupArray;

//        NSLog(@"%@",_bigGroupArray);
        [self initViews];
      //  [self getData];
    }
    return self;

}

- (NSMutableArray *)bigGroupArray
{
    if (!_bigGroupArray) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"ClassData" ofType:@"plist"];
        NSMutableArray *groupArray  = [NSMutableArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in groupArray) {
            GroupModel *gourmodel = [GroupModel GroupModelWithDict:dict];
//            gourmodel.name = [dict objectForKey:@"name"];
//            gourmodel.course = [dict objectForKey:@"course"];
            [arrayModel addObject:gourmodel];
        }
        _bigGroupArray = arrayModel;

    }
    return _bigGroupArray;
}

-(void)initViews{
    for (int i = 0 ; i < 2; i ++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i *self.frame.size.width/2,  0, self.frame.size.width/2, self.frame.size.height) style:UITableViewStylePlain];
        tableView.tag = 10 + i ;
        tableView.delegate = self;
        tableView.dataSource = self;
        if (i == 0 ) {
            self.tableViewOfGroup =tableView;
            self.tableViewOfGroup.backgroundColor = [UIColor whiteColor];
            
        }else{
            self.tableViewOfDetail =tableView;
            self.tableViewOfDetail.backgroundColor = RGBColor(242, 242, 242);
            
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        
    }
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    GroupModel *model = self.bigGroupArray;
    if (tableView.tag == 10) {
        return self.bigGroupArray.count;
    }else{
        if (_bigGroupArray.count == 0) {
            return 0;
        }
        GroupModel *merchanModel =self.bigGroupArray[_bigSelectedIndex];
        if (merchanModel.course == nil) {
            return 0;
        }else{
            return merchanModel.course.count;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 10) {
        GroupModel *name = _bigGroupArray[indexPath.row];
        KindFilterCell *cell = [KindFilterCell cellWithTableView:tableView bigGroupName:name.name];
        return cell;
    }else{
        MerchantCataGroupModel *courseArray = (MerchantCataGroupModel *)_bigGroupArray[_bigSelectedIndex];
//        courseArray.course objecti
        KindSubclassFilterCell *cell = [KindSubclassFilterCell cellWithTableView:tableView indexPath:indexPath model:courseArray];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10) {
        _bigSelectedIndex = indexPath.row;
        MerchantCataGroupModel *courseArray =  _bigGroupArray[_bigSelectedIndex];
        [self.tableViewOfDetail reloadData];
        if (courseArray.course == nil) {
            [self.tableViewOfDetail reloadData];
            [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath withKeyWord:courseArray.name];
        }else{
            [self.tableViewOfDetail reloadData];
        }
    }else{
        _smallSelectedIndex = indexPath.row;
        MerchantCataGroupModel *name = _bigGroupArray[_bigSelectedIndex];
        NSLog(@"我点击了：%ld",indexPath.row);
//        MerchantCataGroupModel *cataModel =  _bigGroupArray[_bigSelectedIndex];
//        NSDictionary *dict =  cataModel.course[_smallSelectedIndex];
        //NSNumber *ID = [dict objectForKey:@"id"];
        //        NSString *name = [dic objectForKey:@"name"];
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath withKeyWord:name.course[indexPath.row] ];
//
    }
    
}

@end
