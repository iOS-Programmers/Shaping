//
//  LoginViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegisterViewController.h"
#import "SSKeychain.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


- (IBAction)loginBtnClick:(UIButton *)sender;

- (IBAction)registerBtnClick:(UIButton *)sender;
- (IBAction)forgetPwBtnClick:(UIButton *)sender;

- (IBAction)weixinBtnClick:(id)sender;
- (IBAction)weiboBtnClick:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    //如果钥匙串中有保存账号密码，则给予显示
    NSString *userName = [SSKeychain passwordForService:@"com.sp.shaping"account:@"username"];
    NSString *passWord = [SSKeychain passwordForService:@"com.sp.shaping"account:@"password"];
    
    if (!FBIsEmpty(userName)) {
        self.emailTF.text = userName;
    }
    if (!FBIsEmpty(passWord)) {
        self.passwordTF.text = passWord;
    }

}

- (void)initUI
{
    self.emailTF.layer.borderColor = [UIColor whiteColor].CGColor;
    self.emailTF.layer.borderWidth = 1;
    
    self.passwordTF.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passwordTF.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAciton

/**
 *  点击登录按钮
 *
 */
- (IBAction)loginBtnClick:(UIButton *)sender {

    
    __weak LoginViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    
    if (FBIsEmpty(self.emailTF.text)) {
        [self showWithText:@"请输入邮箱"];
        
        return;
    }
    
    if (FBIsEmpty(self.passwordTF.text)) {
        [self showWithText:@"请输入密码"];
        
        return;
    }
    
    
    NSDictionary *params = @{@"user.email":self.emailTF.text,
                             @"user.password":self.passwordTF.text};
    
    [[ShapingEngine shareInstance] logInUserInfo: params tag:tag];
    
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            //            [LSCommonUtils showWarningTip:errorMsg At:weakSelf.view];
            return;
        }

        
        /**
         *  请求成功后，把服务端返回的信息存起来
         */
        NSString *statusStr = [NSString stringWithFormat:@"%@",[jsonRet objectForKey:@"status"]];
        
        if ([statusStr isEqualToString:@"1"]) {
            
            //请求成功
            //登录成功后，保存用户名跟密码到钥匙串里
            [SSKeychain setPassword:self.emailTF.text forService:@"com.sp.shaping" account:@"username"];
            [SSKeychain setPassword:self.passwordTF.text forService:@"com.sp.shaping" account:@"password"];
            
            [[SPAppDelegate shareappdelegate] initMainView];
        }
        
        else {
        
            [weakSelf showWithText:@"登录失败！"];

            return;
        }
    
        //        JFUserInfo *userInfo = [[JFUserInfo alloc] init];
        //        [userInfo setUserInfoByJsonDic:dataDic];
        //        [ShapingEngine shareInstance].userPassword = self.passwordTF.text;
        //        [[ShapingEngine shareInstance] setUserInfo:userInfo];
//        [[ShapingEngine shareInstance] saveAccount];
        
//        [weakSelf loginAction];
        
        
        
    } tag:tag];

    
}

/**
 *  微信登录
 *
 */
- (IBAction)weixinBtnClick:(id)sender {
}

/**
 *  微博登录
 *
 */
- (IBAction)weiboBtnClick:(id)sender {
}

/**
 *  注册
 */
- (IBAction)registerBtnClick:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

/**
 *  忘记密码
 *
 */
- (IBAction)forgetPwBtnClick:(UIButton *)sender {
}

- (void)clearKeyboard
{
    [self.view endEditing:YES];

    if ([self.emailTF.text isEqualToString:@""]) {
        self.emailTF.text = @"Email";
    }
    if ([self.passwordTF.text isEqualToString:@""]) {
        self.passwordTF.text = @"密 码";
        self.passwordTF.secureTextEntry = NO;
    }
    [UIView animateWithDuration:0.15 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
    if (textField == self.passwordTF) {
        textField.secureTextEntry = YES;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }else if (textField == self.emailTF) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }
}
@end
