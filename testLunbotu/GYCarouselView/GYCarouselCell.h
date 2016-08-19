//
//  GYCarouselCell.h
//  testLunbotu
//
//  Created by ronmei on 16/7/25.
//  Copyright © 2016年 gaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYCarouselCell : UICollectionViewCell

@property (nonatomic, strong) id icon;

- (void)setIcon:(id)icon placeholder:(NSString *)placeholder contentMode:(UIViewContentMode)contentMode;

@end
