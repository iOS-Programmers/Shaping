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
#import "EditInformationViewController.h"
#import "SPDynamicInfo.h"

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
    
    if (!_userInfo) {
        _userInfo = [[SPUserInfo alloc] init];
        _userInfo.uid = @"1";
    }
    if (!_userDetailsInfo) {
        _userDetailsInfo = [[SPUserInfo alloc] init];
        _userDetailsInfo.uid = @"1";
    }
    
    
    [self.tableView reloadData];
    if (!_isFriend) {
        [self initNavBar];
    }
    [self initUI];
    [self refreshUserInfo];
    [self getUserDetailsInfo];
    [self refreshDynamicList];
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

#pragma mark - request
-(void)refreshUserInfo{
    
    __weak MineViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getUserInfoWithUserId:_userInfo.uid tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            
            return;
        }
        NSDictionary *userDic = jsonRet;
        weakSelf.userInfo = [[SPUserInfo alloc] init];
        [weakSelf.userInfo setUserInfoByJsonDic:userDic];
        [weakSelf refreshUI];
        
    } tag:tag];
    
}

-(void)getUserDetailsInfo{
    
    __weak MineViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getUserDetailsInfoWithUserId:_userInfo.uid tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            
            return;
        }
        NSDictionary *userDic = jsonRet;
        weakSelf.userDetailsInfo = [[SPUserInfo alloc] init];
        [weakSelf.userDetailsInfo setUserDetailsInfoByJsonDic:userDic];
        [weakSelf refreshUI];
        
    } tag:tag];
    
}

-(void)refreshDynamicList{
    
    if (_userInfo.uid.length == 0) {
        return;
    }
    
    __weak MineViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getDynamicListWith:1 userType:_userInfo.uid tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            
            SPDynamicInfo *dynamicInfo = [[SPDynamicInfo alloc] init];
            [dynamicInfo setDynamicInfoByJsonDic:dic];
            [weakSelf.dataSource addObject:dynamicInfo];
        }
        
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}

-(void)refreshUI{
    
    self.positionLabel.text = self.userInfo.location;
    self.introductionLabel.text = self.userInfo.intro;
    self.attentionLabel.text = [NSString stringWithFormat:@"%d",self.userInfo.attentionCount];
    self.fansLabel.text = [NSString stringWithFormat:@"%d",self.userInfo.fansCount];
    self.planLabel.text = [NSString stringWithFormat:@"%d",self.userInfo.planCount];
    
    [self.tableView reloadData];
}

#pragma mark - custom
- (void)initNavBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"mine_addFriend"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(mineRightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"leftlist"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"leftlist_selected"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(mineLeftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
-(void)mineRightItemClick:(id)sender{
    
    FriendSearchViewController *vc = [[FriendSearchViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//左边按钮
- (void)mineLeftItemClick
{
    [[SliderViewController sharedSliderController] leftItemClick];
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
    
    EditInformationViewController *vc = [[EditInformationViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
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
    
    SPDynamicInfo *dynamicInfo = self.dataSource[indexPath.row];
    cell.dynamicInfo = dynamicInfo;
    
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
