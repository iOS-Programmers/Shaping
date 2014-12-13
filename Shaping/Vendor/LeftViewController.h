//
//  LeftViewController.h
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
{
    
    UIView *topView;
    UITableView *myTableV;
    
    NSArray *iconsNomalArray;
    NSArray *iconsSelectArray;
    NSArray *namesArray;

    NSInteger lastSelectedRow; //记录最近被点击的按钮
    NSMutableArray *cellsArray;
}
@end
