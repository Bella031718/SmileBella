//
//  XXDog.m
//  SmileBella
//
//  Created by Bella on 17/1/16.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXDog.h"

@implementation XXDog

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
