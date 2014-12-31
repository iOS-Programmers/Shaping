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
@property (nonatomic, strong) NSString* nickName;
@property (nonatomic, strong) NSString* height;
@property (nonatomic, strong) NSString* intro;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int attentionCount;
@property (nonatomic, assign) int fansCount;
@property (nonatomic, assign) int planCount;
@property (nonatomic, assign) int expCount;

@property (nonatomic, strong) NSString* jsonString;

@property(nonatomic, strong) NSDictionary* userInfoByJsonDic;

@end
