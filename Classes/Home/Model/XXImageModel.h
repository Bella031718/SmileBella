//
//  XXImageModel.h
//  SmileBella
//
//  Created by Bella on 17/1/12.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXImageModel : NSObject

//用户的名字
@property (nonatomic, copy) NSString *name;
//用户的头像
@property (nonatomic, copy) NSString *profile_image;
//帖子的文字内容
@property (nonatomic, copy) NSString *text;
//帖子审核通过的时间
@property (nonatomic, copy) NSString *passtime;
// 顶数量
@property (nonatomic, copy) NSString * cai;
@property (nonatomic, copy) NSString * comment;
@property (nonatomic, copy) NSString * ding;
@property (nonatomic, copy) NSString * favourite;


@property (nonatomic, strong) NSArray * big;
@property (nonatomic, strong) NSArray * download_url;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSArray * medium;
@property (nonatomic, strong) NSArray * small;
@property (nonatomic, strong) NSArray * thumbnail_small;
@property (nonatomic, strong) NSNumber * width;


@property(nonatomic,assign) BOOL isImage;
@property(nonatomic,assign) BOOL isBig;

-(void)setupImageURL:(id)URL andGIF:(BOOL)isGIF andBigImage:(BOOL)big;

@end
