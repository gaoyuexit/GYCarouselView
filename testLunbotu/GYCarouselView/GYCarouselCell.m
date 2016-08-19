//
//  GYCarouselCell.m
//  testLunbotu
//
//  Created by ronmei on 16/7/25.
//  Copyright © 2016年 gaoyu. All rights reserved.
//

#import "GYCarouselCell.h"
#import "UIImageView+WebCache.h"
@interface GYCarouselCell ()
@property (nonatomic, weak) UIImageView *imgView;
@end

@implementation GYCarouselCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
}

- (void)setIcon:(id)icon placeholder:(NSString *)placeholder contentMode:(UIViewContentMode)contentMode
{
    _icon = icon;
    if (placeholder && ![placeholder isEqualToString:@""]) {
        self.imgView.image = [UIImage imageNamed:placeholder];
    }
    if ([icon isKindOfClass:[NSString class]]) {
        if ([icon hasPrefix:@"http"]) {
            if (placeholder && ![placeholder isEqualToString:@""]) {
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:placeholder]];
            }else{
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:icon]];
            }
            
        }else{
            self.imgView.image = [UIImage imageNamed:icon];
        }
    }else if ([icon isKindOfClass:[UIImage class]]){
        self.imgView.image = (UIImage *)icon;
    }else if ([icon isKindOfClass:[NSURL class]]){
        [self.imgView sd_setImageWithURL:icon placeholderImage:[UIImage imageNamed:placeholder]];
    }
 
}




@end
