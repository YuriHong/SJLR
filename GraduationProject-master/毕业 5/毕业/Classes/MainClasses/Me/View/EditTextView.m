//
//  EditTextView.m
//  test-个人
//
//  Created by 龙波 on 2017/10/23.
//  Copyright © 2017年 ----龙波. All rights reserved.
//

#import "EditTextView.h"

#import "AppDelegate.h"
#import "TopTextView.h"

@interface EditTextView()<UIGestureRecognizerDelegate>

@property (nonatomic,weak)UIViewController *controller;
@end

@implementation EditTextView

-(instancetype)initWithController:(UIViewController *)controller{
    self=[super init];
    if(self){
        //黑色半透明背景
        AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
        UIButton *grayBgView=[UIButton buttonWithType:UIButtonTypeCustom];
        grayBgView.frame=[UIScreen mainScreen].bounds;
        grayBgView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [app.window.rootViewController.view addSubview:grayBgView];
        grayBgView.hidden=YES;
        self.grayBgView=grayBgView;
        
        
        [grayBgView addTarget:self action:@selector(popAndPushPickerView) forControlEvents:UIControlEventTouchUpInside];
        
        TopTextView *topTextView=[[TopTextView alloc]initWithFrame:CGRectMake(15, controller.view.bounds.size.height/3, controller.view.bounds.size.width-30, controller.view.bounds.size.height/4)];
     
        self.topTextView=topTextView;
        topTextView.submitBlock=^(NSString *text){
            [self popAndPushPickerView];
            if(self.requestDataBlock){
                self.requestDataBlock(text);
            }
        };
        topTextView.closeBlock=^(){
            [self popAndPushPickerView];
        };
        [self.grayBgView addSubview:topTextView];
        
    }
    return self;
}

+(instancetype)showWithController:(UIViewController *)controller{
    EditTextView *editTextView=[[self alloc]initWithController:controller];
    editTextView.controller=controller;
    [controller.view addSubview:editTextView];
    [editTextView popAndPushPickerView];
    return  editTextView;
}


+(void)showWithController:(UIViewController *)controller andRequestDataBlock:(void(^)(NSString *text))requestDataBlock{
    EditTextView *edit=[EditTextView showWithController:controller];
    edit.requestDataBlock=requestDataBlock;
}



-(void)popAndPushPickerView{
    if(self.grayBgView.hidden){
        [UIView animateWithDuration:0.5 animations:^{
            self.grayBgView.hidden=NO;
            self.topTextView.hidden=NO;
        }];
        [self.grayBgView setUserInteractionEnabled:YES];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.topTextView.hidden=YES;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.grayBgView.hidden=YES;
            }];
        }];
        
    }
    
}

@end

