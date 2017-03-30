//
//  XXMBProgressHUD.h
//  SmileBella
//
//  Created by Bella on 17/1/14.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface XXMBProgressHUD : MBProgressHUD

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;



@end
