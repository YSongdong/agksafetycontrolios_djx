//
//  YWTImageListView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTImageListView.h"
#import "MMImagePreviewView.h"


// 图片宽度
#define kImageWidth             113
// 图片间距
#define kImagePadding           5

#pragma mark - ------------------ 小图List显示视图 ------------------

@interface YWTImageListView ()
// 图片视图数组
@property (nonatomic, strong) NSMutableArray * imageViewsArray;
// 预览视图
@property (nonatomic, strong) MMImagePreviewView * previewView;

@end

@implementation YWTImageListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            YWTImageView * imageView = [[YWTImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            imageView.backgroundColor = [UIColor blackColor];
            [imageView setClickHandler:^(YWTImageView *imageView){
                [self singleTapSmallViewCallback:imageView];
                if (self.singleTapHandler) {
                    self.singleTapHandler(imageView);
                }
            }];
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[MMImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}
-(void)setImageModel:(YWTPartyEemberAreaModel *)imageModel{
    _imageModel = imageModel;
    for (YWTImageView * imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    // 图片区
    NSInteger count = [imageModel.filelist count];
    if (count == 0) {
        self.size = CGSizeZero;
        return;
    }
    //1纯文章 2文章加图片 3文章加视频
    if ([imageModel.types isEqualToString:@"3"]) {
        self.size = CGSizeZero;
        return;
    }
    
    // 更新视图数据
    _previewView.pageNum = count;
    _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    // 添加图片
    YWTImageView * imageView = nil;
    for (NSInteger i = 0; i < count; i++)
    {
        NSInteger rowNum = i / 3;
        NSInteger colNum = i % 3;
        if(count == 4) {
            rowNum = i / 2;
            colNum = i % 2;
        }
        CGFloat imageX = colNum * (kImageWidth + kImagePadding);
        CGFloat imageY = rowNum * (kImageWidth + kImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, kImageWidth, kImageWidth);
        
        // 单张图片需计算实际显示size
        if (count == 1) {
            CGSize singleSize = [self getMomentImageSize:CGSizeMake(kImageWidth, kImageWidth)];
            frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
        }
        imageView = [self viewWithTag:1000 + i];
        imageView.hidden = NO;
        imageView.frame = frame;
    }
    self.width = KScreenW - 24;
    self.height = imageView.bottom;
}

// 图片渲染
- (void)loadPicture{
    // 图片区
    NSInteger count = _imageModel.filelist.count;
    YWTImageView * imageView = nil;
    for (NSInteger i = 0; i < count; i++){
        imageView = [self viewWithTag:1000 + i];
        // 赋值>图片渲染
        NSString * url = [_imageModel.filelist objectAtIndex:i];
        [YWTTools sd_setImageView:imageView WithURL:url andPlaceholder:@"patry_list_photo_default"];
    }
}
#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(YWTImageView *)imageView{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    // 解除隐藏
    [window addSubview:_previewView];
    [window bringSubviewToFront:_previewView];
    // 清空
    [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加子视图
    NSInteger index = imageView.tag - 1000;
    NSInteger count =_imageModel.filelist.count;
    CGRect convertRect;
    if (count == 1) {
        [_previewView.pageControl removeFromSuperview];
    }
    for (NSInteger i = 0; i < count; i ++)
    {
        // 转换Frame
        YWTImageView *pImageView = (YWTImageView *)[self viewWithTag:1000+i];
        convertRect = [[pImageView superview] convertRect:pImageView.frame toView:window];
        // 添加
        MMScrollView *scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
        scrollView.tag = 100+i;
        scrollView.maximumZoomScale = 2.0;
        scrollView.image = pImageView.image;
        scrollView.contentRect = convertRect;
        // 单击
        [scrollView setTapBigView:^(MMScrollView *scrollView){
            [self singleTapBigViewCallback:scrollView];
        }];
        // 长按
        [scrollView setLongPressBigView:^(MMScrollView *scrollView){
            [self longPresssBigViewCallback:scrollView];
        }];
        [_previewView.scrollView addSubview:scrollView];
        if (i == index) {
            [UIView animateWithDuration:0.3 animations:^{
                self.previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                self.previewView.pageControl.hidden = NO;
                [scrollView updateOriginRect];
            }];
        } else {
            [scrollView updateOriginRect];
        }
    }
    // 更新offset
    CGPoint offset = _previewView.scrollView.contentOffset;
    offset.x = index * KScreenW;
    _previewView.scrollView.contentOffset = offset;
    // 当前页码
    NSInteger page = imageView.tag - 1000;
    _previewView.pageControl.currentPage = page;
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(MMScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [self.previewView removeFromSuperview];
    }];
}
- (void)longPresssBigViewCallback:(MMScrollView *)scrollView
{
    
}
// 获取单张图片的实际size
- (CGSize)getMomentImageSize:(CGSize)size{
    // 最大尺寸
    CGFloat max_width = KScreenW - 150;
    CGFloat max_height = KScreenW - 130;
    // 原尺寸
    CGFloat width = size.width;
    CGFloat height = size.height;
    // 输出
    CGFloat out_width = 0;
    CGFloat out_height = 0;
    if (height / width > 3.0) { // 细长图
        out_height = max_height;
        out_width = out_height / 2.0;
    } else  {
        out_width = max_width;
        out_height = max_width * height / width;
        if (out_height > max_height) {
            out_height = max_height;
            out_width = max_height * width / height;
        }
    }
    return CGSizeMake(out_width, out_height);
}


@end

#pragma mark - ------------------ 单个小图显示视图 ------------------
@implementation  YWTImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds  = YES;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
{
    if (self.clickHandler) {
        self.clickHandler(self);
    }
}

@end

