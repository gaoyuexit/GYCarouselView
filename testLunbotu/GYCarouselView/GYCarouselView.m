//
//  GYCarouselView.m
//  testLunbotu
//
//  Created by ronmei on 16/7/25.
//  Copyright © 2016年 gaoyu. All rights reserved.
//

#import "GYCarouselView.h"
#import "GYCarouselCell.h"
#import "SDImageCache.h"
#import "StyledPageControl.h"

@interface GYCarouselView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, strong) NSMutableArray    *imgsContentArr;
@end

static NSInteger const maxSection = 3;
static NSString *ID = @"GYCarouselCell";

@implementation GYCarouselView

+ (instancetype)gy_creatCarouselViewWithFrame:(CGRect)frame localOfImageNames:(NSArray *)localImages
{
    return [self gy_creatCarouselViewWithFrame:frame images:localImages];
}

+ (instancetype)gy_creatCarouselViewWithFrame:(CGRect)frame urlStringOfImages:(NSArray *)imageUrls
{
    return [self gy_creatCarouselViewWithFrame:frame images:imageUrls];
}

+ (instancetype)gy_creatCarouselViewWithFrame:(CGRect)frame images:(NSArray<id> *)images
{
    GYCarouselView *carouseView = [[self alloc] initWithFrame:frame];
    carouseView.imgsContentArr = [NSMutableArray arrayWithArray:images];
    return carouseView;
}

- (void)awakeFromNib
{
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.pageControlPosition = GYPageControlPositionCenter;
}

- (void)setupSubViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[GYCarouselCell class] forCellWithReuseIdentifier:ID];
    [self addSubview:_collectionView];
    _pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 37, self.frame.size.width, 37)];
    
    [_pageControl setPageControlStyle:PageControlStyleThumb];
    [_pageControl setThumbImage:[UIImage imageNamed:@"normalIndicatorImg"]];
    [_pageControl setSelectedThumbImage:[UIImage imageNamed:@"trackIndicatorImg"]];
    [_pageControl setGapWidth:5];
    [self addSubview:_pageControl];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:maxSection / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    _pageControl.numberOfPages = self.imgsContentArr.count;
    [self addTimer];
}


- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:(self.second?self.second:5) target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)nextPage
{
    NSIndexPath *currentResetIndexPath = [self resetCurrentIndexPath];
    NSInteger nextItem = currentResetIndexPath.item + 1;
    NSInteger nextSection = currentResetIndexPath.section;
    if (nextItem == self.imgsContentArr.count) {
        nextSection++;
        nextItem = 0;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSIndexPath *)resetCurrentIndexPath
{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentResetIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.item inSection:maxSection/2];
    [self.collectionView scrollToItemAtIndexPath:currentResetIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentResetIndexPath;
}

- (void)setPageControlPosition:(GYPageControlPosition)pageControlPosition
{
    _pageControlPosition = pageControlPosition;
    switch (pageControlPosition) {
        case GYPageControlPositionLeft:
            _pageControl.frame = CGRectMake(0, self.frame.size.height - 37, _imgsContentArr.count*20, 37);
            break;
        case GYPageControlPositionRight:
            _pageControl.frame = CGRectMake(self.bounds.size.width-_imgsContentArr.count*20, self.frame.size.height - 37, _imgsContentArr.count*20, 37);
            break;
        case GYPageControlPositionCenter:
            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgsContentArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GYCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    [cell setIcon:self.imgsContentArr[indexPath.item] placeholder:self.placeholder contentMode:self.contentMode];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return maxSection;
}

#pragma - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gy_carouselView:didSelectedIndex:content:)]) {
        [self.delegate gy_carouselView:self didSelectedIndex:indexPath.item content:self.imgsContentArr[indexPath.item]];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetCurrentIndexPath];
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.imgsContentArr.count;
    self.pageControl.currentPage = page;
}

//参考
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}









@end
