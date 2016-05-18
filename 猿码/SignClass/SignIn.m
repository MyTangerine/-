//
//  SignIn.m
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "SignIn.h"
#import "MainView.h"
@interface SignIn()<UITextFieldDelegate>
@property (weak,nonatomic)UIView *cardView;
@property (weak,nonatomic)UIView *headView;
@property (weak,nonatomic) UITextField *useremail;
@property (weak,nonatomic) UITextField *userpassword;
@end

@implementation SignIn
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    /**
     设置底层背景图片
     */
    UIImageView *self_imageview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //    self_imageview.image = [UIImage imageNamed:@"image_card"];
    [self.view addSubview:self_imageview];
    [self.view setBackgroundColor:[UIColor greenColor]];
    /**
     添加两个UIView
     */
    UIView * login_view_card = [[UIView alloc]initWithFrame:CGRectMake(30, 200, 320, 300)];
    [login_view_card setBackgroundColor:[UIColor clearColor]];
    UIView *login_view_head = [[UIView alloc]initWithFrame:CGRectMake(150, 160, 80, 80)];
    [login_view_head setBackgroundColor:[UIColor clearColor]];
    
    self.cardView = login_view_card;
    self.headView = login_view_head;
    
    
    
    [self.view addSubview:login_view_card];
    [self.view addSubview:login_view_head];
    
    login_view_card.layer.cornerRadius = 15;
    login_view_card.layer.masksToBounds = YES;//设置圆角
    
    /**
     设置卡片的样式
     */
    
    UIImageView * imageview_card = [[UIImageView alloc]initWithFrame:login_view_card.bounds];
    [imageview_card setBackgroundColor:[UIColor whiteColor]];
    [login_view_card addSubview:imageview_card];
    
    /**
     绘制uiview卡片的图形样式
     */
    UIBezierPath *uiview_card_path = [[UIBezierPath alloc]init];
    [uiview_card_path moveToPoint:CGPointMake(0, 0)];
    [uiview_card_path addLineToPoint:CGPointMake(0, 300)];
    [uiview_card_path addLineToPoint:CGPointMake(320, 300)];
    [uiview_card_path addLineToPoint:CGPointMake(320, 0)];
    [uiview_card_path addArcWithCenter:CGPointMake(160, 0) radius:45 startAngle:0 endAngle:M_PI clockwise:YES];
    [uiview_card_path addLineToPoint:CGPointMake(110, 0)];
    [uiview_card_path closePath];
    CAShapeLayer *shape_uiview_card = [CAShapeLayer layer];
    shape_uiview_card.path = uiview_card_path.CGPath;
    login_view_card.layer.mask = shape_uiview_card;
    
    /**
     设置圆形头像
     */
    
    UIImageView *imageview_head = [[UIImageView alloc]initWithFrame:login_view_head.bounds];
    imageview_head.image = [UIImage imageNamed:@"image_head"];
    [login_view_head addSubview:imageview_head];
    
    UIBezierPath *head_path = [[UIBezierPath alloc]init];
    [head_path addArcWithCenter:CGPointMake(40, 40) radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *head_layer = [CAShapeLayer layer];
    head_layer.path  = head_path.CGPath;
    imageview_head.layer.mask = head_layer;
    
    /**
     设置 登陆 注册事件 按钮
     */
    
    UIButton *btn_login = [[UIButton alloc]initWithFrame:CGRectMake(40, 205, 250,35 )];
    [btn_login setBackgroundColor:[UIColor colorWithRed:50/255.0f green:205/255.0f blue:50/255.0f alpha:1.0f]];
    [btn_login setTitle:@"登陆" forState:UIControlStateNormal];
    [login_view_card addSubview:btn_login];
    UIButton *btn_regist = [[UIButton alloc]initWithFrame:CGRectMake(40, 250, 250, 35)];
    [btn_regist setBackgroundColor:[UIColor colorWithRed:50/255.0f green:205/255.0f blue:50/255.0f alpha:1.0f]];
    [btn_regist setTitle:@"注册" forState:UIControlStateNormal];
    [login_view_card addSubview:btn_regist];
    /************************注册事件*************************************/
    
    
    [btn_login addTarget:self action:@selector(beginAnimationWithLogInCard) forControlEvents:UIControlEventTouchUpInside];
    //    [btn_login addTarget:self action:@selector(SignInPost) forControlEvents:UIControlEventTouchUpInside];
    
    //    [btn_login addTarget:self action:@selector(changeToMainNewsView) forControlEvents:UIControlEventTouchUpInside];
    /*******************************************************************/
    btn_regist .layer.cornerRadius = 15;
    btn_regist.layer.masksToBounds = YES;
    
    btn_login.layer.cornerRadius = 15;
    btn_login.layer.masksToBounds = YES;
    
    /**
     设置 文本
     */
    UILabel *label_user = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 70, 35)];
    [label_user setText:@"账户"];
    [login_view_card addSubview:label_user];
    UILabel *label_password = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, 70, 35)];
    [label_password setText:@"密码"];
    [login_view_card addSubview:label_password];
    
    /**
     设置 输入框
     */
    UITextField *text_user = [[UITextField alloc]initWithFrame:CGRectMake(70, 60, 230, 35)];
    text_user.placeholder = @"请输入帐号";
    UITextField *text_password = [[UITextField alloc]initWithFrame:CGRectMake(70, 105, 230, 35)];
    text_password.placeholder = @"请输入密码";
    
    [text_user setBackgroundColor:[UIColor whiteColor]];
    [text_password setBackgroundColor:[UIColor whiteColor]];
    
    text_user.clearButtonMode = UITextFieldViewModeWhileEditing;
    text_password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [text_user addTarget:self action:@selector(textFieldDoneEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [text_password addTarget:self action:@selector(textFieldDoneEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    text_password.returnKeyType = UIReturnKeyDone;
    text_user.returnKeyType = UIReturnKeyDone;
    
    text_user.keyboardType  = UIKeyboardTypeASCIICapable;
    text_password.keyboardType  = UIKeyboardTypeASCIICapable;
    /*  UITextField 的阴影效果
     UIBezierPath *text_shadow_path = [UIBezierPath bezierPathWithRect:text_user.bounds];
     text_user.layer.masksToBounds = NO;
     text_user.layer.shadowColor = [UIColor blackColor].CGColor;
     text_user.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
     text_user.layer.shadowOpacity = 0.5f;
     text_user.layer.shadowPath = text_shadow_path.CGPath;
     */
    
    text_password.secureTextEntry = YES;
    self.useremail = text_user;
    self.userpassword = text_password;
    
    [login_view_card addSubview:text_password];
    [login_view_card addSubview:text_user];
    
    
}

/**
 UIButton 注册事件 设置 动画
 */

-(void)changeToMainNewsView{
    MainView *main_view = [[MainView alloc]init];
    [self presentViewController:main_view animated:YES completion:nil];
}

-(void)beginAnimationWithLogInCard{
    
    [UIView animateWithDuration:1.5f animations:^{
        CGPoint point_head = self.headView.center;
        CGPoint point_card = self.cardView.center;
        point_head.y +=100;
        point_card.y +=150;
        CGFloat alpha = self.cardView.alpha;
        alpha -=1.0f;
        [self.cardView setAlpha:alpha];
        [self.headView setCenter:point_head];
        [self.cardView setCenter:point_card];
    }completion:^(BOOL finished){
        
        [self changeToMainNewsView];
    }];
    
    
    
    
    
    
    
    
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:1.5];
    //        CGPoint point_head = self.headView.center;
    //        CGPoint point_card = self.cardView.center;
    //        point_head.y +=100;
    //        point_card.y +=150;
    //        CGFloat alpha = self.cardView.alpha;
    //        alpha -=1.0f;
    //        [self.cardView setAlpha:alpha];
    //        [self.headView setCenter:point_head];
    //        [self.cardView setCenter:point_card];
    //
    //    [UIView commitAnimations];
    //
    //        [self changeToMainNewsView];
    //
    
}


-(void)textFieldDoneEditing{
    [self.useremail resignFirstResponder];
    [self.userpassword resignFirstResponder];
}


-(void)SignInPost{
    
    /*
     https://coding.net/api/account/login?email=liuyizhou691601028%40vip.qq.com&password=liuyizhou6864648
     https://coding.net/api/getCaptcha
     
     */
    NSRange range_user_email= [self.useremail.text rangeOfString:@"@"];
    NSUInteger a = range_user_email.location;
    NSUInteger b = range_user_email.location +1;
    NSString *email1 = [self.useremail.text substringToIndex:a];
    NSString *email2 = @"%40";
    NSString *email3 = [self.useremail.text substringFromIndex:b];
    
    NSString *password = self.userpassword.text;
    
    NSString *post_login_url_str = [[NSString alloc]initWithFormat:@"https://coding.net/v2/api/account/login?email=%@%@%@&password=%@",email1,email2,email3,password];
    
    NSURL *post_login_url = [[NSURL alloc]initWithString:post_login_url_str];
    NSMutableURLRequest *post_login_request = [[NSMutableURLRequest alloc]initWithURL:post_login_url cachePolicy:1 timeoutInterval:15.0f];
    [post_login_request setHTTPMethod:@"POST"];
    
    NSData *callback_data = [NSURLConnection sendSynchronousRequest:post_login_request returningResponse:nil error:nil];
    
    
    callback_data = [NSJSONSerialization JSONObjectWithData:callback_data options:NSJSONReadingMutableContainers error:nil];

    
}

@end


