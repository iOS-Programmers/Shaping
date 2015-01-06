//
//  CommentListViewController.m
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentViewCell.h"
#import "InputViewController.h"
#import "YHBaseNavigationController.h"
#define kRemoveView1Tag 11111
#define kRemoveView2Tag 22222
#define kRemoveView3Tag 33333
@interface CommentListViewController ()<InputViewControllerDelegate>

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"评论";
    self.tableView.rowHeight = 60;
    [self initNavBar];
    [self refreshCommentList];
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

-(void)refreshCommentList{
    
//    if (_dynamicInfo.user_dynamic_id.length == 0) {
//        return;
//    }
    
    __weak CommentListViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getDynamicCommentListWith:@"1" dynamicId:@"1" pageSize:@"10" tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
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
        self.totalRow = [jsonRet intValueForKey:@"totalRow"];
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}

#pragma mark - custom
- (void)initNavBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 55, 30);
    rightBtn.backgroundColor = UIColorToRGB(0xf06c55);
    [rightBtn setTitle:@"评论" forState:0];
    [rightBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)rightItemClick:(id)sender{
    InputViewController *vc = [[InputViewController alloc] init];
    vc.delegate = self;
    YHBaseNavigationController *homeNav = [[YHBaseNavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:homeNav animated:YES completion:^{
        
    }];
    
}

-(void)refreshCommentLists
{
    __weak CommentListViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getDynamicCommentListWith:@"1" dynamicId:@"1" pageSize:@"10" tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
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
        self.totalRow = [jsonRet intValueForKey:@"totalRow"];
        [weakSelf.tableView reloadData];
        
    } tag:tag];
}
#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource count]+1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == indexPath.row) {
        return 44;
    }
    NSDictionary *rankDic = self.dataSource[indexPath.row];
    CGSize size = [self sizeForString:[rankDic objectForKey:@"content"] withFontSize:14 withWidth:242];
    if (size.height+19<60) {
        return 60;
    }else{
        return size.height+19;
    }
    return 60;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count == indexPath.row) {
        //最后一行  加载更多cell
        
        static NSString *laodMoreCellIdentifierMore = @"laodMoreCellIdentifierMore";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:laodMoreCellIdentifierMore];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:laodMoreCellIdentifierMore];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }else
        {
            for(UIView *tempView in cell.contentView.subviews)
            {
                if (tempView.tag==kRemoveView1Tag||tempView.tag==kRemoveView2Tag||tempView.tag == kRemoveView3Tag)
                {
                    [tempView removeFromSuperview];
                }
            }
        }
        
                
        UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(116, 11, 22, 22)];
        imagView.tag = kRemoveView3Tag;
        if (self.totalRow>self.dataSource.count) {
            imagView.hidden = NO;
            imagView.image = [UIImage imageNamed:@"icon_加载更多.png"];
        }else{
            imagView.hidden = YES;
            imagView.image = [UIImage imageNamed:@""];
        }
        [cell.contentView addSubview:imagView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 12, 100, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
        label.backgroundColor = [UIColor clearColor];
        if (self.totalRow>self.dataSource.count) {
            label.text = @"加载更多";
        }else{
            label.text = @"没有更多信息";
            label.frame = CGRectMake(116, 12, 100, 20);
        }
        [cell.contentView addSubview:label];
        label.tag = kRemoveView2Tag;
        return cell;
    }
    static NSString *cellIdentifier = @"CommentViewCell";
    CommentViewCell *cell = (CommentViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray* cells = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [cells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        [cell.avatarImageView setImageWithURL:[NSURL URLWithString:@"http://y0.ifengimg.com/e7f199c1e0dbba14/2013/0722/rdn_51ece7b8ad179.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
        NSDictionary *rankDic = self.dataSource[indexPath.row];
        cell.commentLabel.text = [NSString stringWithFormat:@"%@",[rankDic objectForKey:@"content"]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == indexPath.row) {
        if (self.totalRow>self.dataSource.count) {
            [self addMore];
        }
        return;
    }
}

-(void)addMore
{
    int pageIndex = self.dataSource.count/10;
    __weak CommentListViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getDynamicCommentListWith:[NSString stringWithFormat:@"%d",pageIndex] dynamicId:@"1" pageSize:@"10" tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        
        NSArray *listArray = [jsonRet arrayObjectForKey:@"list"];
        for (NSDictionary *dic in listArray) {
            
            NSMutableDictionary *dics = [[NSMutableDictionary alloc] init];
            
            [dics addEntriesFromDictionary:dic];
            
            
        }
        [weakSelf.dataSource addObjectsFromArray:listArray];
        self.totalRow = [jsonRet intValueForKey:@"totalRow"];
        [weakSelf.tableView reloadData];
        
    } tag:tag];
    
}

- (CGSize)sizeForString:(NSString *)string withFontSize:(int)sizenumber withWidth:(int)width
{
    UIFont *font = [UIFont systemFontOfSize:sizenumber];
    //设置一个行高上限
    CGSize size = CGSizeMake(width,2000);
    CGSize labelsize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize;
}

@end
