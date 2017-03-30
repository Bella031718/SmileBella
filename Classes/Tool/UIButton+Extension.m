//
//  UIButton+CountDown.m
//  百利天下
//
//  Created by cyz on 16/4/13.
//  Copyright © 2016年 BL. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

static void *BuClickKey = @"BuClickKey";

@implementation UIButton (Extension)
#pragma mark - 自定义按钮的点击事件
// 以block形式返回点击事件
- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(CompletionHandler)completion{
    
    [self addTarget:self action:@selector(didClickBU) forControlEvents:controlEvents];
    
    void (^block)(void) = ^{
        completion();
    };
    objc_setAssociatedObject(self, BuClickKey, block, OBJC_ASSOCIATION_COPY);
    
}
-(void)didClickBU{
    void (^block)(void) = objc_getAssociatedObject(self, BuClickKey);
    block();
}

// 默认以UIControlEventTouchUpInside
- (void)addActionWithTouchUpInside:(CompletionHandler)completion
{
    [self addActionforControlEvents:UIControlEventTouchUpInside respond:^{
        if (completion) {
            completion();
        }
    }];
    
}
#pragma mark - 设置按钮的图文布局样式
-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding
{
    if (self.imageView.image != nil && self.titleLabel.text != nil)
    {
        //先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        
        switch (style) {
            case ButtonImageTitleStyleLeft:
                if (padding != 0)
                {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                            padding/2,
                                                            0,
                                                            -padding/2);
                    
                    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                            -padding/2,
                                                            0,
                                                            padding/2);
                }
                break;
            case ButtonImageTitleStyleRight:
            {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        -(imageRect.size.width + padding/2),
                                                        0,
                                                        (imageRect.size.width + padding/2));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (titleRect.size.width+ padding/2),
                                                        0,
                                                        -(titleRect.size.width+ padding/2));
            }
                break;
            case ButtonImageTitleStyleTop:
            {
                //图片在上，文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
                
            }
                break;
            case ButtonImageTitleStyleBottom:
            {
                //图片在下，文字在上。
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterTop:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y - padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y - padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterBottom:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterUp:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterDown:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleRightLeft:
            {
                //图片在右，文字在左，距离按钮两边边距
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        -(titleRect.origin.x - padding),
                                                        0,
                                                        (titleRect.origin.x - padding));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth - padding - imageRect.origin.x - imageRect.size.width),
                                                        0,
                                                        -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
            }
                
                break;
                
            case ButtonImageTitleStyleLeftRight:
            {
                //图片在左，文字在右，距离按钮两边边距
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                                                        0,
                                                        -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        -(imageRect.origin.x - padding),
                                                        0,
                                                        (imageRect.origin.x - padding));
                
            }
                break;
            default:
                break;
        }
    }
    else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

/**
 *  原始的倒计时功能
 *
 *  @param timeLine 时长
 *  @param title    标题
 *  @param subTitle 副标题
 *  @param mColor   计时颜色
 *  @param color    正在及时的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{

    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{

        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);

            dispatch_async(dispatch_get_main_queue(), ^{

                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });

        }else{

            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });

            timeOut--;
        }
    });

    dispatch_resume(_timer);
}

/**
 *  拓展之后的倒计时功能
 */
-(void)startWithTime:(NSInteger)timeLine title:(NSString *)title preCountDownTitle:(NSString *)preTitle sufCountDownTitle:(NSString *)sufTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color
{
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{

        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);

            dispatch_async(dispatch_get_main_queue(), ^{

                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });

        }else{

            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@%@",preTitle,timeStr,sufTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

@end
