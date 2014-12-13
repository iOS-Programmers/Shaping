//
//  LeftViewController.m
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "LeftViewController.h"
#import "leftTableViewCell.h"
#import "SliderViewController.h"
#import "loginViewController.h"


@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.frame;
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 83)];
    topView.backgroundColor = [UIColor clearColor];
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 28, 50, 50)];
    headImage.layer.cornerRadius = headImage.frame.size.height/2;
    headImage.layer.masksToBounds = YES;
    NSString *logo;
//    if ([[loginViewController shareloginViewController] qqLoginSuccessUser]) {
//        logo = [[[loginViewController shareloginViewController] qqLoginSuccessUser] qlogo];
//    }else if ([[loginViewController shareloginViewController] weiboLoginSuccessUser]) {
//        logo = [[[loginViewController shareloginViewController] weiboLoginSuccessUser] headimage];
//    }

    [headImage setImageWithURL:[NSURL URLWithString:logo]];
    [topView addSubview:headImage];
    
    UILabel *UserName = [[UILabel alloc] initWithFrame:CGRectMake(70, 28, 100, 50)];
    UserName.textColor = [UIColor whiteColor];
    UserName.font = [UIFont systemFontOfSize:13.0];
    NSString *nickName;
//    if ([[loginViewController shareloginViewController] qqLoginSuccessUser]) {
//        nickName = [[[loginViewController shareloginViewController] qqLoginSuccessUser] nickName];
//    }else if ([[loginViewController shareloginViewController] weiboLoginSuccessUser]) {
//        nickName = [[[loginViewController shareloginViewController] weiboLoginSuccessUser] nickName];
//    }
    UserName.text = nickName;
    
    [topView addSubview:UserName];
    
    //添加图片
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [imgV setImage:[UIImage imageNamed:@"leftMenuBg"]];
    [self.view addSubview:imgV];
    
    //添加表格
    myTableV =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    myTableV.backgroundColor=[UIColor clearColor];
    myTableV.delegate=self;
    myTableV.dataSource=self;
    myTableV.tableHeaderView = topView;
    myTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableV.scrollEnabled = NO;
    [self.view addSubview:myTableV];
    
    iconsNomalArray = [NSArray arrayWithObjects:@"shouye",@"shoucang",@"friend",@"tool",@"shezhi",@"about", nil];
    iconsSelectArray = [NSArray arrayWithObjects:@"shouye_selected",@"shoucang_selected",@"friend_selected",@"tool_selected",@"shezhi_selected",@"about_selected", nil];
    namesArray = [NSArray arrayWithObjects:@"首页",@"收藏",@"好友",@"工具",@"设置",@"关于", nil];
    
//    lastIndexPath = [NSIndexPath indexPathWithIndexes:0 length:0];
    lastSelectedRow = 0;
    cellsArray = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    CellIdentifier = @"leftTableViewCell";
    leftTableViewCell *cell = (leftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    

    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row == 0) {
        cell.icon.image = [UIImage imageNamed:[iconsSelectArray objectAtIndex:0]];
        cell.name.textColor = [UIColor whiteColor];
    }else {
        cell.icon.image = [UIImage imageNamed:[iconsNomalArray objectAtIndex:indexPath.row]];
        cell.name.textColor = [UIColor colorWithRed:121.0/255.0 green:121.0/255.0 blue:121.0/255.0 alpha:1.0];

    }
    cell.name.text = [namesArray objectAtIndex:indexPath.row];
    [cellsArray addObject:cell];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return iconsNomalArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"RootViewController"];
            break;
        case 1:
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"CollectViewController"];
            break;
        case 2:
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"FriendViewController"];
            
            break;
        case 3:
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"ToolViewController"];
            
            break;
        case 4:
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"SettingViewController"];
            
            break;
        case 5:
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"AboutViewController"];
            
            break;
 
        default:
            break;
    }
   
    if (lastSelectedRow != indexPath.row) {
        
        leftTableViewCell *lastCell = (leftTableViewCell *)[cellsArray objectAtIndex:lastSelectedRow];
        [lastCell.icon setImage:[UIImage imageNamed:[iconsNomalArray objectAtIndex:lastSelectedRow]]];
        [lastCell.name setTextColor:[UIColor colorWithRed:121.0/255.0 green:121.0/255.0 blue:121.0/255.0 alpha:1.0]];
        
        leftTableViewCell *cell = (leftTableViewCell *)[cellsArray objectAtIndex:indexPath.row];
        [cell.icon setImage:[UIImage imageNamed:[iconsSelectArray objectAtIndex:indexPath.row]]];
        [cell.name setTextColor:[UIColor whiteColor]];
        
        lastSelectedRow = indexPath.row;
    }
}

@end
