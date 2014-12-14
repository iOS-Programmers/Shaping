//
//  FriendDynamicViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "FriendDynamicViewController.h"
#import "FriendDynamicCell.h"
#import "DynamicContentController.h"
#import "MineViewController.h"
#import "CommentListViewController.h"

@interface FriendDynamicViewController () <FriendDynamicCellDelegate>

@end

@implementation FriendDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"好友动态";
    self.tableView.rowHeight = 380;
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

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"FriendDynamicCell";
    FriendDynamicCell *cell = (FriendDynamicCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [cells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DynamicContentController *contentVC = [[DynamicContentController alloc] init];
    contentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contentVC animated:YES];
}

#pragma mark - FriendDynamicCellDelegate
-(void)commentClickWithFeedTime:(FriendDynamicCell *)cell{
    CommentListViewController *vc = [[CommentListViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)avatarCilckWithFeedTime:(FriendDynamicCell *)cell{
    MineViewController *vc = [[MineViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isFriend = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
