//
//  XXMenueHeader.m
//  SmileBella
//
//  Created by Bella on 17/3/20.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXMenueHeader.h"

@interface XXMenueHeader ()
/** 标题 */
@property (nonatomic, strong)UILabel *title;

@end

@implementation XXMenueHeader


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 7, 6, 26)];
        //背景颜色
        lineView.backgroundColor = [UIColor redColor];
        
        [self addSubview:lineView];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+4, 7, kScreenWidth-40, 26)];
        self.title.text = @"组标题";
        self.title.font = [UIFont boldSystemFontOfSize:18];
        self.title.textColor = [UIColor purpleColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.backgroundColor = [UIColor redColor];
        [self addSubview:self.title];
        
   
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetMaxX(lineView.frame)+315), 13, 80, 20)];
        [moreBtn setTitle:@"更多 >>" forState:UIControlStateNormal];
        [moreBtn setTitleColor:xGray forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //    moreBtn.backgroundColor = [UIColor redColor];
        [self addSubview:self.title];
        [self addSubview:moreBtn];

        
    }
    
    return self;
}







@end
