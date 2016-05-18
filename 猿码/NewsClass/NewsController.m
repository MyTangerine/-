//
//  NewsController.m
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "NewsController.h"
#import "TableViewCellView.h"
#import "MJRefresh.h"
#import <CoreData/CoreData.h>

#define NAVRect self.navigationController.navigationBar.frame
CGFloat const writeButtonWidth = 33;
CGFloat const writeButtonHeight = 32;
@interface NewsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic)NSArray *newsModelClass;
@property (nonatomic,strong)NSManagedObjectContext *context;

@end

@implementation NewsController


-(NSArray *)newsModelClass{
    if (_newsModelClass == nil){
        _newsModelClass = [NewsModel NewsModelList];
    }
    return _newsModelClass;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    [self getCoreDataComtext];
    [self savaData];
    
    
    [self initNavigationButton];
    [self tableViewShow];
    
}




-(void)initNavigationButton{
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(0, 0, writeButtonWidth, writeButtonHeight);
    [test setBackgroundImage:[UIImage imageNamed:@"image_write"] forState:UIControlStateNormal];
    [test setBackgroundImage:[UIImage imageNamed:@"image_write_on"] forState:UIControlStateHighlighted];
    [test setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:test];
    self.navigationItem.rightBarButtonItem = item;
}


#pragma -mark UITableView 控制

-(void)tableViewShow{
    
    
    UITableView *news_table_view = [[UITableView alloc]initWithFrame:CGRectMake(0, -25, 375, 700)style:UITableViewStyleGrouped];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    news_table_view.dataSource = self;
    news_table_view.delegate = self;
    [self.view addSubview:news_table_view];
    news_table_view.rowHeight = 180;
    
    news_table_view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    
    news_table_view.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginMJRefresh)];
    [news_table_view.mj_header beginRefreshing];
    
    
    
    news_table_view.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
    news_table_view.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginMJRefresh)];
    //    news_table_view.separatorStyle =UITableViewCellSeparatorStyleNone;
}

//-(void)beginMJRefresh{
//    NSLog(@"开始刷新了");
//}

#pragma -mark 返回cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsModelClass.count;
}

#pragma -mark 创建一个数据库的上下文



#pragma -mark 创建了一个获取json方法
-(void)getCoreDataComtext{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSLog(@"%@",path);
    
    NSURL *dataUrl = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"NewsModel.sqlite"]];
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]init];
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    NSError *error = nil;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dataUrl options:nil error:&error];
    [context setPersistentStoreCoordinator:store];
    self.context = context;
}



-(void)savaData{
    
    
    for(int num = 0; num <6;num++){
        NSString *str = [[NSString alloc]initWithFormat:@"http://119.29.58.43/api/getSfBlog/getPage=%d",num];
        NSURL *url = [[NSURL alloc]initWithString:str];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:1 timeoutInterval:15.0f];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (data==nil){
            return ;
        }
        NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (int j = 0 ; j <8 ; j++){
            
            
            if([self fetchDataID:[dicArray[j] objectForKey:@"id"]]){
                NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"News"inManagedObjectContext:self.context];
                [obj setValue:[dicArray[j] objectForKey:@"author"] forKey:@"author"];
                [obj setValue:[dicArray[j] objectForKey:@"id"] forKey:@"id"];
                [obj setValue:[dicArray[j] objectForKey:@"des"] forKey:@"des"];
                [obj setValue:[dicArray[j] objectForKey:@"summary"] forKey:@"summary"];
                [obj setValue:[dicArray[j] objectForKey:@"title"] forKey:@"title"];
            }
            else{
                continue;
            }
        }
        NSError *error = nil;
        if (![self.context save:&error]){
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }
}
-(BOOL)fetchDataID:(NSString *)idStr{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:self.context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",idStr];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:fetchRequest error:&error];
    if (array.count)
        return NO;
    else
        return YES;
}






-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCellView *cell = [TableViewCellView newsTableViewCellWithTableView:tableView];
    //从字典里面获取相应的索引值
    NewsModel *reuseCellId = self.newsModelClass[indexPath.row];
    //获取到的值赋给cell的model
    cell.newsModel = reuseCellId;
    return cell;
}

@end
