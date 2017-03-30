//
//  XXHomeCycleView.h
//  SmileBella
//
//  Created by Bella on 17/3/17.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXTopModel.h"


@class XXHomeCycleView;

//代理方法
@protocol XXHomeCycleViewDelegate <NSObject>

-(void)homeCycleView:(XXHomeCycleView *)homeCycleView roomId:(NSString *)roomId;

@end

@interface XXHomeCycleView : UICollectionReusableView

//图片数组
@property (nonatomic, strong)NSArray *ImageArray;
//标题
@property (nonatomic, strong)NSArray *titleData;
//代理
@property (nonatomic, weak)id<XXHomeCycleViewDelegate> delegate;

@end
