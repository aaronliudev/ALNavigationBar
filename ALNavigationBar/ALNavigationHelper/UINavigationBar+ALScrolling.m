//
//  UINavigationBar+ALScrolling.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "UINavigationBar+ALScrolling.h"
#import <objc/Object.h>

#define ALNavigationBarHeight 64
#define ALNavigationBarWithoutStatusBarHeight 44
#define ALNavigationScrollingMaxOffsetY 200


typedef NS_ENUM(NSUInteger, ALNavigationBarScrollingDirection) {
    ALNavigationBarScrollingDirectionUp = 0,
    ALNavigationBarScrollingDirectionDown
};

@interface UINavigationBar ()

/// the view add in the navigation bar, index = 0.
@property (nonatomic, strong) UIView *al_barView;

/// last offset，user this to check to show or hide the navigation bar
@property (nonatomic, assign) CGFloat al_lastOffsetY;
/// scrolling up turn to down, vice versa. Default is NO
@property (nonatomic, assign) ALNavigationBarScrollingDirection al_scrollingDirection;
///
@property (nonatomic, assign) CGFloat al_progress;

@end

static char ALNavigationBarViewKey;
static char ALNavigationBarBgColorKey;
static char ALLastOffsetYKey;
static char ALNavigationBarStyleKey;
static char ALScrollingDirectionKey;
static char ALNavigationBarProgressKey;
static char ALScrollingMaxOffsetYKey;

@implementation UINavigationBar (ALBackgroundColor)

// MARK: - Publick Method
- (void)al_setBarTranslationWithOffsetY:(CGFloat)offsetY
{
    switch (self.al_navigationBarStyle)
    {
        case ALNavigationBarDefault:
        {
            [self al_navigationBarMoveDefault:offsetY];
        }
            break;
        case ALNavigationBarScrolling:
        {
            [self al_navigationBarScrolling:offsetY];
        }
            break;
        default:
            break;
    }
}

/// when `viewWillDisappeare:` must call this, reset all value.
- (void)al_resetNavigationBar
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.al_progress = 0;
    [self al_setNavigationBartranslationProgress:0];
    
    [self.al_barView removeFromSuperview];
    self.al_barView = nil;
}

- (void)al_navigationBarMoveDefault:(CGFloat)offsetY
{
    CGFloat progress = 0;
    CGFloat diffY = offsetY - self.al_maxOffsetY;
    if (offsetY < self.al_maxOffsetY) {
        progress = 0;
    }
    else if (diffY < ALNavigationBarHeight)
    {
        progress = MIN(MAX(diffY / ALNavigationBarHeight, 0), 1);
    }
    else
    {
        progress = 1;
    }
    
    [self al_hideNavigationBar:progress];
}

- (void)al_navigationBarScrolling:(CGFloat)offsetY
{
    if (offsetY > 0) {
        CGFloat barheight = ALNavigationBarHeight;
        CGFloat value = offsetY - self.al_lastOffsetY;
        CGFloat absY = fabs(value);
        
        if (self.al_scrollingDirection == ALNavigationBarScrollingDirectionUp)
        {
            CGFloat progress = self.al_progress + absY / barheight;
            self.al_progress = MIN(1, MAX(0, progress));
        }
        else {
            
            CGFloat progress = self.al_progress - absY / barheight;
            self.al_progress = MAX(0, MIN(1, progress));
        }
        
        if (offsetY > self.al_lastOffsetY)
        {
            self.al_scrollingDirection = ALNavigationBarScrollingDirectionUp;
        }
        else
        {
            self.al_scrollingDirection = ALNavigationBarScrollingDirectionDown;
        }
        self.al_lastOffsetY = offsetY;
    }
    else
        self.al_progress = 0;
    
    [self al_setNavigationBartranslationProgress:self.al_progress];
}

// MARK: - Private Method
- (void)al_setBarBackgroundColor:(UIColor *)bgColor
{
    if (!self.al_barView)
    {
        // 
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        self.al_barView = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                                   0,
                                                                   CGRectGetWidth(self.bounds), 
                                                                   [self al_navigationBarHeight])];
        self.al_barView.userInteractionEnabled = NO;
        self.al_barView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[self.subviews firstObject] insertSubview:self.al_barView atIndex:0];
    }
    self.al_barView.backgroundColor = bgColor;
}

/// progress
- (void)al_setNavigationBartranslationProgress:(CGFloat)progress
{
    CGFloat navigationBarHeight = ALNavigationBarWithoutStatusBarHeight;
    CGFloat offsetY = -(navigationBarHeight * progress);
    [self al_setBarTranslationY: offsetY];
    [self al_setBarTranslationBackgroundAlpha:(1 - progress)];
}

//
- (void)al_setBarTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

// set alpha
- (void)al_setBarTranslationBackgroundAlpha:(CGFloat)alpha
{
    // itemStack find the last backButtonView
    NSArray *itemStack = [self valueForKey:@"_itemStack"];
    if ([itemStack isKindOfClass:[NSArray class]] && itemStack.count > 1) {
        UINavigationItem *item = (UINavigationItem *)[itemStack objectAtIndex:(itemStack.count - 2)];
        ((UIView *)[item valueForKey:@"_backButtonView"]).alpha = alpha;
    }
    ((UIView *)[self valueForKey:@"_backIndicatorView"]).alpha = alpha;
    
    // set leftItems
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = alpha;
    }];
    
    // set rightItems
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = alpha;
    }];
    
    // set title view
    ((UIView *)[self valueForKey:@"_titleView"]).alpha = alpha;
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
    self.alpha = alpha;
    //
    if (ALNavigationBarDefault == self.al_navigationBarStyle)
    {
//        [self al_hideNavigationBar:alpha];
    }
}

// set al_barView alpha
- (void)al_hideNavigationBar:(CGFloat)alpha
{
    [[self subviews] objectAtIndex:0].alpha = alpha;
}

// navigation bar height
- (CGFloat)al_navigationBarHeight
{
    return [self al_isShowStatusBar] ? ALNavigationBarWithoutStatusBarHeight : ALNavigationBarHeight;
}

// MARK: - Set & Get Method
// MARK: Public Property
- (UIColor *)al_navigationBarColor
{
    return objc_getAssociatedObject(self, &ALNavigationBarBgColorKey);
}

- (void)setAl_navigationBarColor:(UIColor *)al_navigationBarColor
{
    objc_setAssociatedObject(self, &ALNavigationBarBgColorKey, al_navigationBarColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self al_setBarBackgroundColor:al_navigationBarColor];
}

// show status bar
- (BOOL)al_isShowStatusBar
{
    return [UIApplication sharedApplication].statusBarHidden;
}


- (void)setAl_navigationBarStyle:(ALNavigationBarMoveStyle)al_navigationBarStyle
{
    if (al_navigationBarStyle == ALNavigationBarDefault) {
        [self al_hideNavigationBar:0];
    }
    objc_setAssociatedObject(self, &ALNavigationBarStyleKey, @(al_navigationBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ALNavigationBarMoveStyle)al_navigationBarStyle
{
    return [objc_getAssociatedObject(self, &ALNavigationBarStyleKey) integerValue];
}

- (void)setAl_maxOffsetY:(CGFloat)al_maxOffsetY
{
    objc_setAssociatedObject(self, &ALScrollingMaxOffsetYKey, @(al_maxOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)al_maxOffsetY
{
    CGFloat maxOffsetY = [objc_getAssociatedObject(self, &ALScrollingMaxOffsetYKey) floatValue];
    if (maxOffsetY <= 0) {
        maxOffsetY = ALNavigationScrollingMaxOffsetY;
    }
    return maxOffsetY;
}

// MARK: Private Property
- (void)setAl_lastOffsetY:(CGFloat)al_lastOffsetY
{
    objc_setAssociatedObject(self, &ALLastOffsetYKey, @(al_lastOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)al_lastOffsetY
{
    return [objc_getAssociatedObject(self, &ALLastOffsetYKey) floatValue];
}

- (void)setAl_barView:(UIView *)al_barView
{
    objc_setAssociatedObject(self, &ALNavigationBarViewKey, al_barView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)al_barView
{
    return objc_getAssociatedObject(self, &ALNavigationBarViewKey);
}

// 滑动方向
- (void)setAl_scrollingDirection:(ALNavigationBarScrollingDirection)al_scrollingDirection
{
    objc_setAssociatedObject(self, &ALScrollingDirectionKey, @(al_scrollingDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ALNavigationBarScrollingDirection)al_scrollingDirection
{
    return [objc_getAssociatedObject(self, &ALScrollingDirectionKey) integerValue];
}

- (void)setAl_progress:(CGFloat)al_progress
{
    objc_setAssociatedObject(self, &ALNavigationBarProgressKey, @(al_progress), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)al_progress
{
    return [objc_getAssociatedObject(self, &ALNavigationBarProgressKey) doubleValue];
}

@end
