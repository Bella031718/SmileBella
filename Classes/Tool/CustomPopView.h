//
//  CustomPopView.h
//  百利天下
//
//  Created by cyz on 16/5/9.
//  Copyright © 2016年 BL. All rights reserved.
// // 自定义弹出视图

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface CustomPopView : UIView

/// 遮罩视图
@property (weak, nonatomic) UIView *maskView;
/// 弹出视图
@property (weak, nonatomic) UIView *buttonView;

/// 弹出显示
- (void)show;
/// 退出关闭
- (void)dismiss;

@end
