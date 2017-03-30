//
//  XXHomeModel.h
//  SmileBella
//
//  Created by Bella on 16/12/10.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,XXAllModelType){
    
    /** 全部 */
    XXTopicTypeAll = 1,
    /** 视频 */
    XXTopicTypeVideo = 41,
    /** 声音 */
    XXTopicTypeVoice = 31,
    /** 图片 */
    XXTopicTypeImage = 10,
    /** 段子 */
    XXTopicTypeWord = 29
    
};

@interface XXAllModel : NSObject

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

// 帖子的类型 10为图片 29为段子 31为音频 41为视频
@property (nonatomic, assign) NSInteger type;

// 宽度(像素)
@property (nonatomic, assign) NSInteger width;
// 高度(像素)
@property (nonatomic, assign) NSInteger height;

// 最热评论
@property (nonatomic, strong) NSArray *top_cmt;

// 小图
@property (nonatomic, copy) NSString *image0;
// 中图
//@property (nonatomic, copy) NSString *image2;
@property (nonatomic, copy) NSString * image_small;
// 大图
@property (nonatomic, copy) NSString *image1;


// 是否为动图
@property (nonatomic, assign) BOOL is_gif;

// 音频时长
@property (nonatomic, assign) NSInteger voicetime;
// 视频时长
@property (nonatomic, assign) NSInteger videotime;
// 音频\视频的播放次数
@property (nonatomic, assign) NSInteger playcount;

/* 额外增加的属性（并非服务器返回的属性，仅仅是为了提高开发效率） */
/** 根据当前模型计算出来的cell高度 */


@property (nonatomic, assign) CGFloat cellHeight;


// 中间内容的frame 
@property (nonatomic, assign) CGRect middleFrame;
// 是否为超长图片
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;




@end
