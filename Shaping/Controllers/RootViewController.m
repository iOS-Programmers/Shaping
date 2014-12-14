//
//  RootViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/13.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "RootViewController.h"
#import "LeveyTabBarController.h"

#import "YHBaseNavigationController.h"
#import "YHBaseTabbarController.h"

#import "HomeViewController.h"
#import "PlanViewController.h"
#import "PublishViewController.h"
#import "DynamicViewController.h"
#import "MineViewController.h"

#import "CHTumblrMenuView.h"

@interface RootViewController () <centerBtnDelegate,UINavigationControllerDelegate>
{
    LeveyTabBarController *leveyTabBarController;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        //Home
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
    
        homeViewController.tabBarItem.image = [UIImage imageNamed:@"sy"];
        homeViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"syS"];
        YHBaseNavigationController *homeNav = [[YHBaseNavigationController alloc] initWithRootViewController:homeViewController];
        homeNav.delegate = self;
    
        //Plan
        PlanViewController *planViewController = [[PlanViewController alloc] init];
        planViewController.tabBarItem.image = [UIImage imageNamed:@"jh"];
        planViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"jhS"];
        YHBaseNavigationController *planNav = [[YHBaseNavigationController alloc] initWithRootViewController:planViewController];
        planNav.delegate = self;
    
        //Publish
        PublishViewController *publishViewController = [[PublishViewController alloc] init];
    
        publishViewController.tabBarItem.image = [UIImage imageNamed:@"tab_home"];
        publishViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
        YHBaseNavigationController *pulishNav = [[YHBaseNavigationController alloc] initWithRootViewController:publishViewController];
        pulishNav.delegate = self;
    
        //Dynamic
        DynamicViewController *dynamicViewController = [[DynamicViewController alloc] init];
    
        dynamicViewController.tabBarItem.image = [UIImage imageNamed:@"hb"];
        dynamicViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"hbS"];
        YHBaseNavigationController *dynamicNav = [[YHBaseNavigationController alloc] initWithRootViewController:dynamicViewController];
        dynamicNav.delegate = self;
    
        //Mine
        MineViewController *mineViewController = [[MineViewController alloc] init];
        mineViewController.tabBarItem.image = [UIImage imageNamed:@"my"];
        mineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"myS"];
        YHBaseNavigationController *mineNav = [[YHBaseNavigationController alloc] initWithRootViewController:mineViewController];
        mineNav.delegate = self;
    
        //tabBar
        YHBaseTabbarController *rootTabBarController = [[YHBaseTabbarController alloc] init];
        rootTabBarController.viewControllers = @[homeNav,planNav,pulishNav,dynamicNav,mineNav];
        [rootTabBarController setSelectedIndex:0];
    
        // setup UI Image
    
        [rootTabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
        [rootTabBarController.tabBar setBarTintColor:[UIColor whiteColor]];
        [rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"barbg_line1"]];
    
        if (CURRENT_SYS_VERSION >= 7.0) {
            [[UINavigationBar appearance] setBarTintColor:NAVIGATION_BAR_COLCOR];
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
            [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
        }
    
    NSArray *ctrlArr = [NSArray arrayWithObjects:homeNav, planNav, dynamicNav, mineNav,nil];
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic1 setObject:[UIImage imageNamed:@"sy"] forKey:@"Default"];
    [imgDic1 setObject:[UIImage imageNamed:@"syS"] forKey:@"Selected"];
    
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic2 setObject:[UIImage imageNamed:@"jh"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"jhS"] forKey:@"Selected"];
    
    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic3 setObject:[UIImage imageNamed:@"hb"] forKey:@"Default"];
    [imgDic3 setObject:[UIImage imageNamed:@"hbS"]forKey:@"Selected"];
    
    
    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic4 setObject:[UIImage imageNamed:@"my"] forKey:@"Default"];
    [imgDic4 setObject:[UIImage imageNamed:@"myS"] forKey:@"Selected"];
    
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic1, imgDic4, imgDic3,imgDic2, nil];
    NSArray *nameArr = [NSArray arrayWithObjects:@"首页",@"计划",@"动态",@"我的", nil];
    
    leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr nameArray:nameArr];
    leveyTabBarController.tabBar.centerBtnClickDelegate = self;
    
    [leveyTabBarController setTabBarTransparent:YES];
    [leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"barbg_line1"]];
    [self.view addSubview:leveyTabBarController.view];
    
//    [self getStatureInfo:[AppDelegate shareappdelegate].currentLoginUserID];
//    [self initTanChuView];

        
}

- (void)gotoPublish
{
    PublishViewController *publishViewController = [[PublishViewController alloc] init];
    YHBaseNavigationController *pulishNav = [[YHBaseNavigationController alloc] initWithRootViewController:publishViewController];
//    [self.navigationController pushViewController:pulishNav animated:YES];
    [self presentViewController:pulishNav animated:YES completion:^{
        
    }];
}

#pragma mark - 点击发布按钮
- (void)publishbuttonClicked
{
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    
    [menuView addMenuItemWithTitle:@"相册" andIcon:[UIImage imageNamed:@"photo"] andSelectedBlock:^{
        NSLog(@"Photo selected");
        [self gotoPublish];
        
    }];
    
    [menuView addMenuItemWithTitle:@"相机" andIcon:[UIImage imageNamed:@"xiangji"] andSelectedBlock:^{
        NSLog(@"Text selected");
        [self gotoPublish];
    }];
    
    [menuView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!viewController.hidesBottomBarWhenPushed) {
        leveyTabBarController.tabBar.hidden = NO;
        [leveyTabBarController hidesTabBar:NO animated:YES];
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.hidesBottomBarWhenPushed) {
        
        [leveyTabBarController hidesTabBar:YES animated:YES];
        leveyTabBarController.tabBar.hidden = YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
