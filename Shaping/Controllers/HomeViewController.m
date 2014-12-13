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

@interface HomeViewController () <SGFocusImageFrameDelegate>
{
    SGFocusImageFrame *bannerView;
    
    NSMutableArray *bannerArray;//轮播图数组
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";
    
    bannerArray = [[NSMutableArray alloc] init];
    
    [self initNavBar];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    for (int i = 0; i < 3; i ++) {
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"home_banner"] tag:0];
        
        
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
        return 3;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    else
        return 100;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"热点推荐";
    }
    else {
        return @"热门健身专辑推荐";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *CustomerTableIdentifier = @"TableViewCell";
        
        UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CustomerTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomerTableIdentifier];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"test_avatar.jpg"];
        cell.textLabel.text = @"三种组合训练法";
        
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

        return cell;
    }
    
}



@end
