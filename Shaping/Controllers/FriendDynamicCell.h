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

@property (assign, nonatomic) id <FriendDynamicCellDelegate>delegate;

- (IBAction)commentAction:(id)sender;
- (IBAction)avatarAction:(id)sender;
@end

@protocol FriendDynamicCellDelegate <NSObject>
@optional
-(void)commentClickWithFeedTime:(FriendDynamicCell *)cell;
-(void)avatarCilckWithFeedTime:(FriendDynamicCell *)cell;

@end