//
//  InstituteViewCell.h
//  毕业
//
//  Created by 吴添培的黑苹果 on 2017/10/5.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InstituteViewCellDelegate <NSObject>

-(void)getButtonTitle:(NSString *)buttonTitle;

@end


@interface InstituteViewCell : UICollectionViewCell

@property (nonatomic, weak) id<InstituteViewCellDelegate> delegate;

@property (nonatomic, copy) NSArray *array;
@end
