//
//  NSObject+Swizzling.m
//  QBFramework
//
//  Created by quentin on 15/6/10.
//  Copyright (c) 2015年 Quentin. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (BOOL)explaceMethodOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
#if DEBUG
    return NO;
#else
    Method origMethod = class_getInstanceMethod(self, originalSelector);
    if (!origMethod) {
        NSLog(@"origMethd failed :%@",NSStringFromSelector(originalSelector));
        return NO;
    }
    
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        NSLog(@"swizzledMethod failed :%@",NSStringFromSelector(swizzledSelector));
        return NO;
    }
    class_addMethod(self,
                    swizzledSelector,
                    class_getMethodImplementation(self, swizzledSelector),
                    method_getTypeEncoding(swizzledMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, swizzledSelector));
#endif
    return YES;
}

+ (BOOL)explaceClassMethodOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    return [object_getClass((id)self) explaceMethodOriginalSelector:originalSelector swizzledSelector:swizzledSelector];
}

@end
