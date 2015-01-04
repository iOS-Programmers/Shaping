//
//  HomeViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "HomeViewController.h"
#import "SGFocusImageFrame.h"
#import "HomeCommandCell.h"
#import "FriendDynamicViewController.h"
#import "IntroduceViewController.h"
#import "ShapingEngine.h"
#import "SPTopicInfo.h"
#import "YHBaseWebViewController.h"

@interface HomeViewController () <SGFocusImageFrameDelegate>
{
    SGFocusImageFrame *bannerView;
    
    NSMutableArray *bannerArray;//轮播图数组
}

@property (nonatomic, strong) NSMutableArray *bannerList;
@property (nonatomic, strong) NSMutableArray *hotTopList;
@property (nonatomic, strong) NSMutableArray *albumTopList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";
    
    bannerArray = [[NSMutableArray alloc] init];
    
    [self initNavBar];
    [self refreshBannerList];
    [self refreshHotList];
    [self refreshAlbumList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshBannerList{
    
    __weak HomeViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getHomeBannerTopListWith:1 tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        
        weakSelf.bannerList = [[NSMutableArray alloc] init];
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            SPTopicInfo *topicInfo = [[SPTopicInfo alloc] init];
            [topicInfo setHotTopicInfoByDic:dic];
            [weakSelf.bannerList addObject:topicInfo];
        }
        [weakSelf initUI];
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}

-(void)refreshHotList{
    
    __weak HomeViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getHomeHotTopListWith:1 tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        weakSelf.hotTopList = [[NSMutableArray alloc] init];
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            SPTopicInfo *topicInfo = [[SPTopicInfo alloc] init];
            [topicInfo setHotTopicInfoByDic:dic];
            [weakSelf.hotTopList addObject:topicInfo];
        }
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}

-(void)refreshAlbumList{
    
    __weak HomeViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getHomeAlbumTopListWith:1 tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            
            return;
        }
        
        weakSelf.albumTopList = [[NSMutableArray alloc] init];
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            SPTopicInfo *topicInfo = [[SPTopicInfo alloc] init];
            [topicInfo setAlbumTopicInfoByDic:dic];
            [weakSelf.albumTopList addObject:topicInfo];
        }
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}

/**
 *  初始化导航条
 */
- (void)initNavBar
{
    //CGRect rect = self.view.frame;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"leftlist"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"leftlist_selected"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(homeLeftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)homeLeftItemClick
{
    [[SliderViewController sharedSliderController] leftItemClick];
}


//设置界面
- (void)initUI
{
    [self initSGFocusImageItem];
}

-(void)initSGFocusImageItem
{
    NSMutableArray *itemArr=[[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.bannerList.count; i ++) {
        SPTopicInfo *topicInfo = [_bannerList objectAtIndex:i];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://img3.imgtn.bdimg.com/it/u=4170755183,273454520&fm=21&gp=0.jpg"]];
        UIImage *image = [UIImage imageWithData:imageData];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:topicInfo.title image:image tag:i];
        
        
        [itemArr addObject:item];
    }
    
    

    
    CGRect theFrame = CGRectMake(0, 0, 320, 140);
    bannerView = [[SGFocusImageFrame alloc] initWithFrame:theFrame delegate:self focusImageItemsArrray:itemArr];
    bannerView.autoScrolling = YES;
    
    self.tableView.tableHeaderView = bannerView;
    
}
#pragma mark - SGFocusImageFrameDelegate
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    
    if (item.tag == 0) {
//        FriendDynamicViewController *vc = [[FriendDynamicViewController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
        YHBaseWebViewController *webVc = [[YHBaseWebViewController alloc] init];
        [webVc loadDataWithURL:@"http://www.baidu.com"];
        webVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    if (item.tag == 1) {
        
    }
//    BannerClass *banner;
//    if (item.tag == -1) {
//        banner = [listOneArray objectAtIndex:([listOneArray count] - 1)];
//    }else if (item.tag == listOneArray.count) {
//        banner = [listOneArray objectAtIndex:0];
//    }else {
//        banner = [listOneArray objectAtIndex:item.tag];
//    }
//    adverDetail2ViewController *adverView = [[adverDetail2ViewController alloc] init];
//    adverView.hidesBottomBarWhenPushed = YES;
//    adverView.title = banner.title;
//    adverView.webUrl = banner.content;
//    [self.navigationController pushViewController:adverView animated:YES];
    
    
}
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
    //NSLog(@"%s \n scrollToIndex===>%d",__FUNCTION__,index);

}

#pragma mark - IBAction
-(void)leftItemClick{
 
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return _hotTopList.count;
    }
    return _albumTopList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    else
        return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(7, 14, 13, 13)];
    iconImage.image = [UIImage imageNamed:@"home_red"];
    
    [sectionView addSubview:iconImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, 200, 15)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    if (section == 0) {
        titleLabel.text = @"热点推荐";
    }
    else {
        titleLabel.text = @"热门健身专辑推荐";
    }

    [sectionView addSubview:titleLabel];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *CustomerTableIdentifier = @"TableViewCell";
        
        UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CustomerTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomerTableIdentifier];
        }
        
        SPTopicInfo *topicInfo = _hotTopList[indexPath.row];
        
//        cell.imageView.image = [UIImage imageNamed:@"35"];
        [cell.imageView setImageWithURL:topicInfo.imgUrl placeholderImage:[UIImage imageNamed:@"35"]];
        cell.textLabel.text = topicInfo.title;
        cell.imageView.layer.cornerRadius = 5;
        [cell.imageView.layer setMasksToBounds:YES];
        
        return cell;

    }
    else {
    
        static NSString *cellIdentifier = @"HomeCommandCell";
        HomeCommandCell *cell = (HomeCommandCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = [cells objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SPTopicInfo *topicInfo = _albumTopList[indexPath.row];
        cell.topicInfo = topicInfo;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPTopicInfo *topicInfo = nil;
    
    if (indexPath.section == 0) {
        topicInfo = _hotTopList[indexPath.row];
        IntroduceViewController *vc = [[IntroduceViewController alloc] init];
        vc.topicInfo = topicInfo;
        vc.vcType = 1;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        topicInfo = _albumTopList[indexPath.row];
        IntroduceViewController *vc = [[IntroduceViewController alloc] init];
        vc.topicInfo = topicInfo;
        vc.vcType = 2;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
