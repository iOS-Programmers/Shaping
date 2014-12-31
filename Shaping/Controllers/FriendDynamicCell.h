//
//  FriendDynamicCell.h
//  Shaping
//
//  Created by Jyh on 14/12/7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendDynamicCellDelegate;

@interface FriendDynamicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *avtarImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (assign, nonatomic) id <FriendDynamicCellDelegate>delegate;

- (IBAction)commentAction:(id)sender;
- (IBAction)avatarAction:(id)sender;
@end

@protocol FriendDynamicCellDelegate <NSObject>
@optional
-(void)commentClickWithFeedTime:(FriendDynamicCell *)cell;
-(void)avatarCilckWithFeedTime:(FriendDynamicCell *)cell;

@end