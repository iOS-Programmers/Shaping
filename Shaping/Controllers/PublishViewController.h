//
//  PublishViewController.h
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "YHBaseViewController.h"

typedef enum : NSUInteger {
    DefaultType = 0,
    PhotoAlbumType , //相册模式
    CameraType,      //相机模式
} InType;

@interface PublishViewController : YHBaseViewController

@property (nonatomic) InType intype;

@end
