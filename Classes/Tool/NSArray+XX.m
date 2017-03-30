//
//  NSArray+XX.m
//  链式编程
//
//  Created by KAbun on 17/2/6.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "NSArray+XX.h"

@implementation NSArray (XX)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}
@end
