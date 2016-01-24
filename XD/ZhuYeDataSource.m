//
//  ZhuYeDataSource.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ZhuYeDataSource.h"

@implementation ZhuYeDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers[0]forIndexPath:indexPath];
    //如果不是分组的 就这样写
        [cell configCellWithEntity:self.serverData[indexPath.row]];
    //分组的这样写
    //NSArray * arr=self.serverData[indexPath.section];
    //[cell configCellWithEntity:arr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellNormalHeight*View_Radio;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellSelectedBlock(indexPath);
}

@end
