//
//  NewsModel.m
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
//初始化字典，将数组中字典的值取出来赋给新的字典。


-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self =[super init]){
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}


//创建一个新的字典
+(instancetype)NewsModelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}



+(NSArray *)NewsModelList:(NSArray *)dataArray{
    
    NSArray *news_array = dataArray;
    
    NSMutableArray *news_m_array = [NSMutableArray array];
    
    for (NSDictionary *dic in news_array) {
        NewsModel *nmc = [NewsModel NewsModelWithDic:dic];
        [news_m_array addObject:nmc];
    }
    return news_m_array;
}
@end
