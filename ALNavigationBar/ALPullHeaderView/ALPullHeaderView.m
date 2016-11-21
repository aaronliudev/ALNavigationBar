//
//  ALPullHeaderView.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALPullHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define ALPullHeaderViewHeight 265

@interface ALPullHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ALPullHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)dealloc
{
    [self removeOcObserver];
}

- (void)configSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, ALPullHeaderViewHeight);
    [self addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ALPullHeaderViewHeight);

    // if RAC observer
//    [self al_racObserver];
    
    // else OC observer
    [self addOcObserver];
}

// MARK: - Add Observer
// MARK: Rac Observer
- (void)al_racObserver
{
//    [[RACObserve(self, contentOffset) filter:^BOOL(id x) {
//        return [x CGPointValue].y <= 0;
//    }]
//     subscribeNext:^(id x) {
//         CGPoint contentOffset = [x CGPointValue];
//         self.imageView.frame = CGRectMake(0, 0 + contentOffset.y, SCREEN_WIDTH, ALPullHeaderViewHeight + ABS(contentOffset.y));
//     }];
}

// MARK: Oc Observer
static void *observerKey = @"observerKey";
- (void)addOcObserver
{
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:observerKey];
}

- (void)removeOcObserver
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == observerKey)
    {
        if ([keyPath isEqualToString:@"contentOffset"])
        {
            CGPoint contentOffset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
            if (contentOffset.y <= 0) {
                self.imageView.frame = CGRectMake(0, 
                                                  0 + contentOffset.y, 
                                                  SCREEN_WIDTH,
                                                  ALPullHeaderViewHeight + fabs(contentOffset.y));
            }
        }
    }
}

// MARK: - Set Method
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self configData];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self configData];
}

- (void)configData
{
    if (self.image)
    {
        self.imageView.image = self.image;
    }
    else if ([self.imageUrl isKindOfClass:[NSString class]] && 
             self.imageUrl.length)
    {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    }
    else
    {
        
    }
}

// MARK: - Get Method
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

@end
