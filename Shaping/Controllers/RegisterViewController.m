//
//  RegisterViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//


#import "RegisterViewController.h"
#import "CustomTextField.h"

#define textFieldWigth 233
#define emailDefault @"输入您的常用邮箱"
#define nickDefault  @"昵称长度为2-20个汉字"
#define passwordDefault @"密码长度为6-16位"


@interface RegisterViewController () <UITextFieldDelegate>
{
    UITextField *emailText;
    UITextField *nickText;
    UITextField *passwordText;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"loginbg"];
    [self.view addSubview:bgImage];
    
    UIImageView *shaping = [[UIImageView alloc] initWithFrame:CGRectMake(52.5, 100, 215, 53)];
    shaping.image = [UIImage imageNamed:@"shaping"];
    [self.view addSubview:shaping];
    
    UILabel *textLable = [[UILabel alloc] initWithFrame:CGRectMake(shaping.frame.origin.x, shaping.frame.origin.y+shaping.frame.size.height, shaping.frame.size.width, 44)];
    textLable.text = @"你  的  健  身  世  界 !";
    textLable.textColor = UIColorRGB(205, 203, 204);
    textLable.textAlignment = NSTextAlignmentCenter;
    textLable.font = [UIFont systemFontOfSize:22.0f];
    [self.view addSubview:textLable];
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(43.5, 233, textFieldWigth, 232)];
    
    emailText = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 0, textFieldWigth, 40)];
    nickText = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 64, textFieldWigth, 40)];
    passwordText = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 128, textFieldWigth, 40)];
    
    [emailText setBackground:[UIImage imageNamed:@"frame"]];
    [passwordText setBackground:[UIImage imageNamed:@"frame"]];
    [nickText setBackground:[UIImage imageNamed:@"frame"]];
    emailText.textColor = [UIColor darkGrayColor];
    passwordText.textColor = [UIColor darkGrayColor];
    nickText.textColor = [UIColor darkGrayColor];
    emailText.font = [UIFont systemFontOfSize:13.0];
    passwordText.font = [UIFont systemFontOfSize:13.0];
    nickText.font = [UIFont systemFontOfSize:13.0];
    emailText.text = emailDefault;
    passwordText.text = passwordDefault;
    nickText.text = nickDefault;
    
    emailText.delegate = self;
    passwordText.delegate = self;
    nickText.delegate = self;
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 21)];
    lb1.backgroundColor = [UIColor clearColor];
    lb1.textColor = [UIColor whiteColor];
    lb1.font = [UIFont systemFontOfSize:14.0];
    lb1.text = @"Email";
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 21)];
    lb2.backgroundColor = [UIColor clearColor];
    lb2.font = [UIFont systemFontOfSize:14.0];
    lb2.textColor = [UIColor whiteColor];
    lb2.text = @"昵称";
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 21)];
    lb3.backgroundColor = [UIColor clearColor];
    lb3.font = [UIFont systemFontOfSize:14.0];
    lb3.textColor = [UIColor whiteColor];
    lb3.text = @"密码";
    
    emailText.leftViewMode = UITextFieldViewModeAlways;
    //emailText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailText.leftView = lb1;
    
    nickText.leftViewMode = UITextFieldViewModeAlways;
    //nickText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nickText.leftView = lb2;
    
    passwordText.leftViewMode = UITextFieldViewModeAlways;
    //passwordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordText.leftView = lb3;
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setFrame:CGRectMake(0, 192, textFieldWigth, 40)];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"loginbutton"] forState:UIControlStateNormal
     ];
    [registerButton setTitle:@"注      册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [textView addSubview:registerButton];
    [textView addSubview:emailText];
    [textView addSubview:nickText];
    [textView addSubview:passwordText];
    
    [self.view addSubview:textView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(100, 505, 120, 68)];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(39, 0, 42, 24)];
    arrowImage.image = [UIImage imageNamed:@"arrow2"];
    
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, arrowImage.frame.size.height, backButton.frame.size.width, 22)];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor whiteColor];
    backLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [backButton addSubview:arrowImage];
    [backButton addSubview:backLabel];
    
    [self.view addSubview:backButton];
    
    //添加手势操作，降低键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:tapGesture];
    
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = NO;
//}
- (void)hideKeyBoard:(UITapGestureRecognizer *)tap
{
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
    [nickText resignFirstResponder];
    if ([emailText.text isEqualToString:@""]) {
        emailText.text = emailDefault;
    }
    if ([nickText.text isEqualToString:@""]) {
        nickText.text = nickDefault;
    }
    if ([passwordText.text isEqualToString:@""]) {
        passwordText.text = passwordDefault;
        passwordText.secureTextEntry = NO;
    }
    [UIView animateWithDuration:0.15 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    if (textField == passwordText) {
        textField.secureTextEntry = YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == emailText) {
        BOOL isValideEmail = [self isValidateEmail:emailText.text];
        if (!isValideEmail) {
            NSLog(@"邮箱无效");
        }
    }
}
#pragma mark - 判断邮箱是否正确
- (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}
- (void)registerAction:(UIButton *)sender
{
//    if (![self isEmpty]) {
//        if ([self isValidateEmail:emailText.text]) {
////            [self registerBegin];
//            
//        }else {
//            [self showWithText:@"邮箱无效"];
//            [UIView animateWithDuration:0.15 animations:^{
//                [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//            }];
//        }
//    }
}
//- (void)registerBegin
//{
//    
//    NSString *email = emailText.text;
//    NSString *nick = nickText.text;
//    NSString *password = passwordText.text;
//    //提交已修改的数据
//    NSString *strurl = [NSString  stringWithFormat:@"%@user.email=%@&user.nickName=%@&user.password=%@",register_http,email,nick,password];
//    
//    NSLog(@"%@",strurl);
//    
//    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)strurl, NULL, NULL,  kCFStringEncodingUTF8 ));
//    
//    NSURL *url = [NSURL URLWithString:encodedString];
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    
//    __weak ASIHTTPRequest *wrequest = request;
//    
//    
//    [request setCompletionBlock:^{
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:wrequest.responseData options:NSJSONReadingMutableContainers error:nil];
//        if (dic)
//        {
//            NSLog(@"%@",dic);
//            NSString *statueStr = [dic objectForKey:@"status"];
//            
//            if ([statueStr intValue] == 1) {
//                //NSLog(@"%@",[dic objectForKey:@"id"]);
//                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//                NSString *userID = [numberFormatter stringFromNumber:[dic objectForKey:@"id"]];
//                [self registerForEaseMob:userID];
//            }else {
//                NSString *content = [dic objectForKey:@"content"];
//                //使用alwerView
//                [WCAlertView showAlertWithTitle:nil message:content customizationBlock:^(WCAlertView *alertView) {
//                    alertView.style = WCAlertViewStyleBlackHatched;
//                } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
//                    
//                } cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                emailText.text = emailDefault;
//                passwordText.text = passwordDefault;
//                nickText.text = nickDefault;
//                passwordText.secureTextEntry = NO;
//            }
//        }
//    }];
//    
//    [request setFailedBlock:^{
//        NSLog(@"failed");
//        
//    }];
//    
//    [request startAsynchronous];
//    
//    
//}
//- (void)registerForEaseMob:(NSString *)userID
//{
//    //向环信注册
//    
//    [[EaseMob sharedInstance].chatManager setNickname:nickText.text];//设置昵称
//    
//    [self showHudInView:self.view hint:@"正在注册..."];
//    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:[ToolClass getMd5_32Bit_String:userID]
//                                                         password:passwordText.text
//                                                   withCompletion:
//     ^(NSString *username, NSString *password, EMError *error) {
//         [self hideHud];
//         
//         if (!error) {
//             [AppDelegate shareappdelegate].currentLoginUserID = userID;
//             
//             [[loginViewController shareloginViewController] loginWithUsername:username password:password];
//             
//             
//         }else{
//             switch (error.errorCode) {
//                 case EMErrorServerNotReachable:
//                     TTAlertNoTitle(@"连接服务器失败!");
//                     break;
//                 case EMErrorServerDuplicatedAccount:
//                     TTAlertNoTitle(@"您注册的用户已存在!");
//                     break;
//                 case EMErrorServerTimeout:
//                     TTAlertNoTitle(@"连接服务器超时!");
//                     break;
//                 default:
//                     TTAlertNoTitle(@"注册失败");
//                     break;
//             }
//         }
//     } onQueue:nil];
//    
//    
//}
//
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = emailText.text;
    NSString *nick = nickText.text;
    NSString *password = passwordText.text;
    if ([username isEqualToString:emailDefault] || [password isEqualToString:passwordDefault]|| [nick isEqualToString:nickDefault]) {
        ret = YES;
        [self showWithText:@"请输入完整信息"];
    }
    
    return ret;
}


- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
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

@end