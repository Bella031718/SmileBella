//
//  XXPerson.m
//  SmileBella
//
//  Created by Bella on 17/1/16.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXPerson.h"

@implementation XXPerson

/** 在保存对象时告诉要保存当前对象哪些属性 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
    [aCoder encodeObject:self.dog forKey:@"dog"];

}

/** 当解析一个文件的时候调用,告诉当前要解析文件当中哪些属性 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    //当只有遵守了NSCoding协议时,才有[super initWithCoder]
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
        self.dog = [aDecoder decodeObjectForKey:@"dog"];
    }
    return self;
}


@end
