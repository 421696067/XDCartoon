//
//  BaseDataSource.m
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "BaseDataSource.h"

@implementation BaseDataSource
// 初始化
- (id)initWithServerData:(NSArray *)serverData
      andCellIdentifiers:(NSArray *)identifiers
{
    self = [super init];
    if(self)
    {
        self.serverData = serverData;           // 数据
        self.cellIdentifiers = identifiers;     // 复用
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serverData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.cellIdentifiers[0];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}


@end
