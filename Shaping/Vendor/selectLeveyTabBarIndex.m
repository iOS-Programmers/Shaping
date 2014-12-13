//
//  selectLeveyTabBarIndex.m
//  RePai2
//
//  Created by 1 on 14-2-25.
//  Copyright (c) 2014年 com.repai. All rights reserved.
//

#import "selectLeveyTabBarIndex.h"

@implementation selectLeveyTabBarIndex

+ (selectLeveyTabBarIndex *)shareObject
{
    static selectLeveyTabBarIndex *selectIndex = nil;
    if (selectIndex == nil) {
        selectIndex = [[selectLeveyTabBarIndex alloc] init];
    }
    return selectIndex;
}
@end
