//
//  PathHelper.h
//  WeiJiFen
//
//  Created by 李 广军 on 14-10-16.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathHelper : NSObject {
    
}

+ (BOOL)documentDirectoryPathIsExist:(NSString*)name;

+ (BOOL)createPathIfNecessary:(NSString*)path;

+ (NSString*)documentDirectoryPathWithName:(NSString*)name;

+ (NSString*)cacheDirectoryPathWithName:(NSString*)name;

@end
