//
//  SettingViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "YHBaseNavigationController.h"
#import "EditInformationViewController.h"

@interface SettingViewController () <UIActionSheetDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleText = @"设置";
    [self addNavigationBar];
    
    self.tableView.frame = CGRectMake(0, 64, [LXUtils GetScreeWidth], [LXUtils getContentViewHeight]);
    
    self.dataSource = [self getSettingConfigureArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)getSettingConfigureArray
{
    NSMutableArray *settingConfigureArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    NSDictionary *myInfoDic = @{@"title": @"个人资料",@"image": @"Personal"};
    NSDictionary *clearCacheDic = @{@"title": @"清空缓存数据",@"image": @"Cleanup"};
    NSDictionary *feedbackDic = @{@"title": @"意见反馈",@"image": @"Feedback"};
    NSDictionary *commentDic = @{@"title": @"AppStore评价",@"image": @"Appraisal"};
    NSDictionary *levelDic = @{@"title": @"经验等级详情",@"image": @""};
    [settingConfigureArray addObject:@[myInfoDic,clearCacheDic,feedbackDic,commentDic,levelDic]];
    
    NSDictionary *logoutDic = @{@"title": @"退出登录",@"image": @"out"};
    [settingConfigureArray addObject:@[logoutDic]];
    
    NSDictionary *questionDic = @{@"title": @"常见问题",@"image": @""};
    NSDictionary *friendDic = @{@"title": @"水瓶健身招募创业小伙伴",@"image": @""};
    [settingConfigureArray addObject:@[questionDic,friendDic]];
    
    return settingConfigureArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self getSettingConfigureArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerTableIdentifier = @"TableViewCell";
    
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CustomerTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomerTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
//    NSDictionary *settingDictionary = self.dataSource[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:[self.dataSource[indexPath.section][indexPath.row] valueForKey:@"image"]];
//    cell.textLabel.text = [settingDictionary valueForKey:@"title"][indexPath.section];
    cell.textLabel.text = [self.dataSource[indexPath.section][indexPath.row] valueForKey:@"title"];

    
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (section) {
        case 0: {
         
            switch (row) {
                case 0:
                {
                    //个人资料
                    EditInformationViewController *vc = [[EditInformationViewController alloc] init];
//                    self.userInfo.nickName = self.userDetailsInfo.nickName;
//                    vc.userInfo = self.userInfo;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    
                case 1: {
                    //清空缓存数据
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showWithText:@"清除成功！"];
                    });
                
                }
                    break;
                    
                case 2: {
                    //意见反馈
                
                }
                    break;
                    
                case 3: {
                    //等级经验详情
                
                }
                    break;
                    
                default:
                    break;
            }
        
        }
            break;
            
        case 1: {
        
            //退出登录
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"确定要退出登录吗"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"退出登录"
                                          otherButtonTitles:nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[ShapingEngine shareInstance] logout];

        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        YHBaseNavigationController *loginNav = [[YHBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.callType = CALL_OUTSIDE;
        loginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//添加动画
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
        
    }
}

@end
