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

/**
 *  判断用户是否登录
 */
@property(nonatomic) BOOL isLogin;

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
//更新用户信息
- (BOOL)updateUserInfoWith:(NSDictionary *)params tag:(int)tag;

#pragma mark -------- 动态

//添加动态
- (BOOL)getDynamicAddDynamicWith:(NSString *)content userid:(NSString *)userId tag:(int)tag;

//获取指定用户动态列表
- (BOOL)getDynamicListWith:(int)page userType:(NSString *)userTypeId tag:(int)tag;

//根据用户类型获取动态
- (BOOL)getDynamicListByUserType:(NSString *)userTypeId page:(NSString *)page pageSize:(NSString *)pageSize tag:(int)tag;

//给动态添加评论
- (BOOL)getDynamicAddCommentWith:(NSString *)content userid:(NSString *)userid dynamicId:(NSString *)dynamicId tag:(int)tag;

//获取指定动态的评论列表
- (BOOL)getDynamicCommentListWith:(NSString *)page dynamicId:(NSString *)dynamicId pageSize:(NSString *)pageSize tag:(int)tag;

//动态添加赞
- (BOOL)getDynamicAddZanWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

//动态取消赞
- (BOOL)getDynamicDeleteZanWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

//动态被赞计数
- (BOOL)getDynamicZanCountWithDynamicId:(NSString *)dynamicId tag:(int)tag;

//删除动态
- (BOOL)deleteDynamicWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

//动态添加喜欢
- (BOOL)getDynamicAddLikeWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

//动态取消喜欢
- (BOOL)getDynamicDeleteLikeWithDynamicId:(NSString *)dynamicId userid:(NSString *)userid tag:(int)tag;

//动态被喜欢计数
- (BOOL)getDynamicLikeCountWithDynamicId:(NSString *)dynamicId tag:(int)tag;

#pragma mark ---------- 关注

//获取我关注的人列表
- (BOOL)getAttentionListWithFollowerId:(NSString *)followerId tag:(int)tag;

//获取关注我的人（粉丝）列表
- (BOOL)getFansListWithIsFollowerId:(NSString *)isFollowerId tag:(int)tag;

//添加关注
- (BOOL)getAddAttentionWithFollowerId:(NSString *)isFollowerId followerId:(NSString *)followerId tag:(int)tag;

//取消关注
- (BOOL)getCancelAttentionWithFollowerId:(NSString *)isFollowerId followerId:(NSString *)followerId tag:(int)tag;


@end
