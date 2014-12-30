//
//  URLHelper.h
//  WeiJiFen
//
//  Created by 李 广军 on 14-10-16.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject

+ (NSString *)getURL:(NSString *)baseUrl
     queryParameters:(NSDictionary*)params;
+ (NSString *)getURL:(NSString *)baseUrl
     queryParameters:(NSDictionary*)params prefixed:(BOOL)prefixed;
+ (NSString *)encodeString:(NSString *)string;

@end
