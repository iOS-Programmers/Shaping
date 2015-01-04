//
//  DynamicViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "DynamicViewController.h"
#import "FriendDynamicCell.h"
#import "DynamicContentController.h"
#import "MineViewController.h"
#import "CommentListViewController.h"
#import "SPDynamicInfo.h"

@interface DynamicViewController ()<FriendDynamicCellDelegate>

@property (nonatomic, copy) NSString *userType;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"动态";
    self.tableView.rowHeight = 380;
    
    self.userType = @"1";
    
    self.canPullRefresh = YES;
    
    [self.tableView frameSetHeight:[LXUtils getContentViewHeight] + 10];
    
    [self initNav];
    
    [self refreshDynamicList];
}

- (void)initNav
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"好友",@"教练",@"会所",nil]];
    [segment setFrame:CGRectMake(0, 5, 193, 28)];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor colorWithRed:37.0/255.0 green:36.0/255.0 blue:32.0/255.0 alpha:1.0];
    //修改字体的默认颜色与选中颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,  [UIFont systemFontOfSize:13.0],UITextAttributeFont ,[UIColor whiteColor],UITextAttributeTextShadowColor ,nil];
    [segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segment setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    [segment addTarget:self action:@selector(dynamicSegmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"leftlist"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"leftlist_selected"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(dynamicLeftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)refreshDynamicList{
    
    __weak DynamicViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getDynamicListByUserType:self.userType page:@"0" pageSize:@"20" tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        [weakSelf.header endRefreshing];
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }

        [weakSelf.dataSource removeAllObjects];
        
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            SPDynamicInfo *dynamicInfo = [[SPDynamicInfo alloc] init];

            [dynamicInfo setDynamicInfoByJsonDic:dic];
            [weakSelf.dataSource addObject:dynamicInfo];
        }
        
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}


//左边按钮
- (void)dynamicLeftItemClick
{
    [[SliderViewController sharedSliderController] leftItemClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dynamicSegmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
            
        case 0:
        {
            self.userType = @"0";
        }
            
            break;
            
        case 1:
        {
            self.userType = @"1";
        }
            
            break;
            
        case 2:
        {
            self.userType = @"2";
        }
            break;
        default:
            
            break;
            
    }
    
    [self refreshDynamicList];
    
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
    
    static NSString *cellIdentifier = @"FriendDynamicCell";
    FriendDynamicCell *cell = (FriendDynamicCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [cells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    SPDynamicInfo *info = (SPDynamicInfo *)self.dataSource[indexPath.row];
    
    cell.nickNameLabel.text = info.nickName;
    cell.creatTimeLabel.text = [LXUtils secondChangToDateString:info.createTime];
    cell.contentLabel.text = info.content;

    if (!FBIsEmpty(info.image) && ![info.image isEqualToString:@"<null>"]) {
        [cell.contentImage setImageWithURL:[NSURL URLWithString:info.image]];
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

#pragma mark 下拉刷新的Delegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //下拉刷新时的操作
    if (self.header == refreshView) {
        
        [self refreshDynamicList];
    }
}

@end
