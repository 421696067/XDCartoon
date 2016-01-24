//
//  GroupDataSource.m
//  XD
//
//  Created by 李攀祥 on 16/1/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "GroupDataSource.h"

@implementation GroupDataSource
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.serverData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr=self.serverData[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.cellIdentifiers[0];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

@end
