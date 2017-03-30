//
//  XXVideoCell.h
//  SmileBella
//
//  Created by Bella on 16/12/30.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(void);
@class XXVideoModel;

@interface XXVideoCell : UITableViewCell

@property (nonatomic, strong) XXVideoModel *model;

//播放
@property(nonatomic,copy)block playblock;

//评论
@property (nonatomic, copy)block commentblock;

//点赞
@property (nonatomic, copy)block zangblock;

//踩
@property (nonatomic, copy)block caiblock;

@end
