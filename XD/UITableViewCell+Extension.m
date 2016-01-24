//
//  UITableViewCell+Extension.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

//这个是注册的时候使用
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

//这个是给cell 赋值的时候使用 也就是设置cell的样式的时候使用
- (void)configCellWithEntity:(id)entity
{
    
}

@end
