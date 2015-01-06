//
//  InputViewController.h
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseViewController.h"
@protocol InputViewControllerDelegate <NSObject>
- (void) refreshCommentLists;
@end

@interface InputViewController : YHBaseViewController
@property (assign) id<InputViewControllerDelegate> delegate;
@end
