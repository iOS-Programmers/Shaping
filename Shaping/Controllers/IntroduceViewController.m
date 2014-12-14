//
//  IntroduceViewController.m
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) IBOutlet UIView *avatarGridView;
@property (strong, nonatomic) IBOutlet UIButton *workButton;
@property (strong, nonatomic) IBOutlet UIButton *joinPlanButton;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"介绍";
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
    
    [self.contentImageView setImageWithURL:[NSURL URLWithString:@"http://s9.knowsky.com/tupian/tu/2/2012021411055957878.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
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
