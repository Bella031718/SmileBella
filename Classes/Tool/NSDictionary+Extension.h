//
//  NSDictionary+Extension.h
//  百利天下
//
//  Created by cyz on 16/5/18.
//  Copyright © 2016年 BL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
/**
 *  扩充字典，在已有键值的基础上增加一个键值对
 *
 *  @return 新生成的字典
 */

- (NSDictionary *)appendDictionary;
/**
 *  扩充字典，在已有键值的基础上增加一个键值对
 *
 *  @param dic 需要扩充的字典
 *
 *  @return 生成的字典
 */
+ (NSDictionary *)appenDictionaryWith:(NSDictionary *)dic;
@end
