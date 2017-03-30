//
//  XXDailyDetailVC.m
//  SmileBella
//
//  Created by Bella on 17/1/23.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXDailyDetailVC.h"
#import <UIImageView+WebCache.h>
#import "UIView+Addition.h"
#import "XXZFplayVC.h"
#import "XXPlayVC.h"

@interface XXDailyDetailVC ()

@end

@implementation XXDailyDetailVC

- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setUISwipe];
 
}


-(void)setUI{
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView sd_setImageWithURL:[NSURL URLWithString:self.model.ImageView] completed:nil];
    [self.view addSubview:backImageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurView.frame = backImageView.bounds;
    [backImageView addSubview:blurView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.ImageView] completed:nil];
    [self.view addSubview:imageView];
    
    UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 35, kScreenWidth/2 - 35, 70, 70)];
    playImage.image = [UIImage imageNamed:@"play"];
    [self.view addSubview:playImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageView.bottom + 10, kScreenWidth - 20, 20)];
    titleLabel.text = self.model.titleLabel;
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.font = [UIFont fontWithName:MyChinFont size:16.f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.bottom + 10, kScreenWidth - 20, 20)];
    messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",self.model.category,@" / ",[self timeStrFormTime:self.model.duration]];
    messageLabel.textColor = [UIColor yellowColor];
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:messageLabel];
    
    UIButton *Linebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, messageLabel.bottom + 10, kScreenWidth - 10, 1)];
    [Linebtn setBackgroundColor:[UIColor grayColor]];
    Linebtn.userInteractionEnabled = NO;
    [self.view addSubview:Linebtn];
    
    // Desc
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Linebtn.bottom + 10, kScreenWidth - 20, 100)];
    desLabel.text = self.model.desc;
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font = [UIFont systemFontOfSize:15];
    desLabel.textAlignment = NSTextAlignmentLeft;
    desLabel.numberOfLines = 0;
    
    // 设置Desc行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.model.desc];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.model.desc length])];
    [desLabel setAttributedText:attributedString1];
    [desLabel sizeToFit];
    
    [self.view addSubview:desLabel];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 25,25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    backBtn.backgroundColor = [UIColor grayColor];
//    backBtn.layer.cornerRadius = 15;
//    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(BackButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    NSArray *arr = [NSArray arrayWithObjects:
                    [UIImage imageNamed:@"collect"],
                    [UIImage imageNamed:@"upload"],
                    [UIImage imageNamed:@"btn_airplay_normal"],
                    [UIImage imageNamed:@"btn_download_normal@2x"], nil];
    
    NSDictionary *dict = self.model.consumption;
    NSArray *messageArr = [NSArray arrayWithObjects:
                           [NSString stringWithFormat:@"%@",dict[@"collectionCount"]],
                           [NSString stringWithFormat:@"%@",dict[@"shareCount"]],
                           [NSString stringWithFormat:@"%@",dict[@"replyCount"]],
                           [NSString stringWithFormat:@"%@",@"缓存"], nil];
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *image = [[UIImageView alloc]init];
        UIButton *Btn = [[UIButton alloc]init];
        image.frame = CGRectMake(kScreenWidth/5 * i + 10, kScreenHeight - 48, 15, 15);
        Btn.frame = CGRectMake(kScreenWidth/5 * i + 25, kScreenHeight - 50, 45, 20);
        image.image = arr[i];
        Btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        Btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [Btn setTitle:messageArr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        Btn.titleLabel.font = [UIFont fontWithName:MyChinFont size:12.f];
        Btn.tag = i;
        [Btn addTarget:self action:@selector(BottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:image];
        [self.view addSubview:Btn];
    }
}

-(void)BottomBtnClicked:(UIButton *)Btn{
    
    NSArray *arr = [NSArray arrayWithObjects:@"收藏",@"分享",@"评论",@"下载", nil];
    NSString *str = [NSString stringWithFormat:@"你点击了%@",arr[Btn.tag]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)setUISwipe{
    
    // 向下滑动
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)BackButtonDidClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
}


//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}

-(void)btnClicked{
    
    XXZFplayVC *videoPlay = [[XXZFplayVC alloc]init];
    videoPlay.urlStr = self.model.playUrl;
    videoPlay.titleStr = self.model.titleLabel;
    videoPlay.Time = [self.model.duration floatValue];
//    [self showDetailViewController:videoPlay sender:nil];
     [self.navigationController pushViewController:videoPlay animated:YES];
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
