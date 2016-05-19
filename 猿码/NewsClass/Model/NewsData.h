//
//  News.h
//  猿码
//
//  Created by 橘子 on 16/5/19.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsData : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *author;
- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
