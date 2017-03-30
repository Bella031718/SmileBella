//
//  XXPlayVC.h
//  SmileBella
//
//  Created by Bella on 17/1/5.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXPlayVC : UIViewController

@property (nonatomic, copy) NSString  *VideoURL;
@property (nonatomic, copy) NSString  *videoTitle;

/** 时长 */
@property(nonatomic,assign)double Time;
@end
