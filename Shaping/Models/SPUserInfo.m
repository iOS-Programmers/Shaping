//
//  SPUserInfo.m
//  Shaping
//
//  Created by KID on 14/12/30.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "SPUserInfo.h"
#import "JSONKit.h"

@implementation SPUserInfo

- (void)doSetUserInfoByJsonDic:(NSDictionary*)dic {
    
    id objectForKey = [dic objectForKey:@"nickName"];
    if (objectForKey) {
        _nickName = [objectForKey description];
    }
    objectForKey = [dic objectForKey:@"height"];
    if (objectForKey) {
        _height = [objectForKey description];
    }
    objectForKey = [dic objectForKey:@"intro"];
    if (objectForKey) {
        _intro = [objectForKey description];
    }
    objectForKey = [dic objectForKey:@"location"];
    if (objectForKey) {
        _location = [objectForKey description];
    }
    
    objectForKey = [dic objectForKey:@"age"];
    if (objectForKey && ![objectForKey isKindOfClass:[NSNull class]]) {
       _age = [[dic objectForKey:@"age"] intValue];
    }
    
    objectForKey = [dic objectForKey:@"attentionCount"];
    if (objectForKey && ![objectForKey isKindOfClass:[NSNull class]]) {
        _attentionCount = [[dic objectForKey:@"attentionCount"] intValue];
    }
    
    objectForKey = [dic objectForKey:@"fansCount"];
    if (objectForKey && ![objectForKey isKindOfClass:[NSNull class]]) {
        _fansCount = [[dic objectForKey:@"fansCount"] intValue];
    }
    
    objectForKey = [dic objectForKey:@"planCount"];
    if (objectForKey && ![objectForKey isKindOfClass:[NSNull class]]) {
         _planCount = [[dic objectForKey:@"planCount"] intValue];
    }
    
    objectForKey = [dic objectForKey:@"expCount"];
    if (objectForKey && ![objectForKey isKindOfClass:[NSNull class]]) {
        _expCount = [[dic objectForKey:@"expCount"] intValue];
    }
}
- (void)setUserInfoByJsonDic:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    _userInfoByJsonDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    _uid = [[dic objectForKey:@"user_info_id"] description];
    
    @try {
        [self doSetUserInfoByJsonDic:dic];
    }
    @catch (NSException *exception) {
        NSLog(@"####SPUserInfo setUserInfoByJsonDic exception:%@", exception);
    }
    
    self.jsonString = [_userInfoByJsonDic JSONString];
}


- (void)setUserDetailsInfoByJsonDic:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    _userDetailsInfoByJsonDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    _uid = [[dic objectForKey:@"uid"] description];
    _nickName = [[dic objectForKey:@"nickName"] description];
    id objectForKey = [dic stringObjectForKey:@"avatar"];
    if (objectForKey) {
        _avatar = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ShapingEngine shareInstance].baseUrl,objectForKey]];
    }
    
    _email = [[dic objectForKey:@"email"] description];
    _password = [[dic objectForKey:@"password"] description];
    _weixin = [[dic objectForKey:@"weixin"] description];
    _qq = [[dic objectForKey:@"qq"] description];
    _sinaWeibo = [[dic objectForKey:@"sinaWeibo"] description];
    _phone = [[dic objectForKey:@"phone"] description];
    _lastIp = [[dic objectForKey:@"lastIp"] description];
    
    _regDate = [dic intValueForKey:@"regDate"];
    _lastDate = [dic intValueForKey:@"lastDate"];
    _userType = [dic intValueForKey:@"userType"];
    
    @try {
        
    }
    @catch (NSException *exception) {
        NSLog(@"####SPUserInfo setUserDetailsInfoByJsonDic exception:%@", exception);
    }
    
    self.jsonString = [_userDetailsInfoByJsonDic JSONString];
}

@end
