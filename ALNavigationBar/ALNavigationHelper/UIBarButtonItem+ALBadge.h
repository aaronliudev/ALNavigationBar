//
//  UIBarButtonItem+ALBadge.h
//  ALNavigationTest
//
//  Created by Alan on 2016/11/19.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ALBadge)

@property (nonatomic, strong, readonly) UILabel *al_badgeLabel;

/// when badgeValue is nil or @"", the badgeLabel is hidden
@property (nonatomic, copy) NSString *al_badgeValue;
/// default is white
@property (nonatomic, strong) UIColor *al_badgeTextColor;
/// default is red
@property (nonatomic, strong) UIColor *al_badgeBgColor;
/// default is 12
@property (nonatomic, strong) UIFont *al_badgeTextFont;

/// lable's frame 
@property (nonatomic, assign) CGFloat al_originX;
@property (nonatomic, assign) CGFloat al_originY;
@property (nonatomic, assign) CGFloat al_padding;
/// (badgeLable.height + padding) / 2;
@property (nonatomic, assign) CGFloat al_cornerRadius;
@property (nonatomic, assign) CGFloat al_minSize;

/// default is YES, when the value is changed
@property (nonatomic, assign) BOOL al_isShowAnimate;

@end
