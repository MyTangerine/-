//
//  MainView.m
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "MainView.h"
#import "NewsController.h"
#import "OPController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
CGFloat const tabViewHeight = 49;
CGFloat const btnWidth = 64;
CGFloat const btnHeight = 45;
@interface MainView ()
@property (strong,nonatomic)UIView *tab_bar_view;

@end


@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden  = NO;
    [self initTabBarView];
    [self initViewController];
}



-(void)initViewController{
    
    NewsController *main_news_view = [[NewsController alloc]init];
    main_news_view.tabBarItem.image = [UIImage imageNamed: @"image_news"];
    main_news_view.tabBarItem.title =@"首页";
    
    
    OPController *main_op_view = [[OPController alloc]init];
    main_op_view.tabBarItem.image = [UIImage imageNamed:@"image_option"];
    main_op_view.tabBarItem.title = @"设置";
    
    
    NSArray *viewcontroller_array = @[main_news_view,main_op_view];
    NSMutableArray *viewcontroller_m_array = [NSMutableArray arrayWithCapacity:viewcontroller_array.count];
    
    for (int i =0 ; i<viewcontroller_array.count;i++){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewcontroller_array[i]];
        [viewcontroller_m_array addObject:nav];
    }
    
    self.viewControllers = viewcontroller_m_array;
}
-(void)initTabBarView{
    //自定义uiview 代替系统给的TabBar
    //      _tab_bar_view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - tabViewHeight, kScreenWidth, tabViewHeight)];
    //    _tab_bar_view.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:_tab_bar_view];
    
    
    
    
    
    
}


@end
