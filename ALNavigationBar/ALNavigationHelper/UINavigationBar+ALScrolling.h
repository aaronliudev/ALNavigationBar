//
//  UINavigationBar+ALScrolling.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

/** status bar
 *  hidden
    info.plist add `View controller-based status bar appearance` and set YES，the status bar text color is black, NO is white
    if set YES，`[UIApplication sharedApplication].statusBarHidden` will become invalid.
    info.plist add "Status bar is initially hidden" and set YES，LunchScreen not show the status bar，and if set "controller-based status bar appearance" is NO，the status bar will not show at all.
 
 *  text color
    `[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];`
    UIStatusBarStyleLightContent is white and default is black.
 
 *  backgroundColor
    add a view and frame = (0, 0, Screen_Width, 20)
 */

typedef NS_ENUM(NSUInteger, ALNavigationBarMoveStyle) {
    ALNavigationBarDefault  = 1,     // like QQ Zone. the navigationBar default is hidden, can set max offsetY to show navigationBar. at `viewWillAppear:` must call `scrollViewDidScroll:` to set navigationBar status.
    ALNavigationBarScrolling,        // scrolling to show or hide.
};

@interface UINavigationBar (ALScrolling)

/// navigationBar background color, default is nil, and the color is BarTintColor. if use this method must be called in `viewWillDisappear:`
@property (nonatomic, strong) UIColor *al_navigationBarColor;

/// the navigationBar style
@property (nonatomic, assign) ALNavigationBarMoveStyle al_navigationBarStyle;

/// only used if the style is default. default value is 200.0f
@property (nonatomic, assign) CGFloat al_maxOffsetY;

/**
 * if the offsetY changed, the navigationBar will move
 */
- (void)al_setBarTranslationWithOffsetY:(CGFloat)offsetY;

/**
 @discussion reset navigationBar
 */
- (void)al_resetNavigationBar;

@end
