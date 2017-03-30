//
//  NSObject+UIBarButtonItem.h
//  SmileBella
//
//  Created by Bella on 16/12/19.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UIBarButtonItem)

+(UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+(UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
+(UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;


@end
