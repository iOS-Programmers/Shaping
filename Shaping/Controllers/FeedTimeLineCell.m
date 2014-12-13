//
//  FeedTimeLineCell.m
//  Shaping
//
//  Created by liguangjun on 14-12-7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "FeedTimeLineCell.h"

@implementation FeedTimeLineCell

- (void)awakeFromNib {
    // Initialization code
    
    _conImageView.contentMode = UIViewContentModeScaleAspectFill;
    _conImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentAction:(id)sender {
    if (_delegate && [self.delegate respondsToSelector:@selector(commentActionWithFeedTime:)]) {
        [self.delegate commentActionWithFeedTime:self];
    }
}

- (IBAction)praiseAction:(id)sender {
    if (_delegate && [self.delegate respondsToSelector:@selector(praiseActionWithFeedTime:)]) {
        [self.delegate praiseActionWithFeedTime:self];
    }
}

- (IBAction)likeAction:(id)sender {
    if (_delegate && [self.delegate respondsToSelector:@selector(likeActionWithFeedTime:)]) {
        [self.delegate likeActionWithFeedTime:self];
    }
}
@end
