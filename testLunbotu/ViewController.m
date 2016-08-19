//
//  ViewController.m
//  testLunbotu
//
//  Created by ronmei on 16/7/25.
//  Copyright © 2016年 gaoyu. All rights reserved.
//

#import "ViewController.h"
#import "GYCarouselView.h"


@interface ViewController () <GYCarouselViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    GYCarouselView *carouselView = [GYCarouselView gy_creatCarouselViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) images:@[@"http://hjp2p.ronmei.com/Public/app/images/init/20160728164454670.jpg",@"http://hjp2p.ronmei.com/Public/app/images/init/20160728164457335.jpg",@"http://hjp2p.ronmei.com/Public/app/images/init/20160728164459486.jpg",@"http://hjp2p.ronmei.com/Public/app/images/init/20160729152607730.jpg"]];
    carouselView.delegate = self;
    carouselView.pageControlPosition = GYPageControlPositionRight;
    [self.view addSubview:carouselView];
}


- (void)gy_carouselView:(GYCarouselView *)carouselView didSelectedIndex:(NSInteger)index content:(id)content
{
    NSLog(@"%@----%zd------%@", carouselView, index, content);
}









@end
