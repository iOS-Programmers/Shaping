//
//  NSDictionary+objectForKey.h
//  WeiJiFen
//
//  Created by 李 广军 on 14-10-16.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (objectForKey)

- (NSString*)stringObjectForKey:(id)aKey;
- (int)intValueForKey:(id)aKey;
- (float)floatValueForKey:(id)aKey;
- (double)doubleValueForKey:(id)aKey;
- (long) longValueForKey:(id) aKey;
- (BOOL)boolValueForKey:(id)aKey;
-(long long) longLongValueForKey:(id) aKey;
-(unsigned long long) unsignedLongLongValueForKey:(id) aKey;
- (NSArray*)arrayObjectForKey:(id)aKey;
- (NSDictionary*)dictionaryObjectForKey:(id)aKey;

-(NSUInteger)unsignedIntegerValueForKey:(id) aKey;

@end
