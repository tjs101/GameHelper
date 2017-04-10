//
//  NSMutableArray+Swizzling.m
//  QBFramework
//
//  Created by quentin on 15/6/11.
//  Copyright (c) 2015年 Quentin. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableArray (Swizzling)

+ (void)load
{

    [[[NSMutableArray array] class] explaceMethodOriginalSelector:@selector(addObject:) swizzledSelector:@selector(my_addObject:)];
    [[[NSMutableArray array] class] explaceMethodOriginalSelector:@selector(objectAtIndex:) swizzledSelector:@selector(my_objectAtIndex:)];
    [[[NSMutableArray array] class] explaceMethodOriginalSelector:@selector(removeObjectAtIndex:) swizzledSelector:@selector(my_removeObjectAtIndex:)];
    [[[NSMutableArray array] class] explaceMethodOriginalSelector:@selector(insertObject:atIndex:) swizzledSelector:@selector(my_insertObject:atIndex:)];
    [[[NSMutableArray array] class] explaceMethodOriginalSelector:@selector(addObjectsFromArray:) swizzledSelector:@selector(my_addObjectsFromArray:)];

}


- (void)my_addObject:(id)anObject
{
    @autoreleasepool {
        if (anObject) {
            [self my_addObject:anObject];
        }
        else {

        }

    }

}

- (id)my_objectAtIndex:(NSUInteger)index
{
    @autoreleasepool {
        
        if (self == nil) {
            return nil;
        }
        
        if (index < [self count]) {

            return [self my_objectAtIndex:index];
        }
        else {

        }
        
        return nil;
    }

}

- (void)my_removeObjectAtIndex:(NSUInteger)index
{
    @autoreleasepool {
        if (index < [self count]) {
            
            [self my_removeObjectAtIndex:index];
        }
        else {

        }

    }
    
}

- (void)my_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    @autoreleasepool {
        
        if (anObject != nil && index <= [self count]) {
            [self my_insertObject:anObject atIndex:index];
        }
        else {

        }

    }
}

- (void)my_addObjectsFromArray:(NSArray *)otherArray
{
    @autoreleasepool {
        if ([otherArray isKindOfClass:[NSArray class]]) {//使用环信遇到过几次，防止崩溃
            [self my_addObjectsFromArray:otherArray];
        }
        else {
            if (otherArray == nil) {
                [self my_addObjectsFromArray:[NSArray array]];
            }
        }
    }

}

@end
