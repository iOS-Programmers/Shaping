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
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *height;
@property (copy, nonatomic) NSString *intro;
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

static int introLabel_tag = 210;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerTableIdentifier = @"TableViewCell";
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CustomerTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomerTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *introLabel = [[UILabel alloc] init];
        introLabel.frame = CGRectMake(100, 0, cell.frame.size.width - 140, 54);
        introLabel.backgroundColor = [UIColor clearColor];
        introLabel.font = [UIFont systemFontOfSize:14];
        introLabel.textColor = [UIColor lightGrayColor];
        introLabel.textAlignment = NSTextAlignmentRight;
        introLabel.numberOfLines = 0;
        introLabel.tag = introLabel_tag;
        [cell addSubview:introLabel];
        
    }
    NSString *text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = text;
    
    UILabel *introLabel = (UILabel *)[cell viewWithTag:introLabel_tag];
    CGRect introLabelFrame = introLabel.frame;
    if (indexPath.section == 0) {
        introLabelFrame.size.height = 54;
        if (indexPath.row == 0) {
            introLabel.text = _userInfo.nickName;
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            introLabel.text = _userInfo.location;
        }else if (indexPath.row == 3){
            introLabel.text = _userInfo.height;
        }else if (indexPath.row == 4){
            
        }else if (indexPath.row == 5){
            
        }
    }else if (indexPath.section == 1){
        introLabelFrame.size.height = 100;
        if (indexPath.row == 0) {
            introLabel.text = _userInfo.intro;
        }
    }
    introLabel.frame = introLabelFrame;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 ) {
            NSString *text = @"昵称";
            if (indexPath.row == 2) {
                text = @"长居地";
            }
            if (indexPath.row == 3) {
                text = @"身高";
            }
            //
            SPTextEditViewController *vc = [[SPTextEditViewController alloc] init];
            YHBaseNavigationController *nav = [[YHBaseNavigationController alloc] initWithRootViewController:vc];
            vc.titleStr = text;
            __weak EditInformationViewController *weak_self = self;
            EditBackBlock block = ^(NSString *str)
            {
                if (indexPath.row == 0) {
                    weak_self.nickeName = str;
                }
                if (indexPath.row == 2) {
                    weak_self.location = str;
                }
                if (indexPath.row == 3) {
                    weak_self.height = str;
                }
                [weak_self updateUserInfo:(int)indexPath.row];
            };
            [vc setBackBlock:block];
            
            vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//添加动画
            [self presentViewController:nav animated:YES completion:^{}];
        }
        
    }else if (indexPath.section == 1){
        //签名
        SPTextEditViewController *vc = [[SPTextEditViewController alloc] init];
        YHBaseNavigationController *nav = [[YHBaseNavigationController alloc] initWithRootViewController:vc];
        vc.titleStr = @"签名";
        __weak EditInformationViewController *weak_self = self;
        EditBackBlock block = ^(NSString *str)
        {
            weak_self.intro = str;
            [weak_self updateUserInfo:6];
        };
        [vc setBackBlock:block];
        
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//添加动画
        [self presentViewController:nav animated:YES completion:^{}];
    }
    
    return;
    
//    switch (indexPath.row) {
//        case 0:
//        {
//            
//
//        }
//            break;
//            
//        default:
//            break;
//    }
}

-(void)updateUserInfo:(int)type{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    if (type == 0 && self.nickeName.length > 0) {
        [params setValue:self.nickeName forKey:@"user.nickName"];
    }
    if (type == 2 && self.location.length > 0) {
        [params setValue:self.location forKey:@"user.location"];
    }
    if (type == 3 && self.height.length > 0) {
        [params setValue:self.height forKey:@"user.height"];
    }
    if (type == 6 && self.intro.length > 0) {
        [params setValue:self.intro forKey:@"user.intro"];
    }
    
    if (params.count == 0) {
        return;
    }
    
    __weak EditInformationViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] updateUserInfoWith:params tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        
        if (type == 0) {
            weakSelf.userInfo.nickName = weakSelf.nickeName;
        }
        if (type == 2) {
            weakSelf.userInfo.location = weakSelf.location;
        }
        if (type == 3) {
            weakSelf.userInfo.height = weakSelf.height;
        }
        if (type == 6) {
            weakSelf.userInfo.intro = weakSelf.intro;
        }
        
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}

@end
