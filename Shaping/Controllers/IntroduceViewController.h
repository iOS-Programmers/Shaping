//
//  IntroduceViewController.h
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseViewController.h"
#import "SPTopicInfo.h"

@interface IntroduceViewController : YHBaseViewController

@property (nonatomic, strong) SPTopicInfo *topicInfo;

@property (nonatomic, assign) int vcType;//1为热点推荐 2为专辑推荐

@end
