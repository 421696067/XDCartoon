//
//  FenQBModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/29.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FenQBModel : NSObject
@end

@interface FenQBAD : NSObject

@end

@interface FenQBHot : NSObject
proStr(_id);//需要传出去的变量
proStr(title);
proStr(status);
proStr(playCount);//播放次数
proStr(url);//需要自己设置的属性
@end

@interface FenQBNews : NSObject
@end

/*!
 * Hot和Tuijian的数据处理
 */
@interface FenQBHotManger : NSObject
+(NSArray *)arrWithArr:(NSArray *)arr;
@end
