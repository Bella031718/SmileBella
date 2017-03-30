//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 
    写分类:避免跟其他开发者产生冲突,加前缀
 
 */
@interface UIView (Frame)

@property CGFloat xx_width;
@property CGFloat xx_height;
@property CGFloat xx_x;
@property CGFloat xx_y;
@property CGFloat xx_centerX;
@property CGFloat xx_centerY;

+ (instancetype)xx_viewFromXib;

@end
