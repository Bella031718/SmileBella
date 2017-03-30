//
//  UIButton+CountDown.h
//  百利天下
//
//  Created by cyz on 16/4/13.
//  Copyright © 2016年 BL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^CompletionHandler)(void);
@interface UIButton (Extension)

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle ) {
    ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};

/**
 *  调整按钮的title和image的布局，前提是title和image同时存在才会调用
 *
 *  @param style   排列的类型
 *  @param padding title和image的间距
 */
-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

/**
*  倒计时按钮
*
*  @param timeLine          倒计时总时间
*  @param title             倒计时结束后的title
*  @param preTitle          数字前字符
*  @param sufCountDownTitle 数字后字符
*  @param mColor            倒计时前的按钮背景色
*  @param color             倒计时进行时背景色
*/
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title preCountDownTitle:(NSString *)preTitle sufCountDownTitle:(NSString *)sufTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 *  按钮以block样式返回的触发方法
 *
 *  @param controlEvents 触发的手势,一般情况下是用UIControlEventTouchUpInside
 *  @param completion    响应的回调
 */
- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(CompletionHandler)completion;

/**
 *  默认按钮点击事件是TouchUpInside
 *
 *  @param completion 响应回调
 */
- (void)addActionWithTouchUpInside:(CompletionHandler)completion;
@end
