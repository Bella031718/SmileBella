//
//  XXPerson.h
//  SmileBella
//
//  Created by Bella on 17/1/16.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXDog;

@interface XXPerson : NSObject<NSCoding>

@property (nonatomic, strong)NSString *name;

@property(nonatomic,assign)int age;

@property (nonatomic, strong)XXDog *dog;

@end
