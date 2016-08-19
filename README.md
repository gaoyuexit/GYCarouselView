# GYCarouselView
无限滚动轮播图
支持本地, 网络图片加载

####使用
```objc
    GYCarouselView *carouselView = [GYCarouselView gy_creatCarouselViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) images:@[@"img1", @"img2", @"img3"]];
    carouselView.delegate = self;
    carouselView.pageControlPosition = GYPageControlPositionRight;
    [self.view addSubview:carouselView];
```
####回调

```objc
- (void)gy_carouselView:(GYCarouselView *)carouselView didSelectedIndex:(NSInteger)index content:(id)content
{
    NSLog(@"%@----%zd------%@", carouselView, index, content);
}
```
####接口

```objc
#import <UIKit/UIKit.h>
@class GYCarouselView;
@class StyledPageControl;

typedef enum{
    GYPageControlPositionCenter = 0,
    GYPageControlPositionLeft,
    GYPageControlPositionRight
}GYPageControlPosition;

@protocol GYCarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调
 *
 *  @param carouselView 轮播视图
 *  @param index        点击的图片下标
 *  @param content      图片
 */
- (void)gy_carouselView:(GYCarouselView *)carouselView
       didSelectedIndex:(NSInteger)index
                content:(id)content;
@end

@interface GYCarouselView : UIView

@property (nonatomic, weak)     id <GYCarouselViewDelegate>delegate;
/**
 *  占位图片NSString
 */
@property (nonatomic, copy)     NSString *placeholder;
/**
 *  轮播图间隔 默认5秒 
 */
@property (nonatomic, assign)   NSTimeInterval second;
/**
 *  图片显示模式 默认为UIViewContentModeScaleToFill
 */
@property(nonatomic)            UIViewContentMode contentMode;

/**
 *  轮播图PageControl的位置,默认GYPageControlPositionCenter
 */
@property (nonatomic, assign)   GYPageControlPosition pageControlPosition;
/**
 *  自定义PageControl
 */
@property (nonatomic, strong)   StyledPageControl     *pageControl;



/**
 *  构建方法
 */
+ (instancetype)gy_creatCarouselViewWithFrame:(CGRect)frame localOfImageNames:(NSArray *)localImages;

+ (instancetype)gy_creatCarouselViewWithFrame:(CGRect)frame urlStringOfImages:(NSArray *)imageUrls;

+ (instancetype)gy_creatCarouselViewWithFrame:(CGRect)frame images:(NSArray<id> *)images;
```


