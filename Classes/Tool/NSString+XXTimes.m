//
//  NSString+XXTimes.m
//  SmileBella
//
//  Created by Bella on 17/2/13.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "NSString+XXTimes.h"

@implementation NSString (XXTimes)

+(NSString *)GetNowTimes{
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    
    return timeString;
    
}



@end
