//
//  XXTitleButton.m
//  SmileBella
//
//  Created by Bella on 16/12/23.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXTitleButton.h"

@implementation XXTitleButton


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor: xRed forState:UIControlStateSelected];
    }
    
    return self;
}


- (void)setHighlighted:(BOOL)highlighted
{ // 只要重写了这个方法，按钮就无法进入highlighted状态
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
