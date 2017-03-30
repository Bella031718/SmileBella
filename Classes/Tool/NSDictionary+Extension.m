//
//  NSDictionary+Extension.m
//  百利天下
//
//  Created by cyz on 16/5/18.
//  Copyright © 2016年 BL. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"

@implementation NSDictionary (Extension)
#pragma mark -- 对象方法
- (NSDictionary *)appendDictionary
{
    // 1. 将字典的键值取出存进数组
    NSArray *keyArray = [self allKeys];
    
    // 2. 对数组进行krSort排序（因为默认字典是无序的的)
    keyArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1];
    }];
    
    // 3. 把数组中的字符串进行拼接
    NSMutableString *string = [NSMutableString string];
    [keyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendString:obj];
    }];
    // 4. 获取系统时间精确到分钟
//    NSString *curreDate = [NSString currenDate];
    [string appendString:@"12345678901463364780"];
//    BLLog(@"拼接完成的字符串string = %@",string);
    // 把字典进行扩充一个键值对用于摘要认证
    NSMutableDictionary *newDic = [NSMutableDictionary new];
    [newDic addEntriesFromDictionary:self];
    [newDic setValue:[string doubleMD5String] forKey:@"key"];
    
    return newDic;
}

#pragma mark -- 类方法
+ (NSDictionary *)appenDictionaryWith:(NSDictionary *)dic
{
    return [dic appendDictionary];
}
@end
