//
//  HomeCommandCell.m
//  Shaping
//
//  Created by Jyh on 14/12/7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "HomeCommandCell.h"

@implementation HomeCommandCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTopicInfo:(SPTopicInfo *)topicInfo{
    _topicInfo = topicInfo;
    [self.avatarImageView setImageWithURL:topicInfo.imgUrl placeholderImage:[UIImage imageNamed:@"home_fuji"]];
    self.titleLabel.text = topicInfo.title;
    self.contentLabel.text = topicInfo.content;
}

@end
