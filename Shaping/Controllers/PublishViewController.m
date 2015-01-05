//
//  PublishViewController.m
//  Shaping
//
//  Created by Jyh on 14/12/5.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "PublishViewController.h"
#import "PlacehoderTextView.h"

#define ADDPICBTN_TAG 110

@interface PublishViewController () <UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) PlacehoderTextView *textView;

@property (nonatomic,assign) int curImageCount;      //记录当前第几个

@property (strong, nonatomic) NSMutableArray *imageIds;   //存图片ID的数组

@property (strong, nonatomic) UIImagePickerController *imagePicker;

- (IBAction)onPublishBtnClick:(UIButton *)sender;
- (IBAction)onUploadPicClick:(id)sender;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布";
    
    self.imageIds = [[NSMutableArray alloc] init];
    
    _textView = [[PlacehoderTextView alloc] initWithFrame:CGRectMake(0, 10, 300, 125)];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.placeholder = @"写下汗水背后的故事，让更多人为你加油！";
    
    [self.contentView addSubview:_textView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10,IOS7_OR_LATER ?25:5, 70,30);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateHighlighted];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:self action:@selector(leftNavAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* leftItem=[[UIBarButtonItem alloc]initWithCustomView:btn];

    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.imagePicker =[[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    
    [self onUploadPicClick:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)leftNavAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

/**
 *  发布动态
 *
 */
- (IBAction)onPublishBtnClick:(UIButton *)sender {
    
    if (FBIsEmpty(self.textView.text)) {
        [self showWithText:@"请输入内容！"];
        
        return;
    }
    
    [self addDynamicInfo];
}

-(void)addDynamicInfo{
    
    __weak PublishViewController *weakSelf = self;
    int tag = [[ShapingEngine shareInstance] getConnectTag];
    [[ShapingEngine shareInstance] getDynamicAddDynamicWith:self.textView.text userid:[ShapingEngine userId] tag:tag];
    [[ShapingEngine shareInstance] addOnAppServiceBlock:^(NSInteger tag, NSDictionary *jsonRet, NSError *err) {
        
        NSString* errorMsg = [ShapingEngine getErrorMsgWithReponseDic:jsonRet];
        if (!jsonRet || errorMsg) {
            return;
        }
        
        NSString *statusStr = [NSString stringWithFormat:@"%@",[jsonRet objectForKey:@"status"]];
        
        if ([statusStr isEqualToString:@"1"]) {
        
            [weakSelf showWithText:@"发布成功!"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    
                }];
            });
        }
        
        else {
            NSString *content = [NSString stringWithFormat:@"%@",[jsonRet objectForKey:@"content"]];
            if (!FBIsEmpty(content)) {
                [weakSelf showWithText:content];
            }
            
            return;
        }
        
    } tag:tag];
}


- (IBAction)onUploadPicClick:(id)sender {

    if (self.intype == PhotoAlbumType)
    {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
    else if (self.intype == CameraType)
    {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
}


#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *rightImage = [LXUtils rotateImage:image];
    UIButton *addPicBtn = (UIButton *)[self.contentView viewWithTag:ADDPICBTN_TAG+self.curImageCount];
    [addPicBtn setImage:rightImage forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(88*(addPicBtn.tag-199)+14*(addPicBtn.tag-200),206,22,22);
    btn.tag = self.curImageCount;
    
    [self.contentView addSubview:btn];
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}
//删除图片
-(void)deleteAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.hidden = YES;
    UIButton *addPicBtn = (UIButton *)[self.view viewWithTag:ADDPICBTN_TAG+btn.tag];
    [addPicBtn setImage:[UIImage imageNamed:@"btn_add_img.png"] forState:UIControlStateNormal];
    [self.imageIds replaceObjectAtIndex:addPicBtn.tag - 200 withObject:@"0"];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSString *str in self.imageIds)
    {
        if (![str isEqualToString:@"0"])
        {
            [array addObject:str];
            
        }
    }
//    self.banJinHelperHttp.parameter.case_imgs = [array componentsJoinedByString:@","];
    
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
