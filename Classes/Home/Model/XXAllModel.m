
//
//  XXHomeModel.m
//  SmileBella
//
//  Created by Bella on 16/12/10.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXAllModel.h"

#define MAXFLOAT    0x1.fffffep+127f

@implementation XXAllModel

-(CGFloat)cellHeight{
    
    //计算过就直接返回
    if (_cellHeight) return _cellHeight;
    
    //文字的Y值
    CGSize textMaxSize = CGSizeMake(kScreenWidth - 2 * 10, MAXFLOAT);
    _cellHeight += 55;
    
    //文字的高度
    CGSize TextSize = CGSizeMake(kScreenWidth - 2 * 10 , MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:TextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15] }context:nil].size.height +10;
  
    // 中间的内容
    if (self.type != 29) { // 中间有内容（图片、声音、视频）
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= kScreenHeight) { // 显示的图片高度超过一个屏幕，就是超长图片
            middleH = 200;
            //            self.bigPicture = YES;
        }
        CGFloat middleY = _cellHeight;
        CGFloat middleX = 10;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + 10;
    }

        
    // 工具条
    _cellHeight += 35 + 10;
    
    return _cellHeight;

    
    
}






@end
