//
//  NSDictionary+objectForKey.m
//  WeiJiFen
//
//  Created by 李 广军 on 14-10-16.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "NSDictionary+objectForKey.h"
#import "JSONKit.h"

@implementation NSDictionary (objectForKey)

- (NSString*)stringObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if (object == [NSNull null]) {
        return  nil;
    }
    return [object description];
}
- (int)intValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    }
    return 0;
    
}
- (float)floatValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    }
    return 0;
}

- (double)doubleValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object doubleValue];
    }
    return 0;
}

-(long) longValueForKey:(id) aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(longValue)]) {
        return [object longValue];
    }
    return 0;
}

-(long long) longLongValueForKey:(id) aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(longLongValue)]) {
        return [object longLongValue];
    }
    return 0;
}

-(unsigned long long) unsignedLongLongValueForKey:(id) aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(unsignedLongLongValue)]) {
        return [object unsignedLongLongValue];
    }
    return 0;
}

-(NSUInteger)unsignedIntegerValueForKey:(id) aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(unsignedIntegerValue)]) {
        return [object unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)boolValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    }
    return 0;
}

- (NSArray*)arrayObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if (![object isKindOfClass:[NSArray class]]) {
        return  nil;
    }
    return object;
}

- (NSDictionary*)dictionaryObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSString class]]) {
        NSString* str = (NSString*)object;
        object = [str objectFromJSONString];
    }
    if (![object isKindOfClass:[NSDictionary class]]) {
        return  nil;
    }
    return object;
}

@end
