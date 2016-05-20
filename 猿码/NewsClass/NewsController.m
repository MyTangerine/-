//
//  NewsController.m
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "NewsController.h"
#import "TableViewCell.h"
#import "MJRefresh.h"
#import "NewsDetailView.h"

#import "NewsData.h"
#define NAVRect self.navigationController.navigationBar.frame
CGFloat const writeButtonWidth = 33;
CGFloat const writeButtonHeight = 32;
@interface NewsController ()<UITableViewDataSource,UITableViewDelegate>
{
        CoreDataManager *coreManager;
}
@property (nonatomic,strong)NSManagedObjectContext *context;
@property (nonatomic,strong)NSMutableArray *resultArray;
@property (nonatomic,weak)UITableView *tableView;

@end

@implementation NewsController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    
    [self getData];
    [self initNavigationButton];
    [self tableViewShow];
    
}


#pragma -mark 获取网络数据 
//-(void)cheakDataSource{
//    coreManager = [[CoreDataManager alloc]init];
//
//    
//    //更新时间
//    NSString *updateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateDate"];
//    
//    if (!updateDate) {
//        //如果无此对象，表示第一次，那么就读数据写到数据库中
//        [self getData];
//        
//    }else{
//        //有此对象说明只要从数据库中读数据
//        NSTimeInterval update = updateDate.doubleValue;
//        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
//        //8小时一更新
//        if ((now - update)>8*60*60) {
//            //如果超出八小时就把数据库清空再重新写
//            [coreManager deleteData];
//            [self getData];
//        }else{
//            //没有超过8小时就从数据库中读
//            NSMutableArray *array = [coreManager selectData:10 andOffset:0];
//            _resultArray = [NSMutableArray arrayWithArray:array];
//            [self.tableView reloadData];
//        }
//    }
//    
//
//}

-(void)getData{
    int num = 0;
    NSString *str = [[NSString alloc]initWithFormat:@"http://119.29.58.43/api/getSfBlog/getPage=%d",num];
    NSURL *url = [[NSURL alloc]initWithString:str];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:1 timeoutInterval:15.0f];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data==nil){
        return ;
    }
    NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    self.resultArray = [NSMutableArray arrayWithCapacity:dicArray.count];
    
    for (NSDictionary *dic in dicArray) {
        NewsData *info = [[NewsData alloc]initWithDictionary:dic];
        [self.resultArray addObject:info];
    }
    NSLog(@"%lu",(unsigned long)self.resultArray.count);
}




#pragma -mark UITableView 控制

-(void)initNavigationButton{
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(0, 0, writeButtonWidth, writeButtonHeight);
    [test setBackgroundImage:[UIImage imageNamed:@"image_write"] forState:UIControlStateNormal];
    [test setBackgroundImage:[UIImage imageNamed:@"image_write_on"] forState:UIControlStateHighlighted];
    [test setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:test];
    self.navigationItem.rightBarButtonItem = item;
}




-(void)tableViewShow{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 375, 625) style:UITableViewStyleGrouped];
    NSLog(@"%@",NSStringFromCGRect(NAVRect));
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.rowHeight =150;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
  
}








#pragma -mark 返回cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _resultArray.count;
}


#pragma -mark 自定义cell设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [TableViewCell newsTableViewCellWithTableView:tableView];
    //从字典里面获取相应的索引值
    NewsData *info = [_resultArray objectAtIndex:indexPath.row];
    //获取到的值赋给cell的model
    [cell setContent:info];
    return cell;
}
#pragma -mark 添加cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailView *detailView = [[NewsDetailView alloc]init];
    [self.navigationController pushViewController:detailView animated:NO];
}
@end
