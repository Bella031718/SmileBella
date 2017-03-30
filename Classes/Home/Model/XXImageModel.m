//
//  XXImageModel.m
//  SmileBella
//
//  Created by Bella on 17/1/12.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXImageModel.h"

@implementation XXImageModel

-(BOOL)isImage{
    if (self.big==nil) {
        _isImage=NO;
    }else{
        _isImage=YES;
    }
    return _isImage;
}

@end
