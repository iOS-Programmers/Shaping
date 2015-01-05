//
//  FriendDynamicCell.m
//  Shaping
//
//  Created by Jyh on 14/12/7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "FriendDynamicCell.h"

@implementation FriendDynamicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentAction:(id)sender {
    if (_delegate && [self.delegate respondsToSelector:@selector(commentClickWithFeedTime:)]) {
        [self.delegate commentClickWithFeedTime:self];
    }
}

- (IBAction)avatarAction:(id)sender {
    if (_delegate && [self.delegate respondsToSelector:@selector(avatarCilckWithFeedTime:)]) {
        [self.delegate avatarCilckWithFeedTime:self];
    }
}

- (IBAction)zanAction:(id)sender {

    if (_delegate && [self.delegate respondsToSelector:@selector(zanBtnClickWithFeedTime:)]) {
        [self.delegate zanBtnClickWithFeedTime:self];
    }
}

- (IBAction)likeAction:(id)sender {

    if (_delegate && [self.delegate respondsToSelector:@selector(likeBtnClickWithFeedTime:)]) {
        [self.delegate likeBtnClickWithFeedTime:self];
    }
}
@end
