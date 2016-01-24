//
//  TuiJianModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/9.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuiJianModel : NSObject
@end

/*!
 * 推荐广告业
 */
@interface TuiJianADModel : NSObject
@property(nonatomic,copy) NSString * url ;
@property(nonatomic,copy) NSString * imageUrl;
@end

/*!
 * 推荐广告业的Manger
 */
@interface TuiJianadManger : NSObject
+(NSArray *)arrJsonWithData:(NSData *)data;
@end
/*!
 *  番组广告业的manger
 */
@interface FanZuAdManger : NSObject
+(NSArray *)arrWithDict:(NSDictionary *)dict;
@end

/*!
 * 推荐--本季model
 */
@interface tuijianBJModel : NSObject
proStr(_id);
proStr(name);
proStr(onairEpNumber);
proStr(url);
@end
/*!
 * 推荐--本季manger
 */
@interface TuiJianBJManger : NSObject
+(NSArray *)arrayWithArr:(NSArray *)arr;


@end
