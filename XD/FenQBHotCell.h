//
//  FenQBHotCell.h
//  XD
//
//  Created by 李攀祥 on 16/1/29.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void  (^didButblock)(NSString *);
@interface FenQBHotCell : UITableViewCell
@property (nonatomic,strong)didButblock block ;
@end
