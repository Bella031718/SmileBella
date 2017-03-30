//
//  CustomPopView.m
//  百利天下
//
//  Created by cyz on 16/5/9.
//  Copyright © 2016年 BL. All rights reserved.
//

#import "CustomPopView.h"

@implementation CustomPopView
{
    BOOL isShow;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    [self initView];
    return self;
}

- (void)initView 
{
    
    self.frame = [UIScreen mainScreen].bounds;
//    self.backgroundColor = [UIColor clearColor];
    UIView *buttonView = [UIView new];
    self.buttonView = buttonView;
    buttonView.backgroundColor = [UIColor whiteColor];
    
    
    buttonView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
    [self addSubview:self.buttonView];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
//        make.left.right.offset(0);
//        make.top.equalTo(self.mas_bottom);
    }];
    
    // 给buttonView添加一个空的手势拦截点击背景的事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.buttonView addGestureRecognizer:tap];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5f animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.buttonView.frame = CGRectMake(0, kScreenHeight-self.buttonView.frame.size.height, kScreenWidth, self.buttonView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.buttonView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.buttonView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        [self.buttonView removeGestureRecognizer:self.buttonView.gestureRecognizers[0]]; // 移除手势
    }];
    
}

// 点击屏幕让视图消失
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
- (void)dealloc
{
    NSLog(@"弹出视图销毁了");
}

@end
