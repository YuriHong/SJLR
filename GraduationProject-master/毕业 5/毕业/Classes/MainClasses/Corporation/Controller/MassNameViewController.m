//
//  MassNameViewController.m
//  毕业设计
//
//  Created by 龙波 on 2017/8/21.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "MassNameViewController.h"
#import "MassTextController.h"

@interface MassNameViewController ()
@property(nonatomic,strong) NSArray *testArray;
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,strong) NSMutableArray *massArray;

@end

@implementation MassNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.testArray = [NSArray arrayWithObjects:@"金融投资社",@"篮球社",@"羽毛球社",@"支教社",@"社会实践社团", nil];
    self.imageArray = [NSArray arrayWithObjects:@"icon_massimage",@"icon_baskerImage",@"icon_badmintonImage",@"icon_VolunteerImage", @"icon_exposureimage",nil];
    _massArray = [[NSMutableArray alloc]init];
    [self initUI];
    [self setupNav];
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(49, 49, 32, 45)];
    testBtn.backgroundColor = [UIColor redColor];
   // [self.view addSubview:testBtn];

    
}

- (void)setupNav
{
    self.navigationItem.title = @"所有社团";
}



- (void)initUI{
    
    for (int i = 0; i < self.testArray.count; ++i) {
        
        int x = i%2;
        int y = i/2;
        //背景
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x*(SCREENWIDTH-15)/2+5*(x+1), y*125+25, (SCREENWIDTH-15)/2, 120)];
        backView.backgroundColor = RGBColor(249, 249, 249);
        backView.tag = 430001+i;
//        backView.hidden = YES;
        [self.view addSubview:backView];
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
        [backView addGestureRecognizer:tap];
        
        //图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height-40)];
        imageView.tag = 50+i;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius =(SCREENWIDTH-15)/4;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageStr = self.imageArray[i];
        imageView.image = [UIImage imageNamed:imageStr];
        
        [backView addSubview:imageView];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), backView.frame.size.width, 30)];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = self.testArray[i];
        titleLabel.tag = 100+i;
        [backView addSubview:titleLabel];
    }
    

}

- (void)OnTapBackView:(UITapGestureRecognizer *)sender{
   NSLog(@"第·%ld", (long)sender.view.tag);
    //[ _massArray addObject:<#(nonnull id)#>];
    [_massArray removeAllObjects];
    NSString *orderID = [NSString stringWithFormat:@"%ld",sender.view.tag];
    [_massArray addObject:orderID];
    [_massArray addObject:_testArray[sender.view.tag - 430001]];
    [_massArray addObject:_imageArray[sender.view.tag - 430001]];
    MassTextController *massView = [[MassTextController alloc]initWithFrame:self.view.frame WithArray:_massArray];
    NSLog(@"%@",self.testArray);
    [self.navigationController pushViewController:massView animated:YES];
    
}

@end
