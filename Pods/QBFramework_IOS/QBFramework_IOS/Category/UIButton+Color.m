//
//  UIButton+Color.m
//  QBFramework
//
//  Created by quentin on 2017/3/22.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "UIButton+Color.h"
#import <objc/runtime.h>

@implementation UIButton (Color)

static char normalBackgroundColorKey;// normal bg color key
static char touchDownBackgroundColorKey;// touch bg color key

static char normalTextColorKey;// normal text color key
static char touchDownTextColorKey;// touch text color key

- (UIColor *)normalBackgroundColor
{
    return objc_getAssociatedObject(self, &normalBackgroundColorKey);
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor
{
    objc_setAssociatedObject(self, &normalBackgroundColorKey, normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)touchDownBackgroundColor
{
    return objc_getAssociatedObject(self, &touchDownBackgroundColorKey);
}

- (void)setTouchDownBackgroundColor:(UIColor *)touchDownBackgroundColor
{
    objc_setAssociatedObject(self, &touchDownBackgroundColorKey, touchDownBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalTextColor
{
    return objc_getAssociatedObject(self, &normalTextColorKey);
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    objc_setAssociatedObject(self, &normalTextColorKey, normalTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)touchDownTextColor
{
    return objc_getAssociatedObject(self, &touchDownTextColorKey);
}

- (void)setTouchDownTextColor:(UIColor *)touchDownTextColor
{
    objc_setAssociatedObject(self, &touchDownTextColorKey, touchDownTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sr_setTouchDownBackgroundColor:(UIColor *)touchDownBackgroundColor
{
    [self setTouchDownBackgroundColor:touchDownBackgroundColor];
}

- (void)sr_setTouchDownTextColor:(UIColor *)touchDownTextColor
{
    [self setTouchDownTextColor:touchDownTextColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (self.touchDownBackgroundColor) {
        [self cancelBackgrounColorPerform];
        [self setNormalBackgroundColor:self.backgroundColor];
        self.backgroundColor = self.touchDownBackgroundColor;
    }
    
    if (self.touchDownTextColor) {
        [self cancelTextColorPerform];
        [self setNormalTextColor:[self titleColorForState:UIControlStateNormal]];
        [self setTitleColor:self.touchDownTextColor forState:UIControlStateNormal];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if (self.touchDownBackgroundColor) {
        [self performSelector:@selector(cancelBackgroundColor) withObject:nil afterDelay:0.2f];
    }
    
    if (self.touchDownTextColor) {
        [self performSelector:@selector(cancelTextColor) withObject:nil afterDelay:0.2f];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.touchDownBackgroundColor) {
        [self performSelector:@selector(cancelBackgroundColor) withObject:nil afterDelay:0.2f];
    }
    
    if (self.touchDownTextColor) {
        [self performSelector:@selector(cancelTextColor) withObject:nil afterDelay:0.2f];
    }
}

- (void)cancelBackgroundColor
{
    [self cancelBackgrounColorPerform];
    self.backgroundColor = self.normalBackgroundColor;
}

- (void)cancelBackgrounColorPerform
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelBackgroundColor) object:nil];
}

- (void)cancelTextColor
{
    [self cancelTextColorPerform];
    [self setTitleColor:self.normalTextColor forState:UIControlStateNormal];
}

- (void)cancelTextColorPerform
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelTextColor) object:nil];
}

@end
