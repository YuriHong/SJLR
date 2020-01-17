//
//  OnlineDetailController.m
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/25.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "OnlineDetailController.h"
#import <CLPlayer/CLPlayerView.h>

@interface OnlineDetailController ()
@property (nonatomic, strong) CLPlayerView *playerView;
@end

@implementation OnlineDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"免费课程";
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 300)];
    [self.view addSubview:playerView];
    _playerView = playerView;
    //视频地址
    playerView.url = [NSURL URLWithString:@"http://47.93.33.181/duoxiancheng.mp4"];
    //播放
    [playerView playVideo];
    //返回按钮点击事件回调
    [playerView backButton:^(UIButton *button) {
    }];
    //播放完成回调
    [playerView endPlay:^{
    
    }];
}

-(void)dealloc{
    [_playerView destroyPlayer];
}


@end
