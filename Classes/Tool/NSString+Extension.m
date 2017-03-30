//
//  NSString+Extension.m
//  百利天下
//
//  Created by cyz on 16/5/16.
//  Copyright © 2016年 BL. All rights reserved.
//

#import "NSString+Extension.h"
// 引入必要的头文件
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)

#pragma mark -- 类方法
/** 一般加密 */
+ (NSString *)commonMD5String:(NSString *)str{
//    const char *myPWD = [str UTF8String];
//    unsigned char mdc[16];
//    CC_MD5(myPWD, (CC_LONG)strlen(myPWD), mdc);
//    NSMutableString *md5String = [NSMutableString string];
//    for (int i = 0; i < 16; i++) {
//        [md5String appendFormat:@"%02x",mdc[i]];
//    }
//    return md5String;
    return [str commonMD5String];
}

/**  加强解密难度  */
+ (NSString *)strengthenMD5StringWith:(NSString *)str{
//    const char *myPWD = [str UTF8String];
//    unsigned char mdc[16];
//    CC_MD5(myPWD, (CC_LONG)strlen(myPWD), mdc);
//    NSMutableString *md5String = [NSMutableString string];
//    [md5String appendFormat:@"%02x",mdc[0]];
//    for (int i = 0; i < 16; i++) {
//        [md5String appendFormat:@"%02x",mdc[i]^mdc[0]];
//    }
//    
//    return md5String;
    return [str strengthenMD5String];
}

/**
 *  双重MD5加密
 *
 *  @param NSString 需要加密的字符串
 *
 *  @return 加密完成返回的字符串
 */
+ (NSString *)doubleMD5String:(NSString *)str
{
    
    return  [str doubleMD5String];
}

#pragma mark -- 对象方法
/** 一般加密 */
- (NSString *)commonMD5String
{
    const char *myPWD = [self UTF8String];
    unsigned char mdc[16];
    CC_MD5(myPWD, (CC_LONG)strlen(myPWD), mdc);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [md5String appendFormat:@"%02x",mdc[i]];
    }
    return md5String;
}
/**
 *  双重MD5加密
 *
 *  @return 加密完成的字符串
 */
- (NSString *)doubleMD5String
{
    return [[self commonMD5String] commonMD5String];
}

/** 加强解密难度 */
- (NSString *)strengthenMD5String
{
    const char *myPWD = [self UTF8String];
    unsigned char mdc[16];
    CC_MD5(myPWD, (CC_LONG)strlen(myPWD), mdc);
    NSMutableString *md5String = [NSMutableString string];
    [md5String appendFormat:@"%02x",mdc[0]];
    for (int i = 0; i < 16; i++) {
        [md5String appendFormat:@"%02x",mdc[i]^mdc[0]];
    }
    return md5String;
}


/**
 *  获取当前日期
 *
 *  @return 字符串格式的日期
 */
+ (NSString *)currenDate
{
    // 1. 获取当前的时间(默认精确到秒)
    NSDate *today = [NSDate date];
    
    // 2. 进行日期转换
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];

//    NSDateComponents *components = [
    // 3. 将日期转换成字符串
    NSString *dateString = [dateFormatter stringFromDate:today];
    
    // 4. 将
    
    return dateString;
    
}

+ (NSString *) compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]]; // 东八区会自动减去八小时
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval; // 计算的结果是负数需要转换
    
    NSInteger temp = 0;

    NSString *result;
//    BLLog(@"timeInterval = %f",timeInterval);
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

// 判断邮箱
- (BOOL)isEmailString
{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL emailRight = [emailTest evaluateWithObject:self];
    return emailRight;
}

#pragma mark - 判断手机号
- (BOOL)isMobileNumber
{
    NSString *mobile = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [mobileTest evaluateWithObject:self];
}

#pragma mark - 判断qq号
- (BOOL)isQQString
{
    NSString *QQ = @"^[1-9][0-9]{4,}$";
    NSPredicate *QQtest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", QQ];
    return [QQtest evaluateWithObject:self];
    
}

#pragma mark - 计算文件大小
- (long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
//    NSString *sizeText = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:self isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return size;
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else{ // 是文件
        size += [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}
#pragma mark - 把URL中的参数转换成字典
- (NSMutableDictionary *)changeParamIntoDic
{
   // 获取URL问号的位置，问号后面是参数列表
    if (![self containsString:@"?"]) {
        return [NSMutableDictionary dictionary];
    }
    NSRange range = [self rangeOfString:@"?"];
    
    
    // 获取参数列表
    NSString *param = [self substringFromIndex:range.location+1]; 
    
    // 对键值对进行拆分  分隔符为 &
    NSArray<NSString *> *subArray = [param componentsSeparatedByString:@"&"];
    
    // 把subArray转换成字典
    // dictionary 中存放着一个URL中转换的键值对
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    // 遍历数组
    
    [subArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 通过=拆分键和值
        NSArray<NSString*> *dicArray = [obj componentsSeparatedByString:@"="];
        // 给字典加入元素
        [dictionary setObject:dicArray[1] forKey:dicArray[0]];
    }];
    
    return dictionary;
}

@end
