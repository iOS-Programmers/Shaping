//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#import <QuartzCore/QuartzCore.h>
#import "rootViewController.h"

#define kTabBarHeight 46.0f
#define kTabBarWigth_iPad 78.0f
#define kTabBarHeight_iPad 47.0f


static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface LeveyTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end



@implementation LeveyTabBarController
@synthesize delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize animateDriect;
@synthesize tabBar=_tabBar;
@synthesize tabBarTransparent =_tabBarTransparent;
#pragma mark -
#pragma mark lifecycle



- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr nameArray:(NSArray*)nameArr
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [NSMutableArray arrayWithArray:vcs];
		if (IOS7_OR_LATER) {
            _containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        }
        else{
            _containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        }

        if ( IOS7_OR_LATER )
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
        
//		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//侧边栏
        if (isPad) {
            
            _transitionView = [[UIView alloc] initWithFrame:CGRectMake(kTabBarWigth_iPad, 0, _containerView.frame.size.width - kTabBarWigth_iPad,_containerView.frame.size.height)];
            
            _tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, 0, kTabBarWigth_iPad, _containerView.frame.size.height) buttonImages:arr names:nameArr];
            
        }else{
            
//底部栏

            _transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height - kTabBarHeight)];
            
            _tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, _containerView.frame.size.width, kTabBarHeight) buttonImages:arr names:nameArr];
            

        }
   //  }
        _transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
		
        _tabBar.delegate = self;
		
        leveyTabBarController = self;
        animateDriect = 0;
	}
	return self;
}

- (void)loadView 
{
	[super loadView];
	
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
    
    
	self.view = _containerView;
    
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}


////适配方向
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    if ([[UIDevice currentDevice] systemVersion].floatValue>= 6.0) {
//        UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//        if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//            if (isPad == iPad) {
//                
//            }
//        }
//    }
//}



#pragma mark - instant methods

- (LeveyTabBar *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}

- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
}




- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else 
	{
        if (isPad) {
            if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight_iPad)
            {
                return;
            }
            
        }else{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
        }
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2f];
		if (yesOrNO == YES)
		{
            if (isPad) {
                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight_iPad, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            }else{
                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            }
			
		}
		else 
		{
            if (isPad) {
                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight_iPad, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            }else{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            }
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}



- (NSUInteger)selectedIndex
{
    return _selectedIndex;
    
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
   
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
         {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
        return;
    }
  
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
	
	selectedVC.view.frame = _transitionView.frame;
    
    //====================判断页面是否已存在===================
    
    //(已存在则 bringToFront ,不存在则 addSubView)
    
	if ([selectedVC.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
    //======================================================
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [_delegate tabBarController:self didSelectViewController:selectedVC];
    }

}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	if (self.selectedIndex == index)
    {
        
        
        UINavigationController *nav = [self.viewControllers objectAtIndex:index];
        
        
        [nav popToRootViewControllerAnimated:YES];
        
    }else
    {
        [self displayViewAtIndex:index];
    }
}

@end
