//
//  XXGIfRfresh.m
//  SmileBella
//
//  Created by Bella on 16/12/27.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXGIfRfresh.h"

@implementation XXGIfRfresh

#pragma mark -- 重写方法


-(void)prepare{
    
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    //设置即将刷新的动画图片
    NSMutableArray *refreshImage = [NSMutableArray array];
    for (NSUInteger i = 1; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%zd",i]];
        [refreshImage addObject:image];
    }
    
    [self setImages:refreshImage forState:MJRefreshStateRefreshing];
}


@end
