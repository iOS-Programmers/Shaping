//
//  HomeCommandCell.h
//  Shaping
//
//  Created by Jyh on 14/12/7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTopicInfo.h"

@interface HomeCommandCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) SPTopicInfo *topicInfo;

@end
