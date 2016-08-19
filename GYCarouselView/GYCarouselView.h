//
//  GYCarouselView.h
//  testLunbotu
//
//  Created by ronmei on 16/7/25.
//  Copyright © 2016年 gaoyu. All rights reserved.
//
/**
 *  自动轮播图
 *
 *  @param  简易版本, 日后更新: 支持代码和XIB, 清楚缓存用SDWebImage统一管理
 *
 *  @author 郜宇
 */

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







@end
