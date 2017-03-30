//
//  UIImageView+Download.h
//  SmileBella
//
//  Created by Bella on 16/12/26.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Download)
- (void)xx_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

- (void)xx_setHeader:(NSString *)headerUrl;
@end
