//
//  FFNewListModel.m
//  FZFBase
//
//  Created by fengzifeng on 2017/8/17.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFNewListModel.h"
#import "FFNewListCell.h"

@implementation FFNewListModel

- (NSDictionary *)objectClassInArray
{
    return @{@"data" : [FFNewListItemModel class]};
}

@end

@implementation FFNewListItemModel

- (void)setSubject:(NSString *)subject
{
    _subject = subject;
    
    CGFloat tempHeight = [_subject stringHeightWithFont:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH - 18] + 14;
    tempHeight = tempHeight > 30?tempHeight:30;
    self.height = tempHeight + 70;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    if (_subject) {
        NSArray *array = [FFNewListCell getImageurlFromHtml:message];
        if (array.count) {
            self.height += (SCREEN_WIDTH-20)*337/600.0 + 5;
        }

    }
}

@end
