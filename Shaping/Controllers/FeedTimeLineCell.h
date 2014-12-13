//
//  FeedTimeLineCell.h
//  Shaping
//
//  Created by liguangjun on 14-12-7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedTimeLineCellDelegate;

@interface FeedTimeLineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *conImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *hotButton;
@property (assign, nonatomic) id <FeedTimeLineCellDelegate>delegate;

- (IBAction)commentAction:(id)sender;
- (IBAction)praiseAction:(id)sender;
- (IBAction)likeAction:(id)sender;
@end

@protocol FeedTimeLineCellDelegate <NSObject>
@optional
-(void)commentActionWithFeedTime:(FeedTimeLineCell *)cell;
-(void)praiseActionWithFeedTime:(FeedTimeLineCell *)cell;
-(void)likeActionWithFeedTime:(FeedTimeLineCell *)cell;

@end