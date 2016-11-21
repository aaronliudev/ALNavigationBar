//
//  UIBarButtonItem+ALBadge.m
//  ALNavigationTest
//
//  Created by Alan on 2016/11/19.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "UIBarButtonItem+ALBadge.h"
#import <objc/runtime.h>

static char ALBadgeLabelKey;
static char ALBadgeLabelValueKey;
static char ALBadgeLabelTextColorKey;
static char ALBadgeLabelBgColorKey;
static char ALBadgeLabelTextFontKey;
static char ALBadgeLabelOriginXKey;
static char ALBadgeLabelOriginYKey;
static char ALBadgeLabelPadingKey;
static char ALBadgeLabelCornerRadiusKey;
static char ALBadgeLabelMinSizeKey;
static char ALBadgeLabelShowAnimateKey;


@implementation UIBarButtonItem (ALBadge)

- (void)labelInit
{
    UIView *superView = self.customView;
    CGFloat originX = 0;
    if (superView) {
        originX = CGRectGetWidth(superView.frame) - (CGRectGetWidth(self.al_badgeLabel.frame) / 3);
        superView.clipsToBounds = NO;
    }
    else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superView = [(id)self view];
        originX = CGRectGetWidth(superView.frame) - CGRectGetWidth(self.al_badgeLabel.frame);
    }
    // add badgeLabel
    [superView addSubview:self.al_badgeLabel];
    // config default values
    [self.customView addSubview:self.al_badgeLabel];
    self.al_badgeTextFont = [UIFont systemFontOfSize:12];
    self.al_badgeBgColor = [UIColor redColor];
    self.al_badgeTextColor = [UIColor whiteColor];
    self.al_originX = originX;
    self.al_originY = -4;
    self.al_padding = 6;
    self.al_minSize = 8;
    self.al_isShowAnimate = YES;
}

//
- (void)refreshBadgeLabel
{
    self.al_badgeLabel.font = self.al_badgeTextFont;
    
    if (!self.al_badgeValue ||
        [self.al_badgeValue isEqualToString:@""] ||
        [self.al_badgeValue isEqualToString:@"0"]) {
        self.al_badgeLabel.hidden = YES;
    }
    else {
        self.al_badgeLabel.hidden = NO;
        [self updateBadgeValue];
    }
}

- (void)updateBadgeValue
{
    BOOL textChanged = NO;
    if (![self.al_badgeValue isEqualToString:self.al_badgeLabel.text]) {
        textChanged = YES;
    }
    self.al_badgeLabel.text = self.al_badgeValue;
    [self updateBadgeFrame];
    
    if (self.al_isShowAnimate && textChanged) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.al_badgeLabel.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
}

- (void)updateBadgeFrame
{
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.al_minSize) ? self.al_minSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.al_padding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.al_badgeLabel.layer.masksToBounds = YES;
    self.al_badgeLabel.frame = CGRectMake(self.al_originX, self.al_originY, minWidth + padding, minHeight + padding);
    
    CGFloat cornerRadius = self.al_cornerRadius;
    if (cornerRadius <= 0) {
        cornerRadius = (minHeight + padding) / 2;
    }
    self.al_badgeLabel.layer.cornerRadius = cornerRadius;
}

- (CGSize) badgeExpectedSize
{
    UILabel *frameLabel = [self duplicateLabel:self.al_badgeLabel];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

// MARK: - Get & Set Method
- (UILabel *)al_badgeLabel
{
    UILabel *badgeLabel = objc_getAssociatedObject(self, &ALBadgeLabelKey);
    if (!badgeLabel) {
        badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        [self setAl_badgeLabel:badgeLabel];
        
        [self labelInit];
    }
    return badgeLabel;
}

- (void)setAl_badgeLabel:(UILabel *)al_badgeLabel
{
    objc_setAssociatedObject(self, &ALBadgeLabelKey, al_badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)al_badgeValue
{
    return objc_getAssociatedObject(self, &ALBadgeLabelValueKey);
}

- (void)setAl_badgeValue:(NSString *)al_badgeValue
{
    objc_setAssociatedObject(self, &ALBadgeLabelValueKey, al_badgeValue, OBJC_ASSOCIATION_COPY);
    if (self.al_badgeLabel) {
        [self refreshBadgeLabel];
    }
}

- (UIColor *)al_badgeTextColor
{
    return objc_getAssociatedObject(self, &ALBadgeLabelTextColorKey);
}
- (void)setAl_badgeTextColor:(UIColor *)al_badgeTextColor
{
    objc_setAssociatedObject(self, &ALBadgeLabelTextColorKey, al_badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        self.al_badgeLabel.textColor = al_badgeTextColor;
    }
}

- (UIColor *)al_badgeBgColor
{
    return objc_getAssociatedObject(self, &ALBadgeLabelBgColorKey);
}
- (void)setAl_badgeBgColor:(UIColor *)al_badgeBgColor
{
    objc_setAssociatedObject(self, &ALBadgeLabelBgColorKey, al_badgeBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        self.al_badgeLabel.backgroundColor = al_badgeBgColor;
    }
}

- (UIFont *)al_badgeTextFont
{
    return objc_getAssociatedObject(self, &ALBadgeLabelTextFontKey);
}
- (void)setAl_badgeTextFont:(UIFont *)al_badgeTextFont
{
    objc_setAssociatedObject(self, &ALBadgeLabelTextFontKey, al_badgeTextFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        [self refreshBadgeLabel];
    }
}

- (CGFloat)al_originX
{
    NSNumber *numberX = objc_getAssociatedObject(self, &ALBadgeLabelOriginXKey);
    return [numberX floatValue];
}
- (void)setAl_originX:(CGFloat)al_originX
{
    objc_setAssociatedObject(self, &ALBadgeLabelOriginXKey, @(al_originX), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        [self updateBadgeFrame];
    }
}

- (CGFloat)al_originY
{
    NSNumber *numberY = objc_getAssociatedObject(self, &ALBadgeLabelOriginYKey);
    return [numberY floatValue];
}
- (void)setAl_originY:(CGFloat)al_originY
{
    objc_setAssociatedObject(self, &ALBadgeLabelOriginYKey, @(al_originY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        [self updateBadgeFrame];
    }
}

- (CGFloat)al_padding
{
    NSNumber *numberPading = objc_getAssociatedObject(self, &ALBadgeLabelPadingKey);
    return [numberPading floatValue];
}
- (void)setAl_padding:(CGFloat)al_padding
{
    objc_setAssociatedObject(self, &ALBadgeLabelPadingKey, @(al_padding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        [self updateBadgeFrame];
    }
}

- (CGFloat)al_cornerRadius
{
    NSNumber *numberCR = objc_getAssociatedObject(self, &ALBadgeLabelCornerRadiusKey);
    return [numberCR floatValue];
}
- (void)setAl_cornerRadius:(CGFloat)al_cornerRadius
{
    objc_setAssociatedObject(self, &ALBadgeLabelCornerRadiusKey, @(al_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        [self refreshBadgeLabel];
    }
}

- (CGFloat)al_minSize
{
    NSNumber *numberCR = objc_getAssociatedObject(self, &ALBadgeLabelMinSizeKey);
    return [numberCR floatValue];
}
- (void)setAl_minSize:(CGFloat)al_minSize
{
    objc_setAssociatedObject(self, &ALBadgeLabelMinSizeKey, @(al_minSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.al_badgeLabel) {
        [self refreshBadgeLabel];
    }
}

- (BOOL)al_isShowAnimate
{
    NSNumber *numberCR = objc_getAssociatedObject(self, &ALBadgeLabelShowAnimateKey);
    return [numberCR boolValue];
}
- (void)setAl_isShowAnimate:(BOOL)al_isShowAnimate
{
    objc_setAssociatedObject(self, &ALBadgeLabelShowAnimateKey, @(al_isShowAnimate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
