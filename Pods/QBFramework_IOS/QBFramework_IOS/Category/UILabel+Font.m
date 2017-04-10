//
//  UILabel+Font.m
//  QBFramework
//
//  Created by quentin on 16/7/22.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "UILabel+Font.h"

@implementation UILabel (Font)

+ (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    return label;
}

- (void)setText:(NSString *)text maxWidth:(CGFloat)width maxHeight:(CGFloat)height
{
    self.numberOfLines = 0;
    self.text = text;
    
    if (!self.font) {
        self.font = [UIFont systemFontOfSize:15];
    }
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:NULL];
    
    CGRect frame = self.frame;
    frame.size.width = rect.size.width;
    frame.size.height = rect.size.height;
    self.frame = frame;
    
}

- (void)setText:(NSString *)text maxWidth:(CGFloat)width
{
    [self setText:text maxWidth:width maxHeight:MAXFLOAT];
}


@end
