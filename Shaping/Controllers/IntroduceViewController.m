//
//  IntroduceViewController.m
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "IntroduceViewController.h"
#import "ShapingEngine.h"

@interface IntroduceViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) IBOutlet UIView *avatarGridView;
@property (strong, nonatomic) IBOutlet UIButton *workButton;
@property (strong, nonatomic) IBOutlet UIButton *joinPlanButton;
@property (weak, nonatomic) IBOutlet UIButton *discussButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"介绍";
    [self refreshData];
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

-(void)refreshData{
    if (_vcType == 1) {
        [self refreshHotList];
    }else if (_vcType == 2){
        [self refreshAlbumList];
    }
}

-(void)refreshHotList{
    
    __weak IntroduceViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getHotTopDetailsInfoWith:_topicInfo.tId tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        [_topicInfo setHotTopicInfoByDic:jsonRet];
        [weakSelf refreshUI];
        
    } tag:tag];
}

-(void)refreshAlbumList{
    
    __weak IntroduceViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getAlbumTopDetailsInfoWith:_topicInfo.tId tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            
            return;
        }
        
        [_topicInfo setAlbumTopicInfoByDic:jsonRet];
        [weakSelf refreshUI];
        
    } tag:tag];
}

#pragma mark - custom
-(void)refreshUI{
    
    [self.contentImageView setImageWithURL:_topicInfo.imgUrl placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = _topicInfo.title;
    self.contentLabel.text = _topicInfo.content;
    [self.discussButton setTitle:[NSString stringWithFormat:@" %d",_topicInfo.discussCount] forState:0];
    [self.zanButton setTitle:[NSString stringWithFormat:@" %d",_topicInfo.zanCount] forState:0];
    [self.likeButton setTitle:[NSString stringWithFormat:@" %d",_topicInfo.likeCount] forState:0];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.contentView.frame.size.height + self.actionView.frame.size.height)];
    
    self.workButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.workButton.layer.borderWidth = 1;
    self.joinPlanButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.joinPlanButton.layer.borderWidth = 1;
    
    for (UIImageView *imgView in self.avatarGridView.subviews) {
        imgView.layer.cornerRadius = imgView.frame.size.width/2;
        imgView.layer.masksToBounds = YES;
        imgView.image = [UIImage imageNamed:@"test_avatar.jpg"];
    }
}

@end
