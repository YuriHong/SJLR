//
//  IndustryHotspotView.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/9/28.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndustryHotspotViewDelegate <NSObject>

- (void)clickLineRightWithtitle:(NSString *)titleName;

@end


@interface IndustryHotspotView : UIView

@property (nonatomic, copy)NSArray *list;

@property (nonatomic, weak) id<IndustryHotspotViewDelegate> delegate;

+ (instancetype)getIndustryHotspotView;

@end
