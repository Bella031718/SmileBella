//
//  XXNetworkTool.h
//  SmileBella
//
//  Created by Bella on 17/2/9.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface XXNetworkTool : NSObject

/**
 *  get请求
 *
 *  @param url              访问的URL链接
 *  @param params           请求参数
 *  @param downloadProgressBlock 请求进度
 *  @param success          访问成功
 *  @param failure          访问失败
 */

+(void)GET:(NSString*)URL params:(NSDictionary*)params progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock success:(void(^)(NSURLSessionDataTask *task,id responseObject))success failuer:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;



/**
 post请求

 @param URL                 url链接
 @param parames             请求参数
 @param uploadProgressBlock 下载进度
 @param success             请求成功
 @param failure             请求失败
 */
+ (void)POST:(NSString *)URL
      params:(NSDictionary *)parames
    progress:(void (^)(NSProgress * uploadProgress))uploadProgressBlock
     success:(void (^)(NSURLSessionDataTask *task , id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task , NSError * error))failure;


/**
 put请求

 @param URL    url链接
 @param params 请求参数
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)PUT:(NSString *)URL
     params:(id)params
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



/**
 delete请求

 @param URL url链接
 @param params 请求参数
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)DELETE:(NSString *)URL
        params:(id)params
       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



/**
 下载

 @param urlString               下载url链接
 @param downloadProgressBlock   下载进度
 @param destination             下载描述
 @param completionHandler       完成下载
 */
+ (void)downLoad:(NSString *)urlString
        progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
     destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 *  停止所有网络请求
 */
+ (void)stopLoadNetwork;


+(AFSecurityPolicy*)customSecurityPolicy;


@end
