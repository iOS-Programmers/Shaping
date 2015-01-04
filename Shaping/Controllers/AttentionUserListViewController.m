//
//  AttentionUserListViewController.m
//  Shaping
//
//  Created by Jyh on 1/5/15.
//  Copyright (c) 2015 YH. All rights reserved.
//

#import "AttentionUserListViewController.h"
#import "FriendShowViewCell.h"

@interface AttentionUserListViewController ()

@end

@implementation AttentionUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"关注";
    self.tableView.rowHeight = 48;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    
    static NSString *cellIdentifier = @"FriendShowViewCell";
    FriendShowViewCell *cell = (FriendShowViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [cells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.avatarImageView setImageWithURL:[NSURL URLWithString:@"http://y0.ifengimg.com/e7f199c1e0dbba14/2013/0722/rdn_51ece7b8ad179.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
    return cell;
}

@end
