//
//  YHBaseWebViewController.h
//  Shaping
//
//  Created by Jyh on 14/12/14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseViewController.h"

@interface YHBaseWebViewController : YHBaseViewController <UIWebViewDelegate>

/**
 *  显示网页的控件
 */
@property (strong, nonatomic) UIWebView *webView;


/**
 *  需要加载的网址
 *
 *  @param urlString 网址
 */
- (void)loadDataWithURL:(NSString *)urlString;

@end
