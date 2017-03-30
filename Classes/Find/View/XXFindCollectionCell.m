//
//  XXFindCollectionCell.m
//  SmileBella
//
//  Created by Bella on 17/1/18.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXFindCollectionCell.h"

@implementation XXFindCollectionCell

/** cell布局    通过一个布局策略初始化*/
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _ImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _ImageView.backgroundColor = xGray;
        [self.contentView addSubview:_ImageView];
        
        
        _shadeView = [[UIImageView alloc]initWithFrame:self.bounds];
        //设置透明度
        _shadeView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        [self.contentView addSubview:_shadeView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/2-20, self.bounds.size.width, 40)];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
        
    }
    
    return self;
}


@end
