//
//  USEULAView.h
//  JKSQ
//
//  Created by YU on 2019/8/7.
//  Copyright © 2019 fengzifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EulaViewAction)(NSInteger tag);

@interface USEULAView : UIView
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

+ (instancetype)eulaView;

- (void)configureAtion:(EulaViewAction)action;

- (void)loadTextFromFile:(NSString *)name type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
