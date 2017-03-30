//
//  XXAdmodel.h
//  SmileBella
//
//  Created by Bella on 16/12/17.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXAdmodel : NSObject

/**
 广告地址
 */
@property (nonatomic,strong)NSString *w_picurl;

/**
 点击广告跳转的界面
 */
@property (nonatomic,strong)NSString *ori_curl;

@property(nonatomic,assign)CGFloat w;
@property(nonatomic,assign)CGFloat h;

@end
