//
//  SortViewController.h
//  XD
//
//  Created by 李攀祥 on 16/1/18.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CellClickBlock)(NSString * ,NSString *);
@interface SortViewController : UIViewController
@property (nonatomic,strong)CellClickBlock cellBlock;
@end
