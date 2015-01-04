//
//  SPUserInfo.h
//  Shaping
//
//  Created by KID on 14/12/30.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUserInfo : NSObject

@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* height;
@property (nonatomic, strong) NSString* intro;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int attentionCount;
@property (nonatomic, assign) int fansCount;
@property (nonatomic, assign) int planCount;
@property (nonatomic, assign) int expCount;

@property (nonatomic, strong) NSString* jsonString;

@property(nonatomic, strong) NSDictionary* userInfoByJsonDic;

//details
@property (nonatomic, strong) NSString* nickName;
@property (nonatomic, assign) int userType;//用户类型
@property (nonatomic, strong) NSURL* avatar;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* weixin;
@property (nonatomic, strong) NSString* qq;
@property (nonatomic, strong) NSString* sinaWeibo;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, assign) int regDate;
@property (nonatomic, assign) int lastDate;
@property (nonatomic, strong) NSString* lastIp;

@property(nonatomic, strong) NSDictionary* userDetailsInfoByJsonDic;

@end
