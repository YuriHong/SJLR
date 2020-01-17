//
//  dropDownMenu.m
//  校园帮
//
//  Created by 吴添培 on 2017/7/18.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "dropDownMenu.h"
#import "UIView+SYWLExtension.h"

#define AnimateTime 0.25f   // 下拉动画时间

@interface dropDownMenu ()
@property(nonatomic,strong)UIImageView * arrowMark;   // 尖头图标
@property(nonatomic,strong)UIView      * listView;    // 下拉列表背景View
@property(nonatomic,strong)UITableView * tableView;   // 下拉列表
@property(nonatomic,strong)NSArray     * titleArr;    // 选项数组
@property(nonatomic,assign)CGFloat       rowHeight;   // 下拉列表行高

@end

@implementation dropDownMenu

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainBtnWithFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self createMainBtnWithFrame:frame];
}

-(void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    [_mainBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (void)createMainBtnWithFrame:(CGRect)frame{
    
    [_mainBtn removeFromSuperview];
    _mainBtn = nil;
    
    // 主按钮 显示在界面上的点击按钮
    // 样式可以自定义
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:UIControlEventTouchUpInside];
    _mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _mainBtn.titleLabel.font    = [UIFont boldSystemFontOfSize:16.f];
    _mainBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _mainBtn.selected           = NO;
    _mainBtn.backgroundColor    = [UIColor whiteColor];
    _mainBtn.layer.borderColor  = [UIColor blackColor].CGColor;
    _mainBtn.layer.borderWidth  = 1;
    [self addSubview:_mainBtn];
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(_mainBtn.width - 15, 0, 9, 9)];
    _arrowMark.center = CGPointMake(_arrowMark.center.x, _mainBtn.height / 2);
    _arrowMark.image  = [UIImage imageNamed:@"dropdownMenu_cornerIcon.png"];
    [_mainBtn addSubview:_arrowMark];
}

- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight
{
    if (self == nil) {
        return;
    }
    
    _titleArr  = [NSArray arrayWithArray:titlesArr];
    _rowHeight = rowHeight;
    
    // 下拉列表背景View
    _listView = [[UIView alloc] init];
    _listView.frame = CGRectMake(self.x , self.y + self.height, self.width,  0);
    _listView.clipsToBounds       = YES;
    _listView.layer.masksToBounds = NO;
    _listView.layer.borderColor   = [UIColor blackColor].CGColor;
    _listView.layer.borderWidth   = 0.5f;
    
    // 下拉列表TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _listView.width, _listView.height)];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.bounces         = NO;
    [_listView addSubview:_tableView];
}

- (void)clickMainBtn:(UIButton *)button{
    
    [self.superview addSubview:_listView]; // 将下拉视图添加到控件的俯视图上
    
    if(button.selected == NO) {
        [self showDropDown];
    }
    else {
        [self hideDropDown];
    }
}

- (void)showDropDown{   // 显示下拉列表
    [_listView.superview bringSubviewToFront:_listView]; // 将下拉列表置于最上层
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuWillShow:)]) {
        [self.delegate dropDownMenuWillShow:self]; // 将要显示回调代理
    }
    
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
        _listView.frame  = CGRectMake(_listView.x, _listView.y, _listView.width, _rowHeight *_titleArr.count);
        _tableView.frame = CGRectMake(0, 0, _listView.width, _listView.height);
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
            [self.delegate dropDownMenuDidShow:self]; // 已经显示回调代理
        }
    }];
    
    _mainBtn.selected = YES;
}
- (void)hideDropDown{  // 隐藏下拉列表
    if ([self.delegate respondsToSelector:@selector(dropDownMenuWillHidden:)]) {
        [self.delegate dropDownMenuWillHidden:self]; // 将要隐藏回调代理
    }
    
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _arrowMark.transform = CGAffineTransformIdentity;
        _listView.frame  = CGRectMake(_listView.x, _listView.y, _listView.width, 0);
        _tableView.frame = CGRectMake(0, 0, _listView.width, _listView.height);
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropDownMenuDidHidden:)]) {
            [self.delegate dropDownMenuDidHidden:self]; // 已经隐藏回调代理
        }
    }];
    
    _mainBtn.selected = NO;
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //---------------------------下拉选项样式，可在此处自定义-------------------------
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font          = [UIFont boldSystemFontOfSize:12.f];
        cell.textLabel.textColor     = [UIColor blackColor];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, _rowHeight -0.5, cell.width, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        [cell addSubview:line];
        //---------------------------------------------------------------------------
    }
    
    cell.textLabel.text =[_titleArr objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_mainBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:selectedCellNumber:)]) {
        [self.delegate dropDownMenu:self selectedCellNumber:indexPath.row]; // 回调代理
    }
    
    [self hideDropDown];
}





@end
