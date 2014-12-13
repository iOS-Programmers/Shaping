//
//  CustomTextField.m
//  Bodybuilding
//
//  Created by zhangyajun on 14-9-5.
//  Copyright (c) 2014年 zhangyajun. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+55, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    
    return inset;
    
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +55, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    //CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, 45, bounds.size.height);
    return inset;
    //return CGRectInset(bounds,50,0);
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [[UIColor orangeColor] setFill];
    
    //[[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:14]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
