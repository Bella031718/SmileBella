//
//  XXHomeCell.m
//  SmileBella
//
//  Created by Bella on 16/12/10.
//  Copyright © 2016年 Bella. All rights reserved.
//

#import "XXHomeCell.h"

@implementation XXHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor brownColor];
        [self setupUI];
      
    }
    return self;
}

-(void)setupUI{
   
}

@end
