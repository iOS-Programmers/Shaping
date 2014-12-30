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
@property (nonatomic, strong) NSString* jsonString;

@property(nonatomic, strong) NSDictionary* userInfoByJsonDic;

@end
