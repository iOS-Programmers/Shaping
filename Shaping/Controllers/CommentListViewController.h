//
//  CommentListViewController.h
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseTableViewController.h"
#import "SPDynamicInfo.h"

@interface CommentListViewController : YHBaseTableViewController

@property (nonatomic, strong) SPDynamicInfo *dynamicInfo;
@property (nonatomic, assign) int totalRow;

@end
