//
//  NewsModel.h
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *title_from;
@property (nonatomic,copy) NSString *desc;
+(NSArray *)NewsModelList;

@end
