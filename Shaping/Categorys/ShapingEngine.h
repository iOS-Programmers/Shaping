//
//  ShapingEngine.h
//  Shaping
//
//  Created by 李 广军 on 14-10-15.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPUserInfo.h"

#define LS_USERINFO_CHANGED_NOTIFICATION @"LS_USERINFO_CHANGED_NOTIFICATION"

typedef void(^onAppServiceBlock)(NSInteger tag, NSDictionary* jsonRet, NSError* err);

@interface ShapingEngine : NSObject

@property (nonatomic,readonly) NSString* baseUrl;

@property(nonatomic, strong) NSString *confirm;
@property(nonatomic, strong) NSString* token;
@property(nonatomic, strong) NSString* userPassword;
@property(nonatomic, strong) NSString* uid;
@property(nonatomic, strong) SPUserInfo* userInfo;

+ (ShapingEngine*)shareInstance;
+ (NSString*)getErrorMsgWithReponseDic:(NSDictionary*)dic;
+ (NSString*)getErrorCodeWithReponseDic:(NSDictionary*)dic;

- (NSString*)getCurrentAccoutDocDirectory;
- (void)saveAccount;
- (void)deleteAccount;
- (BOOL)hasAccoutLoggedin;
- (void)logout;

/**
 *  登录成功后，保存用户token，后面的所有接口请求用到
 *
 *  @param str token
 */
+ (void)saveUserToken:(NSString *)str;

+ (NSString *)userToken;

#pragma mark -Delegate
- (int)getConnectTag;
- (void)addOnAppServiceBlock:(onAppServiceBlock)block tag:(NSInteger)tag;
- (void)removeOnAppServiceBlockForTag:(NSInteger)tag;

#pragma mark - HttpRequest
//注册接口
- (BOOL)registerUserInfo:(NSString *)userName mobile:(NSString *)mobile password:(NSString *)password confirm:(NSString *)confirm tag:(int)tag;
//登录接口
- (BOOL)logInUserInfo:(NSString *)userName token:(NSString *)token password:(NSString *)password confirm:(NSString *)confirm tag:(int)tag;
//首页热点推荐
- (BOOL)getHomeHotTopListWith:(int)page tag:(int)tag;
//首页专辑推荐
- (BOOL)getHomeAlbumTopListWith:(int)page tag:(int)tag;

@end
