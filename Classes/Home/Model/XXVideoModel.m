//
//  XXVideoModel.m
//  SmileBella
//
//  Created by Bella on 17/1/3.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXVideoModel.h"
#import <MJExtension.h>
#import <AFNetworking.h>


#define MAXFLOAT    0x1.fffffep+127f

@implementation XXVideoModel



//+ (void)getEssenceModelWith:(NSDictionary *)dic complection:(void (^)(XXAllVideoModel *))complection failure:(void (^)(NSError *))failure
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
//    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    
//    [param setValuesForKeysWithDictionary:dic];
//    param[@"a"] = @"list";
//    param[@"c"] = @"data";
//    
//    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        //        NSLog(@"返回的数据是%@",responseObject);
//        XXAllVideoModel *model = [XXAllVideoModel mj_objectWithKeyValues:responseObject];
//        complection(model);
////        NSLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"获取数据失败");
//        failure(error);
//    }];
//    
//}

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



// 在一开始加载的时候就将所有类的ID替换了id
+ (void)load
{
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}


@end
