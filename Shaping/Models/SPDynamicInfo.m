//
//  SPDynamicInfo.m
//  Shaping
//
//  Created by Jyh on 12/31/14.
//  Copyright (c) 2014 YH. All rights reserved.
//

#import "SPDynamicInfo.h"

@implementation SPDynamicInfo

- (void)doSetUserInfoByJsonDic:(NSDictionary*)dic {
    
}
- (void)setDynamicInfoByJsonDic:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    _dynamicInfoByJsonDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    _uid = [[dic objectForKey:@"uid"] description];
    _content = [[dic objectForKey:@"content"] description];
    _dyna_zanId = [[dic objectForKey:@"dyna_zanId"] description];
    _createTime = [[dic objectForKey:@"createTime"] description];
    _nickName = [[dic objectForKey:@"nickName"] description];
    _image = [[dic objectForKey:@"image"] description];
    _place = [[dic objectForKey:@"place"] description];
    _dyna_likeId = [[dic objectForKey:@"dyna_likeId"] description];
    _user_dynamic_id = [[dic objectForKey:@"user_dynamic_id"] description];
    _diss_content = [[dic objectForKey:@"user_dynamic_id"] description];
    _userType = [[dic objectForKey:@"user_dynamic_id"] description];
    
    
    @try {

    }
    @catch (NSException *exception) {
        NSLog(@"####SPUserInfo setUserInfoByJsonDic exception:%@", exception);
    }
    
        self.jsonString = [_dynamicInfoByJsonDic JSONString];
}

@end
