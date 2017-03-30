//
//  NSArray+XX.h
//  链式编程
//
//  Created by KAbun on 17/2/6.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XX)


//@interface NSArray : NSArray


/*
 @method objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)objectAtIndexCheck:(NSUInteger)index;
@end
