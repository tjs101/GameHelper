//
//  UILabel+Font.h
//  QBFramework
//
//  Created by quentin on 16/7/22.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Font)

+ (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)textColor;
- (void)setText:(NSString *)text maxWidth:(CGFloat)width maxHeight:(CGFloat)height;
- (void)setText:(NSString *)text maxWidth:(CGFloat)width;

@end
