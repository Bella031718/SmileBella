//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+ (instancetype)xx_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

//+ (NSBundle *)bundleForClass:(Class)aClass;
//+ (nullable NSBundle *)bundleWithIdentifier:(NSString *)identifier;


- (void)setXx_height:(CGFloat)xx_height
{
    CGRect rect = self.frame;
    rect.size.height = xx_height;
    self.frame = rect;
}

- (CGFloat)xx_height
{
    return self.frame.size.height;
}

- (CGFloat)xx_width
{
    return self.frame.size.width;
}
- (void)setXx_width:(CGFloat)xx_width
{
    CGRect rect = self.frame;
    rect.size.width = xx_width;
    self.frame = rect;
}

- (CGFloat)xx_x
{
    return self.frame.origin.x;
    
}

- (void)setXx_x:(CGFloat)xx_x
{
    CGRect rect = self.frame;
    rect.origin.x = xx_x;
    self.frame = rect;
}

- (void)setXx_y:(CGFloat)xx_y
{
    CGRect rect = self.frame;
    rect.origin.y = xx_y;
    self.frame = rect;
}

- (CGFloat)xx_y
{

    return self.frame.origin.y;
}

- (void)setXx_centerX:(CGFloat)xx_centerX
{
    CGPoint center = self.center;
    center.x = xx_centerX;
    self.center = center;
}

- (CGFloat)xx_centerX
{
    return self.center.x;
}

- (void)setXx_centerY:(CGFloat)xx_centerY
{
    CGPoint center = self.center;
    center.y = xx_centerY;
    self.center = center;
}

- (CGFloat)xx_centerY
{
    return self.center.y;
}
@end
