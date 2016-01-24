//
//  UITableViewCell+Extension.h
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)
/**
 *  返回nib
 *
 *  @return 返回nib
 */
+ (UINib *)nib;

/**
 *  根据实体,设置cell样式
 *  @param entity 实体
 */
- (void)configCellWithEntity:(id)entity;
@end
