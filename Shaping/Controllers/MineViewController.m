//
//  MineViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "MineViewController.h"
#import "FeedTimeLineCell.h"
#import "CommentListViewController.h"
#import "FriendSearchViewController.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate,FeedTimeLineCellDelegate>

@property (nonatomic, strong) IBOutlet UIView *headView;

@property (strong, nonatomic) IBOutlet UIView *personInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *planLabel;

- (IBAction)onEditBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (strong, nonatomic) IBOutlet UIView *attentView;
@property (weak, nonatomic) IBOutlet UILabel *levelInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人中心";
    self.tableView.tableHeaderView = self.personInfoView;
    self.tableView.rowHeight = 205;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView reloadData];
    if (!_isFriend) {
        [self initNavBar];
    }
    [self initUI];
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
- (void)initNavBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"friend"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)rightItemClick:(id)sender{
    
    FriendSearchViewController *vc = [[FriendSearchViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//更新界面
- (void)initUI
{
    [self.avatarImage setImage:[UIImage imageNamed:@"test_avatar.jpg"]];

    self.avatarImage.layer.cornerRadius = 30;
    self.avatarImage.layer.masksToBounds = YES;
    [self.personInfoView addSubview:self.sexImage];
    
    self.editInfoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.editInfoBtn.layer.borderWidth = 0.5;
    if (_isFriend) {
        self.editInfoBtn.hidden = YES;
        self.attentView.hidden = NO;
    }else{
        self.editInfoBtn.hidden = NO;
        self.attentView.hidden = YES;
    }
}

- (IBAction)onEditBtnClick:(UIButton *)sender {
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"FeedTimeLineCell";
    FeedTimeLineCell *cell = (FeedTimeLineCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [cells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
//    [cell.conImageView setImageWithURL:[NSURL URLWithString:@"http://y0.ifengimg.com/e7f199c1e0dbba14/2013/0722/rdn_51ece7b8ad179.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
//    NSDictionary *rankDic = self.dataSource[indexPath.row];
//    cell.rankDic = rankDic;
//    cell.positionLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - FeedTimeLineCellDelegate
-(void)commentActionWithFeedTime:(FeedTimeLineCell *)cell{
    CommentListViewController *vc = [[CommentListViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)praiseActionWithFeedTime:(FeedTimeLineCell *)cell{
    
}
-(void)likeActionWithFeedTime:(FeedTimeLineCell *)cell{
    
}

@end
