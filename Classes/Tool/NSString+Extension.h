//
//  NSString+Extension.h
//  百利天下
//
//  Created by cyz on 16/5/16.
//  Copyright © 2016年 BL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark -- 类方法
/** 一般加密 */
+ (NSString *)commonMD5String:(NSString *)str;

/**  加强解密难度  */
+ (NSString *)strengthenMD5StringWith:(NSString *)str;

/**
 *  双重MD5加密
 *
 *  @param str 需要加密的字符串
 *
 *  @return 加密结果
 */
+ (NSString *)doubleMD5String:(NSString *)str;

#pragma mark -- 对象方法
/** 一般加密 */
- (NSString *)commonMD5String;

/** 加强解密难度 */
- (NSString *)strengthenMD5String;

/**   双重MD5加密 */
- (NSString *)doubleMD5String;

/**
 *  获取当前日期
 *
 *  @return 字符串格式的日期
 */
+ (NSString *)currenDate;
/**
 *  获取时间差
 *
 *  @return 时间差
 */
+ (NSString *) compareCurrentTime:(NSString *)str;
/**
 *  判断邮箱
 *
 *  @return 邮箱与否
 */
- (BOOL)isEmailString;

/**
 *  判断手机号
 *
 *  @return 手机号的正确性
 */
- (BOOL)isMobileNumber;

/**
 *  判断QQ号
 */
- (BOOL)isQQString;

/**
 *  计算文件大小
 *
 *  @return 文件大小
 */
- (long long)fileSize;

/**
 *  把URL取出参数转成字典
 *
 *  @return 转成后的字典
 */
- (NSMutableDictionary *)changeParamIntoDic;

@end
