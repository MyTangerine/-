//
//  News.m
//  猿码
//
//  Created by 橘子 on 16/5/19.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "NewsData.h"

@implementation NewsData
- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.id = [dictionary objectForKey:@"id"];
        self.title = [dictionary objectForKey:@"title"];
        self.des = [dictionary objectForKey:@"des"];
        self.summary = [dictionary objectForKey:@"summary"];
        self.author =[dictionary objectForKey:@"author"];
    }
    return self;
}

@end
