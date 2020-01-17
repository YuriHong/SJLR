//
//  PayViewController.m
//  test-个人
//
//  Created by 龙波 on 2017/10/30.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "PayViewController.h"
#import "UIView+SYWLExtension.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "PersonController.h"
@interface PayViewController ()
@property(nonatomic,strong) NSString *imageUrlStr;
@property(nonatomic,strong) NSString *OrderNoStr;


@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"orderNO%@",self.orderNO);
    [self loadData];

}


- (void)loadData
{
    NSDictionary *params = @{@"orderNo":self.orderNO};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/pay.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LLLLOader%@",responseObject);
        
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        self.imageUrlStr = dataDic[@"qrUrl"];
        self.OrderNoStr = dataDic[@"orderNo"];
        //
        [self setUpUi];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
}

- (void)setUpNavBtn
{
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"支付完成" style:UIBarButtonItemStyleDone target:self action:@selector(payFinish)];
    self.navigationItem.rightBarButtonItem = rightBtn;

}

- (void)setUpUi
{
    [self setUpNavBtn];
    
    UIImageView *payImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/5+20, SCREENHEIGHT/4, SCREENWIDTH/2, SCREENWIDTH/2)];
//    payImage.backgroundColor = RandColor;
    
    NSLog(@"imagurl:%@",self.imageUrlStr);
    NSURL *imageurl = [NSURL URLWithString:self.imageUrlStr];
    [payImage sd_setImageWithURL:imageurl];
    [self.view addSubview:payImage];
    
    UILabel *orderLable = [[UILabel alloc]initWithFrame:CGRectMake(payImage.x, payImage.y-60, 300, 40)];
//    orderLable.backgroundColor = RandColor;
    orderLable.textAlignment =NSTextAlignmentLeft;
//    NSLog(@"orderno:%@",self.OrderNoStr);
    orderLable.text = [NSString stringWithFormat:@"订单编号：%@",self.OrderNoStr];
    [self.view addSubview:orderLable];

    


}

-(void)payFinish
{
    
    
    NSDictionary *params = @{@"orderNo":self.orderNO};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/order/query_order_pay_status.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LLLLOader%@",responseObject);
        NSInteger status = [responseObject[@"data"] integerValue];
        if (status == 1 ) {
            [UIAlertController creatDoneAlertControllerTitle:@"提示" withMessage:@"支付成功" target:self callBack:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToRootViewControllerAnimated:YES];

            }];
        }else{
            [UIAlertController creatDoneAndCancerAlertControllerTitle:@"提示" withMessage:@"支付失败，是否放弃支付?" target:self callBack:^(UIAlertAction * _Nonnull action) {
                if ([action.title isEqualToString:@"确定"]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];

                }else
                {
                    NSLog(@"取消了");
                }

            }];
        
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
