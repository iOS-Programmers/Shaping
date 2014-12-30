//
//  SPTopicInfo.m
//  Shaping
//
//  Created by liguangjun on 14-12-30.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "SPTopicInfo.h"
#import "JSONKit.h"

@implementation SPTopicInfo

- (void)doSetHotTopicInfoByDic:(NSDictionary *)dic{
    
    id objectForKey = [dic objectForKey:@"title"];
    if (objectForKey) {
        _title = [objectForKey description];
    }
    objectForKey = [dic objectForKey:@"content"];
    if (objectForKey) {
        _content = [objectForKey description];
    }
    objectForKey = [dic objectForKey:@"contet"];
    if (objectForKey) {
        _content = [objectForKey description];
    }
    objectForKey = [dic objectForKey:@"list_img"];
    if (objectForKey) {
        _imgUrl = [NSURL URLWithString:[objectForKey description]];
    }
    _isIndex = [[dic objectForKey:@"isIndex"] intValue];
    _createTime = [[dic objectForKey:@"createTime"] intValue];
}

- (void)setHotTopicInfoByDic:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    _tId = [[dic objectForKey:@"id"] description];
    
    @try {
        [self doSetHotTopicInfoByDic:dic];
    }
    @catch (NSException *exception) {
        NSLog(@"####SPTopicInfo setHotTopicInfoByDic exception:%@", exception);
    }
    
    _jsonString = [dic JSONString];
}

@end
