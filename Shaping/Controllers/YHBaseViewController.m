//
//  YHBaseViewController.m
//
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import "YHBaseViewController.h"
#import "MBProgressHUD.h"



@interface YHBaseViewController () <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, copy) HTBarButtonItemActionBlock barbuttonItemAction;

@property (nonatomic,retain) UIControl *ctrlView;


/**
 *  自定义导航条View
 */
@property (nonatomic,strong) UIView *nBarView;

@end

@implementation YHBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ctrlView = [[UIControl alloc] init];
    }
    return self;
}

- (void)clickedBarButtonItemAction {
    if (self.barbuttonItemAction) {
        self.barbuttonItemAction();
    }
}

#pragma mark - Public Method

- (void)configureBarbuttonItemStyle:(HTBarbuttonItemStyle)style action:(HTBarButtonItemActionBlock)action {
    switch (style) {
        case kHTBarbuttonItemSettingStyle: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        case kHTBarbuttonItemMoreStyle: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        case kHTBarbuttonItemCameraStyle: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        default:
            break;
    }
    self.barbuttonItemAction = action;
}

- (void)setupBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (void)clearKeyboard
{
    [self.view endEditing:YES];
}
- (void)setControlView:(id)sender
{
    self.ctrlView.autoresizesSubviews = YES;
    UIView *view = (UIView *)sender;
    self.ctrlView.frame = view.bounds;
    self.ctrlView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.ctrlView.autoresizesSubviews = YES;
    [_ctrlView addTarget:self action:@selector(clearKeyboard)forControlEvents:UIControlEventTouchUpInside];
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView *)sender addSubview:self.ctrlView];
        [(UIView *)sender sendSubviewToBack:self.ctrlView];
    }
}



#pragma mark - ViewController presentModal

- (void)lxPushViewController:(NSString *)className animated:(BOOL)animated {
    Class cls = NSClassFromString(className);
    NSAssert1(cls, @"could not find class '%@'",className);
    id obj = [[cls alloc] initWithNibName:className bundle:nil];
    
    [self.navigationController pushViewController:obj animated:animated];
    
}

- (void)pushViewController:(NSString *)className {
    [self lxPushViewController:className animated:YES];
}

- (void)pushViewControllerNoAnimated:(NSString *)className {
    [self lxPushViewController:className animated:NO];
}

#pragma mark - Loading


- (void)showLoading {
    [self showLoadingWithText:nil];
}

- (void)showLoadingWithText:(NSString *)text {
    [self showLoadingWithText:text onView:self.view];
}

- (void)showLoadingWithText:(NSString *)text onView:(UIView *)view {
    
    _hud = [[MBProgressHUD alloc] initWithView:view];
    [self.view addSubview:_hud];
    _hud.labelText = text;
    _hud.yOffset = -10.f;
    
    [_hud show:YES];
}

- (void)showSuccess {
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_hud];
	
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	_hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	_hud.mode = MBProgressHUDModeCustomView;
	
	_hud.delegate = self;
	_hud.labelText = @"完成";
	
	[_hud show:YES];
	[_hud hide:YES afterDelay:2];

}
- (void)showErrorWithText:(NSString *)errorText {
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_hud];
	
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	_hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_adclose.png"]];
	_hud.yOffset = -10.f;
	// Set custom view mode
	_hud.mode = MBProgressHUDModeCustomView;
	
	_hud.delegate = self;
	_hud.labelText = errorText;
	
	[_hud show:YES];
	[_hud hide:YES afterDelay:2];
}

- (void)showWithText:(NSString *)text
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	
	// Configure for text only and offset down
	_hud.mode = MBProgressHUDModeText;
	_hud.labelText = text;
	_hud.margin = 20.f;
	_hud.yOffset = 0.f;
	_hud.removeFromSuperViewOnHide = YES;
	
	[_hud hide:YES afterDelay:2];
}

- (void)hideLoading {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[self.hud removeFromSuperview];

	self.hud = nil;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorRGB(235, 235, 235);
#if defined(__IPHONE_7_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    //修复iOS7系统下布局从（0，0）开始问题
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    //    if ([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)]) {
    //        self.modalPresentationCapturesStatusBarAppearance = NO;
    //    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setControlView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addNavigationBar
{
    self.nBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,64)];
    [self.nBarView setBackgroundColor:NAVIGATION_BAR_COLCOR];
    [self.view addSubview:self.nBarView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 220, 15)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    if (self.titleText) {
        titleLabel.text = self.titleText;
    }
    
    [self.nBarView addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
    button.frame = CGRectMake(0, 0, 100, 44);
    [button addTarget:self action:@selector(navBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.nBarView addSubview:button];
}

-(void)navBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
