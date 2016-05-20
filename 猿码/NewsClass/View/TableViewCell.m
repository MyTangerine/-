//
//  TableViewCellView.m
//  猿码
//
//  Created by 橘子 on 16/5/18.
//  Copyright © 2016年 NUC. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageNews;
@property (weak,nonatomic) IBOutlet UILabel *titleNews;
@property (weak,nonatomic) IBOutlet UILabel *desNews;

@end

@implementation TableViewCell

+(instancetype)newsTableViewCellWithTableView:(UITableView *)tableView{
    //设置静态可重用 id
    static NSString *reuseId = @"reuseCellId";
    /*
     cell的可重用操作
     定义一个可重用的cell队列池
     如果cell == nil
     就从队列池子里面拿出一个cell
     */
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

//数据模型进行控件赋值

-(void)setContent:(NewsData*)info{
    //    _modelClass = modelClass;
    self.headImageNews.image = [UIImage imageNamed:@"image_head"];
    
    
    NSAttributedString * attrDes = [[NSAttributedString alloc] initWithData:[info.des dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.desNews.attributedText = attrDes;
    
    
   NSAttributedString * attrTitle = [[NSAttributedString alloc] initWithData:[info.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.titleNews.attributedText = attrTitle;
        //  设置了头像的圆形效果
    CGRect imageHeadBounds = self.headImageNews.bounds;
    CGFloat x_path = imageHeadBounds.origin.x + (imageHeadBounds.size.width/2);
    CGFloat y_path = imageHeadBounds.origin.y+(imageHeadBounds.size.height/2);
    UIBezierPath *head_path = [[UIBezierPath alloc]init];
    [head_path addArcWithCenter:CGPointMake(x_path, y_path) radius:30 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *head_layer = [CAShapeLayer layer];
    head_layer.path  = head_path.CGPath;
    self.headImageNews.layer.mask = head_layer;
}
@end
