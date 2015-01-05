//
//  EditInformationViewController.m
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "EditInformationViewController.h"
#import "SPTextEditViewController.h"
#import "YHBaseNavigationController.h"

@interface EditInformationViewController ()

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (copy, nonatomic) NSString *nickeName;
@end

@implementation EditInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    
    [self.dataSource addObject:[NSArray arrayWithObjects:@"昵称",@"性别",@"长居地",@"身高",@"体重",@"三围", nil]];
    [self.dataSource addObject:[NSArray arrayWithObjects:@"签名", nil]];
    
    [self refreshUI];
    
    
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

#pragma mark - custom
-(void)refreshUI{
    
    self.tableView.tableHeaderView = self.headView;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.avatarImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"test_avatar.jpg"]];
    self.avatarImageView.image = [UIImage imageNamed:@"test_avatar.jpg"];
    
    [self.tableView reloadData];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dataSource[section];
    if (section == 0) {
        return array.count;
    }
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 54;
    }
    else
        return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    sectionView.backgroundColor = UIColorRGB(223, 223, 223);
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerTableIdentifier = @"TableViewCell";
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CustomerTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomerTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
        {
            //昵称
            SPTextEditViewController *vc = [[SPTextEditViewController alloc] init];
            YHBaseNavigationController *nav = [[YHBaseNavigationController alloc] initWithRootViewController:vc];
            vc.titleStr = @"昵称";
            __weak EditInformationViewController *weak_self = self;
            EditBackBlock block = ^(NSString *str)
            {
                weak_self.nickeName = str;
                //这里进行修改昵称的请求
            };
            [vc setBackBlock:block];
            
            vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//添加动画
            [self presentViewController:nav animated:YES completion:^{}];

        }
            break;
            
        default:
            break;
    }
}

@end
