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

-(void)setDynamicInfo:(SPDynamicInfo *)dynamicInfo{
    
    _dynamicInfo = dynamicInfo;
    
    [self.conImageView setImageWithURL:[NSURL URLWithString:@"http://y0.ifengimg.com/e7f199c1e0dbba14/2013/0722/rdn_51ece7b8ad179.jpg"] placeholderImage:[UIImage imageNamed:@"feed_test"]];
    self.titleLabel.text = dynamicInfo.content;
//    [self.hotButton setTitle:dynamicInfo forState:0];
}

@end
