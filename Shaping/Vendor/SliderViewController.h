//
//  SliderViewController.h
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController

@property (nonatomic, copy) NSString *mainVCClassName;

@property(nonatomic,strong)UIViewController *LeftVC;
@property(nonatomic,strong)UIViewController *RightVC;
@property(nonatomic,strong)UIViewController *MainVC;

@property(nonatomic,assign)float LeftSContentOffset;//偏移量
@property(nonatomic,assign)float RightSContentOffset;

@property(nonatomic,assign)float LeftSContentScale;//缩放比例
@property(nonatomic,assign)float RightSContentScale;

@property(nonatomic,assign)float LeftSJudgeOffset;
@property(nonatomic,assign)float RightSJudgeOffset;

@property(nonatomic,assign)float LeftSOpenDuration;//拉开时间
@property(nonatomic,assign)float RightSOpenDuration;

@property(nonatomic,assign)float LeftSCloseDuration;//关闭时间
@property(nonatomic,assign)float RightSCloseDuration;

@property (nonatomic, assign) BOOL canMoveWithGesture;//是否可以手动拉开和关闭

@property BOOL showLeftSideView;
@property BOOL showRightSideView;

+ (SliderViewController*)sharedSliderController;

- (void)showContentControllerWithModel:(NSString*)className;
- (void)leftItemClick;
- (void)rightItemClick;


- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes;

@end
