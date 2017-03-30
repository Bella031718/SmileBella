//
//  XXMessageVC.m
//  SmileBella
//
//  Created by Bella on 17/1/17.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXMessageVC.h"
#import "UIView+PS.h"
#import "UINavigationBar+PS.h"

@interface XXMessageVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _lastPosition;
}

@property (nonatomic,strong)UIImageView * avatarView;
@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UIView * headBackView;
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UITableView * displayTableView;

@end

@implementation XXMessageVC

- (UITableView*)displayTableView
{
    if (!_displayTableView) {
        _displayTableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        _displayTableView.showsVerticalScrollIndicator = NO;
    }
    return _displayTableView;
}

- (UIView*)headBackView
{
    if (!_headBackView) {
        _headBackView = [UIView new];
        _headBackView.userInteractionEnabled = YES;
        _headBackView.frame = CGRectMake(0, 0, kScreenWidth,200);
    }
    return _headBackView;
}

- (UIImageView*)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"bg.jpg"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor orangeColor];
    }
    return _headImageView;
}

- (UIImageView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.image = [UIImage imageNamed:@"header.jpg"];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        _avatarView.size = CGSizeMake(80, 80);
        [_avatarView setLayerWithCr:_avatarView.width / 2];
    }
    return _avatarView;
}

- (UILabel*)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor whiteColor];
    }
    return _messageLabel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.displayTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar ps_reset];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetHeaderView];
    
    self.displayTableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.displayTableView];
//    self.navigationController.navigationBar.hidden = YES;
    //导航
    [self.navigationController.navigationBar ps_setBackgroundColor:[UIColor clearColor]];
 
}


- (void)resetHeaderView
{
    self.headImageView.frame = self.headBackView.bounds;
    [self.headBackView addSubview:self.headImageView];
    
    self.avatarView.centerX = self.headBackView.centerX;
    self.avatarView.centerY = self.headBackView.centerY -  HalfF(70);
    [self.headBackView addSubview:self.avatarView];
    
    self.messageLabel.text = @"Bella";
    self.messageLabel.y = CGRectGetMaxY(self.avatarView.frame) + HalfF(20);
    self.messageLabel.size = CGSizeMake(kScreenWidth - HalfF(30), 30);
    self.messageLabel.centerX = self.headBackView.centerX;
    [self.headBackView addSubview:self.messageLabel];
    
}
#pragma mark -代理-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HalfF(100);
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentity = @"PSInfoViewController";
    
    UITableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentity];
    }
    tableViewCell.textLabel.text = @"图片下拉放大，导航上拉渐变";
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    
    NSLog(@"上下偏移量 OffsetY:%f ->",offset_Y);
    
    //1.处理图片放大
    CGFloat imageH = self.headBackView.size.height;
    CGFloat imageW = kScreenWidth;
    
    //下拉
    if (offset_Y < 0)
    {
        CGFloat totalOffset = imageH + ABS(offset_Y);
        CGFloat f = totalOffset / imageH;
        
        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
        self.headImageView.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offset_Y, imageW * f, totalOffset);
    }
    else
    {
        self.headImageView.frame = self.headBackView.bounds;
    }
    
    //2.处理导航颜色渐变  3.底部工具栏动画
    
    if (offset_Y > Max_OffsetY)
    {
        CGFloat alpha = MIN(1, 1 - ((Max_OffsetY + INVALID_VIEW_HEIGHT - offset_Y) / INVALID_VIEW_HEIGHT));
        
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
        
        if (offset_Y - _lastPosition > 5)
        {
            //向上滚动
            _lastPosition = offset_Y;
            
            //            [self bottomForwardDownAnimation];
        }
        else if (_lastPosition - offset_Y > 5)
        {
            // 向下滚动
            _lastPosition = offset_Y;
            //            [self bottomForwardUpAnimation];
        }
        self.title = alpha > 0.8? @"Bella":@"";
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
