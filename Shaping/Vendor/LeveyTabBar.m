//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBar.h"
#import "selectLeveyTabBarIndex.h"

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate;
@synthesize buttons = _buttons;
@synthesize names = _names;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray names:(NSArray *)nameArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
        selectedImageArray = [[NSMutableArray alloc] init];
        defaultImageArray = [[NSMutableArray alloc] init];
        imgsArray = [[NSMutableArray alloc] init];
        lablArray = [[NSMutableArray alloc] init];
        UIButton *bgBtn;
		UIImageView *img;
        UILabel *name;
        
		//CGFloat width = 320.0f / [imageArray count];
        CGFloat width = 64.0f;
        
   
        //底边栏
        
        
        //CGFloat orig_wigth = 0.0f;
        
        CGFloat origWigth = 0.0f;
        //CGFloat spaceWigth = 6.0f;
        //CGFloat butWigth = 28.0f;
        
//        //iPad 侧边栏
//        CGFloat ori_heigth_iPad = 0.0f;
//        CGFloat tabBar_iPad_heigth = 62.8f;//tabbar的高度（iPad）
//        CGFloat tabBar_iPad_wigth = 62.8f;
//       // CGFloat spaceHeigth_iPad = 10.0f;
//        CGFloat image_ori_heigth;
//        //CGFloat name_ori_heigth;
        
		for (int i = 0; i < [imageArray count]+1; i++)
		{
            bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //bgBtn.frame = CGRectMake(origWigth, 0, butWigth, 25.0f);
            //btn.frame = CGRectMake(origWigth, 0, butWigth, 25.0f);
            
            
            name = [[UILabel alloc] init];
            
            if (i == 2) {
                img = [[UIImageView alloc] init];
                UIImage *imag = [[imageArray objectAtIndex:i] objectForKey:@"Default"];
                
                bgBtn.frame = CGRectMake(origWigth, -20.0f, width, 56.0f);
                
                imag = [UIImage imageNamed:@"homt_big_plus"];
                
                img.frame = CGRectMake(origWigth, -20.0f, imag.size.width, imag.size.height);
                [img setImage:[UIImage imageNamed:@"homt_big_plus"]];
                
                name.frame = CGRectMake(origWigth, img.frame.size.height + 4.0f, width, frame.size.height - img.frame.size.height - 3.0f);
                origWigth += width;
                [bgBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            }else {
                
                UIImage *imag;
                if (i == 3||i == 4) {
                    bgBtn.tag = i-1;
                    
                    img = [[UIImageView alloc] initWithImage:[[imageArray objectAtIndex:i-1] objectForKey:@"Default"]];
                    imag = [[imageArray objectAtIndex:i-1] objectForKey:@"Default"];
                    [selectedImageArray addObject:[[imageArray objectAtIndex:i-1] objectForKey:@"Selected"]];
                    [defaultImageArray addObject:[[imageArray objectAtIndex:i-1] objectForKey:@"Default"]];
                    [name setText:[nameArray objectAtIndex:i-1]];
                    
                }else {
                    bgBtn.tag = i;
                    
                    img = [[UIImageView alloc] initWithImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"]];
                    imag = [[imageArray objectAtIndex:i] objectForKey:@"Default"];
                    [selectedImageArray addObject:[[imageArray objectAtIndex:i] objectForKey:@"Selected"]];
                    [defaultImageArray addObject:[[imageArray objectAtIndex:i] objectForKey:@"Default"]];
                    [name setText:[nameArray objectAtIndex:i]];
                    
                }
                
                bgBtn.frame = CGRectMake(origWigth, 0.0f, width, 46.0f);
                //bgBtn.backgroundColor = [UIColor blackColor];
                img.frame = CGRectMake(origWigth+20, 5.0f, imag.size.width, imag.size.height);
                
                name.frame = CGRectMake(origWigth+1, img.frame.size.height + 4.0f, width, frame.size.height - img.frame.size.height - 3.0f);
                origWigth += width;
                [imgsArray addObject:img];
                [name setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:11.0]];
                [name setTextColor:[UIColor whiteColor]];
                [name setTextAlignment:NSTextAlignmentCenter];
                [name setBackgroundColor:[UIColor clearColor]];
                [lablArray addObject:name];
                
                [self.buttons addObject:bgBtn];
                
                [bgBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
            
            
            bgBtn.showsTouchWhenHighlighted = NO;
            
            //bgBtn.backgroundColor = [UIColor clearColor];
            
            
            
           
            //[bgBtn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
            //[bgBtn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Selected"] forState:UIControlStateSelected];
            
             // NSLog(@"%d",selectedImageArray.count);
            
            //[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:img];
            [self addSubview:name];
            [self addSubview:bgBtn];
            
        }
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)image
{
	[_backgroundView setImage:image];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
   
    [self selectTabAtIndex:btn.tag];
    
    [selectLeveyTabBarIndex shareObject].selectedIndex = btn.tag;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [self.delegate tabBar:self didSelectIndex:btn.tag];
    } 
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
		b.userInteractionEnabled = YES;
        UIImageView *im = [imgsArray objectAtIndex:i];
        im.image = [defaultImageArray objectAtIndex:i];
        UILabel *lab = [lablArray objectAtIndex:i];
        [lab setTextColor:[UIColor whiteColor]];
        
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
	btn.userInteractionEnabled = NO;
    UIImageView *i = [imgsArray objectAtIndex:index];
    i.image = [selectedImageArray objectAtIndex:index];
    UILabel *lab = [lablArray objectAtIndex:index];
//    [lab setTextColor:ORANGE];
    

}
- (void)centerBtnClick:(UIButton*)sender
{
    [self.centerBtnClickDelegate publishbuttonClicked];
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) 
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
//    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}



@end
