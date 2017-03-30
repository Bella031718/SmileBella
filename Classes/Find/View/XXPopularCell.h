//
//  XXPopularCell.h
//  SmileBella
//
//  Created by Bella on 17/1/19.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXPopularCell : UITableViewCell

/** 图片 */
@property (nonatomic, weak) UIImageView *ImageView;

@property (nonatomic, weak) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/** Message */
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UILabel *indexLabel;

@property (nonatomic, weak) UIButton *topLine;

@property (nonatomic, weak) UIButton *bottomLine;



@end
