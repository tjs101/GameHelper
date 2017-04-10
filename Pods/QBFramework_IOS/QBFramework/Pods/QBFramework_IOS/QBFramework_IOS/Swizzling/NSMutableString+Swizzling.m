//
//  NSMutableString+Swizzling.m
//  QBFramework
//
//  Created by quentin on 16/2/3.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "NSMutableString+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableString (Swizzling)

+ (void)load
{
    [[[NSMutableString string] class] explaceMethodOriginalSelector:@selector(appendString:) swizzledSelector:@selector(my_appendString:)];
}

- (void)my_appendString:(NSString *)aString
{
    @autoreleasepool {
        if (aString != nil) {
            [self my_appendString:aString];
        }
    }
}

@end
