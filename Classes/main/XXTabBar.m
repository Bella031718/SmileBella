//
//  LXJtabBar.m
//  SmileBella
//
//  Created by Bella on 16/12/16.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXTabBar.h"
#import "UIView+Frame.h"

@interface XXTabBar ()



@property (nonatomic, weak)UIButton *plusButton;

//上一次点击按钮
@property (nonatomic,weak)UIControl *previousClickedTabBarButton;

@end



@implementation XXTabBar

- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        
        _plusButton = btn;
    }
    return _plusButton;
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //跳转tabbarBtn位置
    NSInteger count = self.items.count;
    CGFloat btWidth = self.xx_width / (count +1);
    CGFloat btnHeight = self.xx_height;
    CGFloat x = 0;
    int i = 0;
    
    //私有类
    //遍历子控件
    for (UIControl *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            NSLog(@"%@",tabBarBtn);
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarBtn;
            }
            if (i == 2) {
                i += 1;
            }
            x = i *btWidth;
            tabBarBtn.frame = CGRectMake(x, 0, btWidth, btnHeight);
            i ++;
            
            //监听点击
            [tabBarBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.plusButton.center = CGPointMake(self.xx_width *0.5 , self.xx_height *0.5 );
    
}

// tabBarBtn的点击

-(void)tabBarBtnClick:(UIControl *)tabBarButton{
    if (self.previousClickedTabBarButton == tabBarButton) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Clicknotification" object:nil];
    }
    
    self.previousClickedTabBarButton = tabBarButton;
}



@end

