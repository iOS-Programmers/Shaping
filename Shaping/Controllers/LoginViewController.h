//
//  LoginViewController.h
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseViewController.h"

typedef enum : NSUInteger {
    CALL_DEFAULT = 0,
    CALL_OUTSIDE = 1, //从外面调用的，需要dismiss一下
} CALL_TYPE;

@interface LoginViewController : YHBaseViewController

@property (nonatomic) CALL_TYPE callType;

@end
