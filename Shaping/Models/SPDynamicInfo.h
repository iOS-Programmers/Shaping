//
//  SPDynamicInfo.h
//  Shaping
//
//  Created by Jyh on 12/31/14.
//  Copyright (c) 2014 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDynamicInfo : NSObject

@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* dyna_zanId;
@property (nonatomic, strong) NSString* createTime;
@property (nonatomic, strong) NSString* diss_content;
@property (nonatomic, strong) NSString* nickName;
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* place;
@property (nonatomic, strong) NSString* dyna_likeId;
@property (nonatomic, strong) NSString* user_dynamic_id;
@property (nonatomic, strong) NSString* userType;

@property(nonatomic, strong) NSString* jsonString;

@property(nonatomic, strong) NSDictionary* dynamicInfoByJsonDic;

//设置动态数据
- (void)setDynamicInfoByJsonDic:(NSDictionary*)dic;

@end
