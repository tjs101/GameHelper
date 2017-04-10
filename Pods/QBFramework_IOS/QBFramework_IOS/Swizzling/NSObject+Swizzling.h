//
//  NSObject+Swizzling.h
//  QBFramework
//
//  Created by quentin on 15/6/10.
//  Copyright (c) 2015年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (BOOL)explaceMethodOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
+ (BOOL)explaceClassMethodOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
