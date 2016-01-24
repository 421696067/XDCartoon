//
//  Factory.h
//  XD
//
//  Created by 李攀祥 on 16/1/20.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Factory : NSObject
+(UILabel *)creatLabelFont:(float)font Alignment:(NSTextAlignment)alignment textColor:(UIColor *) color  bgColor:(UIColor *)bgColor autoLine:(BOOL)autoline;

+(UIImageView *)creatImageViewRadius:(float)radius;
@end
