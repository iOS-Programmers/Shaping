//
//  MineViewController.h
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseTableViewController.h"
#import "SPUserInfo.h"

@interface MineViewController : YHBaseTableViewController

@property (nonatomic, strong) SPUserInfo *userInfo;
@property (nonatomic, strong) SPUserInfo *userDetailsInfo;
@property (nonatomic, assign) BOOL isFriend;

@end
