//
//  PlanCell.m
//  Shaping
//
//  Created by Jyh on 14/12/7.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "PlanCell.h"

@implementation PlanCell

- (void)awakeFromNib {
    // Initialization code
    
    self.infoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.infoView.layer.borderWidth = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
