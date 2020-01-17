//
//  MassAcidityTextController.m
//  毕业设计
//
//  Created by 龙波 on 2017/9/22.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "MassAcidityTextController.h"
#import "detailVacationBottomView.h"
#import "MassDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MassAcidityTextController ()
@property(nonatomic,strong) detailVacationBottomView *wordView;
@property(nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation MassAcidityTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initData];
    [self loadData];
}

-(void)initData{
    _dataArray = [[NSMutableArray alloc]init];
}

- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"productId":_productID,
                             };
    
    [manager POST:@"http://47.93.33.181:8080/product/detail.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LLLLOader%@",responseObject);
       MassDetailModel  *detailModel = [MassDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        [_dataArray removeAllObjects];
        [_dataArray addObject:detailModel];
        
        [self setUpBaseUi];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];

}


- (void)setUpBaseUi
{
    MassDetailModel *detaiModle = _dataArray[0];
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 70)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.showsVerticalScrollIndicator = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:mainView];
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 160)];
    topImage.backgroundColor = RandColor;
    NSString *imagUrl = [NSString stringWithFormat:@"http://47.93.33.181/longboImage/%@",detaiModle.mainImage];
    [topImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"qianlan"]];
    [mainView addSubview:topImage];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 169, SCREENWIDTH, 50)];
    nameLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = detaiModle.name;
    [mainView addSubview:nameLabel];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(35, 220,SCREENWIDTH - 35*2, 100)];
    baseView.backgroundColor = [UIColor clearColor];
    [mainView addSubview:baseView];
    [baseView borderForColor:[UIColor blackColor] borderWidth:1.0f borderType:UIBorderSideTypeBottom];
    [baseView borderForColor:[UIColor redColor] borderWidth:1.0f borderType:UIBorderSideTypeLeft];
    
    _timeView = [[AcidityBaseView alloc]initWithFrame:CGRectMake(10, 25, SCREENWIDTH - 50*2, 30)];
    _timeView.backgroundColor = [UIColor clearColor];
    [baseView addSubview:_timeView];
    
    _placeView = [[AcidityBaseView alloc]initWithFrame:CGRectMake(10, 30 + 30,SCREENWIDTH - 50*2, 30)];
    _placeView.backgroundColor = [UIColor clearColor];
    [baseView addSubview:_placeView];
    
    NSString *starTime = [detaiModle.createTime substringWithRange:NSMakeRange(5, 11)];
    NSString *endTime = [detaiModle.updateTime substringWithRange:NSMakeRange(5, 11)];
    
    NSString *time = [NSString stringWithFormat:@"%@ 至 %@",starTime,endTime];
    
    [_timeView setupKey:@"活动时间" Value:time];
    [_placeView setupKey:@"活动地点" Value:detaiModle.subtitle];
    
    
    UILabel *wordLabel = [[UILabel alloc]init];
    wordLabel.font = [UIFont systemFontOfSize:14];
    wordLabel.numberOfLines = 0;
    wordLabel.textColor = [UIColor blackColor];
    
    _wordView = [detailVacationBottomView getDetailVacationBottomView];
    _wordView.y = baseView.bottomY + 20;
    _wordView.detailString = detaiModle.detail;
    mainView.contentSize = CGSizeMake(0, _wordView.bottomY);
    [mainView addSubview:_wordView];
    
    /*
    CGSize titleSize = [_wordStr boundingRectWithSize:CGSizeMake(SCREENWIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    wordLabel.size =titleSize;
    wordLabel.x = 0;
    wordLabel.y = baseView.bottomY+9;
    [self.view addSubview:wordLabel];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
