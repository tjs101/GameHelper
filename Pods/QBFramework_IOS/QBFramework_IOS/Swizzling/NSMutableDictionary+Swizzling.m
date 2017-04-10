//
//  NSMutableDictionary+Swizzling.m
//  QBFramework
//
//  Created by quentin on 15/6/11.
//  Copyright (c) 2015年 Quentin. All rights reserved.
//

#import "NSMutableDictionary+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableDictionary (Swizzling)

+ (void)load
{

    [[[NSMutableDictionary dictionary] class] explaceMethodOriginalSelector:@selector(setObject:forKey:) swizzledSelector:@selector(my_setObject:forKey:)];
}

- (void)my_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    @autoreleasepool {
        if (anObject && aKey) {
            [self my_setObject:anObject forKey:aKey];
        }

        else {

        }
    }
}

@end
