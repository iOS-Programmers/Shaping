//
//  SPTopicInfo.h
//  Shaping
//
//  Created by liguangjun on 14-12-30.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPTopicInfo : NSObject

@property (nonatomic, strong) NSString* tId;
@property (nonatomic, strong) NSString* title;//标题
@property (nonatomic, strong) NSString* content;//内容
@property (nonatomic, assign) int createTime;//发布时间
@property (nonatomic, assign) int isIndex;//是否推荐 1是0否
@property (nonatomic, readonly) NSURL* imgUrl;

@property(nonatomic, strong) NSString* jsonString;

- (void)setHotTopicInfoByDic:(NSDictionary*)dic;

- (void)setAlbumTopicInfoByDic:(NSDictionary*)dic;//热门推荐
@end
