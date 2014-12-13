//
//  SettingViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
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
    NSInteger row = [indexPath section];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
