//
//  LeveyTabBar.h
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@protocol LeveyTabBarDelegate;

@protocol centerBtnDelegate <NSObject>

- (void)publishbuttonClicked;

@end

@interface LeveyTabBar : UIView
{
	UIImageView *_backgroundView;
	id<LeveyTabBarDelegate> _delegate;
	NSMutableArray *_buttons;
    NSMutableArray *_names;
    
    NSMutableArray *lablArray;
    NSMutableArray *imgsArray;
    NSMutableArray *selectedImageArray;
    NSMutableArray *defaultImageArray;
    
}
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, assign) id<LeveyTabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, assign) id<centerBtnDelegate>centerBtnClickDelegate;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray names:(NSArray *)nameArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (void)setBackgroundImage:(UIImage *)img;

@end
@protocol LeveyTabBarDelegate<NSObject>
@optional
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
