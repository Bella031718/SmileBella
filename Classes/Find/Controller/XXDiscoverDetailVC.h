//
//  XXDiscoverDetailVC.h
//  SmileBella
//
//  Created by Bella on 17/1/18.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDiscoverDetailVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSString *actionUrl;

@property (nonatomic, strong)NSString *pageTitle;

@property (nonatomic, strong)NSString *NextPage;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *ListArr;;

@property (nonatomic, strong)UILabel *topLine;

@property (nonatomic, strong)UILabel *line;

@property (nonatomic, strong)NSString *RequestUrl;

@property (nonatomic, strong)UIButton *seleBtn;

@property (nonatomic, strong)NSString *idStr;

@property (nonatomic, strong)NSString *ReqId;


@end
