//
//  SPAppDelegate.h
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)initMainView;

+ (SPAppDelegate *)shareappdelegate;

@end
