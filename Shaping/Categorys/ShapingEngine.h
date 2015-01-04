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

/**
 *  登录成功后，保存用户id
 *
 *  @param str 用户的ID
 */
+ (void)saveUserId:(NSString *)str;

+ (NSString *)userId;

#pragma mark -Delegate
- (int)getConnectTag;
- (void)addOnAppServiceBlock:(onAppServiceBlock)block tag:(NSInteger)tag;
- (void)removeOnAppServiceBlockForTag:(NSInteger)tag;

#pragma mark - HttpRequest

#pragma mark ------- 登录&注册

//注册接口
- (BOOL)registerUserInfo:(NSDictionary *)params tag:(int)tag;

/**
 *  登录接口
 *
 *  @param params 入参字典
 *  @param tag
 *
 *  @return 
 */
- (BOOL)logInUserInfo:(NSDictionary *)params tag:(int)tag;


#pragma mark -------- 首页

//首页热点推荐
- (BOOL)getHomeHotTopListWith:(int)page tag:(int)tag;
//热点推荐详情
- (BOOL)getHotTopDetailsInfoWith:(NSString *)tId tag:(int)tag;
//首页专辑推荐
- (BOOL)getHomeAlbumTopListWith:(int)page tag:(int)tag;
//专辑推荐详情
- (BOOL)getAlbumTopDetailsInfoWith:(NSString *)tId tag:(int)tag;
//首页Banner
- (BOOL)getHomeBannerTopListWith:(int)page tag:(int)tag;
//Banner详情
- (BOOL)getBannerDetailsInfoWith:(NSString *)tId tag:(int)tag;

//用户信息
- (BOOL)getUserInfoWithUserId:(NSString *)uid tag:(int)tag;
//用户个人信息
- (BOOL)getUserDetailsInfoWithUserId:(NSString *)uid tag:(int)tag;

#pragma mark -------- 动态
//获取动态列表
- (BOOL)getDynamicListWith:(int)page userType:(NSString *)userTypeId tag:(int)tag;

//动态添加赞
- (BOOL)getDynamicAddZanWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

//动态取消赞
- (BOOL)getDynamicDeleteZanWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

@end
