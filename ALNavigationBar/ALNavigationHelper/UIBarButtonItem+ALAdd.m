//
//  UIBarButtonItem+ALAdd.m
//  ReactiveCocoaTest
//
//  Created by Alan on 2016/11/2.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "UIBarButtonItem+ALAdd.h"
#import "UIControl+ALAdd.h"

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define kDefaultNavigationBarHeight 30

@implementation UIBarButtonItem (ALAdd)

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)target selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customLeftImageButton];
    [button setImage:[UIImage imageNamed:@"navigationbar_back_icon.png"] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)backBarButtonItemWithBlock:(void(^)())block
{
    UIButton *button = [UIBarButtonItem customLeftImageButton];
    [button setImage:[UIImage imageNamed:@"navigationbar_back_icon.png"] forState:UIControlStateNormal];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customLeftTextButton];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title block:(ALUIBarButtonBlock)block
{
    UIButton *button = [UIBarButtonItem customLeftTextButton];
    [button setTitle:title forState:UIControlStateNormal];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customRightTextButton];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title block:(ALUIBarButtonBlock)block
{
    UIButton *button = [UIBarButtonItem customRightTextButton];
    [button setTitle:title forState:UIControlStateNormal];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}


+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                               highlightedImageName:(NSString *)highlightedImageName
                                             target:(id)target
                                           selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customLeftImageButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                               highlightedImageName:(NSString *)highlightedImageName
                                              block:(ALUIBarButtonBlock)block
{
    UIButton *button = [UIBarButtonItem customLeftImageButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                highlightedImageName:(NSString *)highlightedImageName
                                              target:(id)target
                                            selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customLeftRightImageButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                highlightedImageName:(NSString *)highlightedImageName
                                               block:(ALUIBarButtonBlock)block
{
    UIButton *button = [UIBarButtonItem customRightTextButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                                  selectedImageName:(NSString *)selectedImageName
                                             target:(id)target
                                           selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customLeftImageButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                                  selectedImageName:(NSString *)selectedImageName
                                              block:(ALUIBarButtonBlock)block
{
    UIButton *button = [UIBarButtonItem customLeftImageButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                   selectedImageName:(NSString *)selectedImageName
                                              target:(id)target
                                            selector:(SEL)selector
{
    UIButton *button = [UIBarButtonItem customRightTextButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                   selectedImageName:(NSString *)selectedImageName
                                               block:(ALUIBarButtonBlock)block
{
    UIButton *button = [UIBarButtonItem customRightTextButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button al_addBlockForEvent:UIControlEventTouchUpInside block:block];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIButton *)customLeftImageButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, kDefaultNavigationBarHeight);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -19, 0, 19)];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

+ (UIButton *)customLeftTextButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, kDefaultNavigationBarHeight);
    button.backgroundColor = [UIColor clearColor];
//    [button setTitleColor:HexRGB(0xf84c4b) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 14)];
    
    return button;
}

+ (UIButton *)customLeftRightImageButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, kDefaultNavigationBarHeight);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 19, 0, -19)];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

+ (UIButton *)customRightTextButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, kDefaultNavigationBarHeight);
    button.backgroundColor = [UIColor clearColor];
//    [button setTitleColor:HexRGB(0xf84c4b) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, -14)];
    
    return button;
}

@end
