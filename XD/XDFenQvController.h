//
//  XDFenQvController.h
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CellBlock)(NSString *);
@interface XDFenQvController : UIViewController
@property(nonatomic,strong)CellBlock cellButBlock;
@end
