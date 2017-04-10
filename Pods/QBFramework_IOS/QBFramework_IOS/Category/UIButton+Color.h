//
//  UIButton+Color.h
//  QBFramework
//  触摸视图背景色改变
//  Created by quentin on 2017/3/22.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Color)

- (void)sr_setTouchDownBackgroundColor:(UIColor *)touchDownBackgroundColor;
- (void)sr_setTouchDownTextColor:(UIColor *)touchDownTextColor;

@end
