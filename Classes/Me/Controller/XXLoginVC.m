//
//  XXLoginVC.m
//  SmileBella
//
//  Created by Bella on 17/1/9.
//  Copyright © 2017年 Bella. All rights reserved.
//

#import "XXLoginVC.h"
#import <Masonry.h>
#import "UIButton+Extension.h"
#import <MBProgressHUD.h>
#import "XXUsCenterVC.h"

@interface XXLoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *AccoutFiled; //监听文本输入 可以用代理
@property (nonatomic, strong)UITextField *passWord;
@property (nonatomic, strong)UIButton *LoginBtn;

@end

@implementation XXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    
//    //用代理方法监听文本输入内容
//    self.AccoutFiled.delegate = self;
//    self.passWord.delegate = self;
    
    
}

//当文本框内容发生变化时调用
-(void)TextChange{
    //enabled 按钮不可以点击  Bool值
    self.LoginBtn.enabled = self.AccoutFiled.text.length && self.passWord.text.length;
    NSLog(@"AccoutFiled == %@",self.AccoutFiled.text);
    NSLog(@"passWord == %@",self.passWord.text);

//    //拿到userdefaults
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    //保存的也是一个plist
//    [defaults setObject:@"xx" forKey:@"name"];
//    [defaults setInteger:10 forKey:@"age"];
////    defaults setBool:<#(BOOL)#> forKey:<#(nonnull NSString *)#>
//    
//    //立马写入文件中
//    [defaults synchronize];
    
    
    
    
    
}

-(void)go2lastView{
    
    //用什么存的 用什么取   存的时候是什么类型  取的时候就用什么类型取
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *name =  [defaults objectForKey:@"name"];
//    NSInteger age = [defaults integerForKey:@"age"];
//    NSLog(@"name == %@",name);
//    NSLog(@"~~~~~~%ld",age);
    
    //如果用户名跟密码正确,跳转到下一个界面
    //提醒用户登录
    NSLog(@"点击登录");
    if ([self.AccoutFiled.text isEqualToString:@"xiaoxiao"] && [self.passWord.text isEqualToString:@"123123"]) {
        NSLog(@"denglu zhong ");
        
        //保存用户名和密码到沙盒
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.AccoutFiled.text forKey:@"account"];
        [defaults setObject:self.passWord.text forKey:@"passworld"];
        //立马写入文件
        [defaults synchronize];
        
        //打印路径 看有没有保存成功
        NSLog(@"Home == %@",NSHomeDirectory());
        
      
        [self dismissViewControllerAnimated:YES completion:nil];
         
        
    }else{
        
        NSLog(@"用户名或密码");
        
    }
    
}


//创建布局
-(void)initView{
    
    UIImageView *backImage = [UIImageView new];
    backImage.image = [UIImage imageNamed:@"login_register_background"];
    backImage.userInteractionEnabled = YES; //东西加在图片上必须交互
    
    UIButton *backButton = [UIButton new];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setImage: [UIImage imageNamed: @"login_close_icon" ] forState:UIControlStateNormal];
    [backButton addActionWithTouchUpInside:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    
    UIView *userView = [UIView new];
//    userView.backgroundColor = xRed;
    
    UIImageView *ViewBackImage = [UIImageView new];
    ViewBackImage.image = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    
    UITextField *Account = [UITextField new];
    Account.placeholder = @"手机号";  //暗文输入属性
    Account.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.AccoutFiled = Account;
    [Account addTarget:self action:@selector(TextChange) forControlEvents:UIControlEventEditingChanged];
    
    UITextField *passWord = [UITextField new];
    passWord.placeholder = @"密码";
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing; //当编辑的时候出现XX
    self.passWord = passWord;
     [passWord addTarget:self action:@selector(TextChange) forControlEvents:UIControlEventEditingChanged]; //文本框编辑变化时  UIControlEventEditingChanged
    UILabel *remberLabel = [UILabel new];
    remberLabel.text = @"记住密码";
    remberLabel.font = [UIFont systemFontOfSize:12];
    
    UILabel *atomaticLable = [UILabel new];
    atomaticLable.text = @"自动登录";
    atomaticLable.font = [UIFont systemFontOfSize:12];
    
    UISwitch *rember = [UISwitch new];
    
    
    UISwitch *atomatic = [UISwitch new];
    
    UIButton *loginBtn = [UIButton new];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = xRed;
    self.LoginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(go2lastView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registeredBtn = [UIButton new];
    [registeredBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    UIButton *forgetBtn = [UIButton new];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [self.view addSubview:backImage];
    [backImage addSubview:userView];
    [userView addSubview:Account];
    [userView addSubview:passWord];
    [userView addSubview:ViewBackImage];
    [backImage addSubview:backButton];
    [backImage addSubview:loginBtn];
    [backImage addSubview:registeredBtn];
    [backImage addSubview:forgetBtn];
    [backImage addSubview:remberLabel];
    [backImage addSubview:atomaticLable];
    [backImage addSubview:rember];
    [backImage addSubview:atomatic];
    
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
        make.centerY.offset(0);
    }];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImage.mas_top).offset(10);
        make.left.equalTo(backImage.mas_left).offset(10);
        make.size.mas_offset(CGSizeMake(45, 45));
    }];
    [registeredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImage.mas_top).offset(15);
        make.right.equalTo(backImage.mas_right).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(250, 150));
        make.centerY.offset(-130);
        make.centerX.offset(0);
    }];
    [ViewBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(userView);
    }];
    [Account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userView.mas_left);
        make.top.equalTo(userView.mas_top).offset(21);
        make.right.equalTo(userView.mas_right);
        make.height.offset(50);
    }];
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userView.mas_left);
        make.top.equalTo(Account.mas_bottom).offset(21);
        make.right.equalTo(userView.mas_right);
        make.height.offset(50);
    }];
    
    [remberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView.mas_bottom).offset(8);
        make.left.equalTo(userView.mas_left);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    [rember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remberLabel.mas_top);
        make.left.equalTo(remberLabel.mas_right).offset(5);
    }];
    
    [atomaticLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView.mas_bottom).offset(8);
        make.right.equalTo(atomatic.mas_left).offset(-5);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    [atomatic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(atomaticLable.mas_top);
        make.right.equalTo(userView.mas_right);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(userView.mas_bottom).offset(30);
        make.centerY.offset(30);
        make.centerX.offset(0);
        make.size.mas_offset(CGSizeMake(250, 30));
    }];
    
   
    
}



////是否允许textField方法改变
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//
//    return YES;
//}



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
