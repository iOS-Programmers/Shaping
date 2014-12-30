//
//  SPUserInfo.m
//  Shaping
//
//  Created by KID on 14/12/30.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "SPUserInfo.h"

@implementation SPUserInfo

- (void)doSetUserInfoByJsonDic:(NSDictionary*)dic {
    
}
- (void)setUserInfoByJsonDic:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    _userInfoByJsonDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    _uid = [[dic objectForKey:@""] description];
    
    @try {
        [self doSetUserInfoByJsonDic:dic];
    }
    @catch (NSException *exception) {
        NSLog(@"####SPUserInfo setUserInfoByJsonDic exception:%@", exception);
    }
    
//    self.jsonString = [_userInfoByJsonDic JSONString];
}

@end
