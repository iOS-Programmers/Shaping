//
//  SPTextEditViewController.m
//  Shaping
//
//  Created by Jyh on 1/5/15.
//  Copyright (c) 2015 YH. All rights reserved.
//

#import "SPTextEditViewController.h"

@interface SPTextEditViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,assign)BOOL isSave;

@end

@implementation SPTextEditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBar];
    self.title = self.titleStr;
    if (self.holderStr.length>0)
    {
        self.textField.placeholder = self.holderStr;
        
    }
    [self.textField becomeFirstResponder];
    switch (self.titleType) {
        case 4:
            self.textField.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
            break;
        case 1:
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//电话键盘
            break;
        case 2:
            self.textField.keyboardType = UIKeyboardTypeNamePhonePad;//邮箱键盘
            break;
        case 3:
        {   self.textField.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
            self.textField.secureTextEntry = YES;//密码类型
        }
            break;
            
        default:
            self.textField.keyboardType = UIKeyboardTypeDefault;//默认键盘
            break;
    }
}

- (void)setNavBar
{
    NSDictionary * navBarTitleTextAttributes =
    @{UITextAttributeFont             :[UIFont systemFontOfSize:17],
      UITextAttributeTextColor        :[UIColor whiteColor],
      UITextAttributeTextShadowColor  :[UIColor clearColor]};
    [self.navigationController.navigationBar setTitleTextAttributes:navBarTitleTextAttributes];
    
    UIImage *backImage = [UIImage imageNamed:@"btn_back"];
    UIImage *backImageH = [UIImage imageNamed:@"btn_back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0.0f, 0.0f, backImage.size.width+10, backImage.size.height);
    backBtn.showsTouchWhenHighlighted = YES;
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:backImageH forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    rightBtn.frame = CGRectMake(0.0f, 0.0f, 50, 30);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

- (void)dismiss
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还未保存！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [alert show];
    
    //FIXME: 提示用户你还没保存
}

- (void)setBackBlock:(EditBackBlock)block
{
    backBlock = [block copy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark -
# pragma mark - Action
- (IBAction)saveAction
{
    if ([self.title isEqualToString:@"姓名"])
    {
        if (self.textField.text.length>5)
        {
            [self showWithText:@"名字不能过长"];
        }
        else
        {
            __weak SPTextEditViewController *weak_self = self;
            if (backBlock)
            {
                backBlock(weak_self.textField.text);
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
        }
        
    }
    else   if ([self.title isEqualToString:@"年龄"])
    {
        if ([self.textField.text intValue]>100)
        {
            [self showWithText:@"年龄输入有误"];
        }
        else
        {
            __weak SPTextEditViewController *weak_self = self;
            if (backBlock)
            {
                backBlock(weak_self.textField.text);
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
        }
        
    }
    else   if ([self.title isEqualToString:@"当前里程"])
    {
        if ([self.textField.text intValue]<1||[self.textField.text intValue]>600000)
        {
            [self showWithText:@"公里数在（1～60万）之间"];
        }
        else
        {
            __weak SPTextEditViewController *weak_self = self;
            if (backBlock)
            {
                backBlock(weak_self.textField.text);
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
        }
        
    }
    else  if ([self.title isEqualToString:@"年龄"])
    {
        if ([self.textField.text intValue]>100)
        {
            [self showWithText:@"年龄输入有误"];
            
        }
        else
        {
            __weak SPTextEditViewController *weak_self = self;
            if (backBlock)
            {
                backBlock(weak_self.textField.text);
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
        }
        
    }
    else   if ([self.title isEqualToString:@"驾龄"])
    {
        if ([self.textField.text intValue]>100)
        {
            [self showWithText:@"驾龄输入有误"];
            
        }
        else
        {
            __weak SPTextEditViewController *weak_self = self;
            if (backBlock)
            {
                backBlock(weak_self.textField.text);
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
        }
        
    }
    else
    {
        __weak SPTextEditViewController *weak_self = self;
        if (backBlock)
        {
            backBlock(weak_self.textField.text);
        }
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    }
    [self.textField resignFirstResponder];
}

# pragma mark -
# pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //yes
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    }
}


@end
