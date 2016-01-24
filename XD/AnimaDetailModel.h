//
//  AnimaDetailModel.h
//  XD
//
//  Created by 李攀祥 on 16/1/20.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimaDetailModel : NSObject
proStr(_id);
proArr(categoryNames);//标签 国产 怀旧
proArr(directorNames);//作者的数组
proStr(url);//图片需要 手动添加
proStr(intro);//详细介绍
proStr(onairEpNumber);//更新至 多少话
proStr(score);//评分
proArr(seiyuNames);//声优
proStr(totalEpCount);//总共的集数
proStr(type);//类型
proStr(name);//名字

proStr(viewMode);//视频模式
proArr(videoSources);//视频来源
proStr(isEpCollection);//是否被收藏


proStr(commentCount);//评论数
proStr(picCount);
proStr(displayPlayCount);//播放次数
proStr(relatedTopicCount);
proStr(relatedImageTopicCount);
proArr(relatedTags);
proArr(studios);
proArr(scenaristNames);//编剧
proArr(aliases);// "Hei Mao Jing Zhang"  黑猫警长
proStr(chatGroupCount);//聊天组数量

@end
