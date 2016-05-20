//
//  TableViewCellView.h
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsData.h"
@interface TableViewCell : UITableViewCell

+(instancetype)newsTableViewCellWithTableView:(UITableView *)tableView;
-(void)setContent:(NewsData*)info;
@end
