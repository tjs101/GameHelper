//
//  NSMutableSet+Swizzling.m
//  QBFramework
//
//  Created by quentin on 16/2/3.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "NSMutableSet+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableSet (Swizzling)

+ (void)load
{

    [[[NSMutableSet set] class] explaceMethodOriginalSelector:@selector(removeObject:) swizzledSelector:@selector(my_removeObject:)];
}

- (void)my_removeObject:(id)object
{
    @autoreleasepool {
        if (object) {
            [self my_removeObject:object];
        }
    }
}

@end
