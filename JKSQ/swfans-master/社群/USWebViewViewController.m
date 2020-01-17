//
//  USWebViewViewController.m
//  JKSQ
//
//  Created by YU on 2019/8/15.
//  Copyright © 2019 fengzifeng. All rights reserved.
//

#import "USWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface USWebViewViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *wkwebView;
@property (strong, nonatomic) UIActivityIndicatorView *active;
@end

@implementation USWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBackButtonDefault];
    CGFloat top = 0;
    if (_hidenBar) {
        top = ([UIApplication sharedApplication].statusBarFrame.size.height == 44) ? 44 : 20;
    }else {
        top = ([UIApplication sharedApplication].statusBarFrame.size.height == 44) ? 88 : 64;
    }
    WKWebViewConfiguration *c = [[WKWebViewConfiguration alloc]init];
    self.wkwebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:c];
    [self.view addSubview:_wkwebView];
    _wkwebView.UIDelegate = self;
    _wkwebView.navigationDelegate = self;
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    self.active = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_active];
    _active.center = self.view.center;
    [_active startAnimating];
    if (_hidenBar) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.wkwebView.scrollView.backgroundColor = [UIColor blackColor];
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];
        self.view.backgroundColor = [UIColor blackColor];
        self.navigationBar.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_active stopAnimating];
    _active.hidden = YES;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (!_hidenBar) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    NSURL *url = navigationAction.request.URL;
    if (![url.absoluteString hasPrefix:@"http"] && [url.absoluteString containsString:@"://"]) {
        [[UIApplication sharedApplication] openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
