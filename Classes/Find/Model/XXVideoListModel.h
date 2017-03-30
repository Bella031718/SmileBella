//
//  XXVideoListModel.h
//  SmileBella
//
//  Created by Bella on 17/1/18.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXVideoListModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *ImageView;

@property (nonatomic, copy) NSString *shadeView;

/** 标题 */
@property (nonatomic, copy) NSString *titleLabel;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSDictionary *consumption;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *idStr;



@end
