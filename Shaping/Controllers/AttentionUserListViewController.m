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
    
    [self refreshAttentionList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshAttentionList{
    
    __weak AttentionUserListViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getAttentionListWithFollowerId:[ShapingEngine userId] tag:tag];
//    [[ShapingEngine shareInstance] getAttentionListWithFollowerId:@"1" tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        [weakSelf.header endRefreshing];
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        
        [weakSelf.dataSource removeAllObjects];
        
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            
            NSMutableDictionary *dics = [[NSMutableDictionary alloc] init];
            
            [dics addEntriesFromDictionary:dic];
            
            [weakSelf.dataSource addObject:dics];
        }
        
        [weakSelf.tableView reloadData];
        
    } tag:tag];
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
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"FriendShowViewCell";
    FriendShowViewCell *cell = (FriendShowViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [cells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSMutableDictionary *dics = self.dataSource[indexPath.row];
    
    cell.nickNameLabel.text = [NSString stringWithFormat:@"%@",[dics objectForKey:@"isFollower"]];
    
    [cell.avatarImageView setImageWithURL:[NSURL URLWithString:@"http://y0.ifengimg.com/e7f199c1e0dbba14/2013/0722/rdn_51ece7b8ad179.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
    return cell;
}

@end
