//
//  XXGIfFooter.m
//  SmileBella
//
//  Created by Bella on 16/12/27.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXGIfFooter.h"

@implementation XXGIfFooter

- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
