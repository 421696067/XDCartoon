//
//  BaseDataSource.h
//  XD
//
//  Created by 李攀祥 on 16/1/6.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableViewCell+Extension.h"
typedef void(^CellSelectedBlock)(id obj);
@interface BaseDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *cellIdentifiers;                // cell样式选择
@property (nonatomic, copy) NSArray *serverData;                     // cell数据
@property (nonatomic, copy) CellSelectedBlock cellSelectedBlock;   // cell点击事件
/**
 *  初始化dataSource
 *  @param serverData  服务器返回数据
 *  @param identifiers cell类型
 *  @return Datasource
 */
- (id)initWithServerData:(NSArray *)serverData
      andCellIdentifiers:(NSArray *)identifiers;
@end
