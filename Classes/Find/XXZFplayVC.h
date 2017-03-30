//
//  XXZFplayVC.h
//  SmileBella
//
//  Created by Bella on 17/1/24.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXVideoListModel.h"
#import "XXVideoModel.h"

@interface XXZFplayVC : UIViewController

@property (nonatomic, strong)XXVideoListModel *model;

@property (nonatomic, strong)XXVideoModel *model2;

/** 视频地址 */
@property (nonatomic, strong)NSString *urlStr;
/** 视频标题 */
@property (nonatomic, strong)NSString *titleStr;
//* 时长 
@property(nonatomic,assign)double Time;


@end
