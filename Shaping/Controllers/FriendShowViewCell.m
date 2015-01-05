//
//  FriendShowViewCell.m
//  Shaping
//
//  Created by liguangjun on 14-12-14.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "FriendShowViewCell.h"

@implementation FriendShowViewCell

- (void)awakeFromNib {
    // Initialization code
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onAttentionBtnClick:(id)sender {
}
@end
