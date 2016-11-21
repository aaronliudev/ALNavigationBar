//
//  UIBarButtonItem+ALAdd.h
//  ReactiveCocoaTest
//
//  Created by Alan on 2016/11/2.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ALUIBarButtonBlock)(id sender);

@interface UIBarButtonItem (ALAdd)

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)backBarButtonItemWithBlock:(void(^)())block;

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title block:(ALUIBarButtonBlock)block;

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title block:(ALUIBarButtonBlock)block;

+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                               highlightedImageName:(NSString *)highlightedImageName
                                             target:(id)target
                                           selector:(SEL)selector;
+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                               highlightedImageName:(NSString *)highlightedImageName
                                              block:(ALUIBarButtonBlock)block;


+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                highlightedImageName:(NSString *)highlightedImageName
                                              target:(id)target
                                            selector:(SEL)selector;
+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                highlightedImageName:(NSString *)highlightedImageName
                                               block:(ALUIBarButtonBlock)block;

+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                                  selectedImageName:(NSString *)selectedImageName
                                             target:(id)target
                                           selector:(SEL)selector;
+ (UIBarButtonItem *)leftBarButtonItemWithImageName:(NSString *)imageName
                                  selectedImageName:(NSString *)selectedImageName
                                              block:(ALUIBarButtonBlock)block;

+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                   selectedImageName:(NSString *)selectedImageName
                                              target:(id)target
                                            selector:(SEL)selector;
+ (UIBarButtonItem *)rightBarButtonItemWithImageName:(NSString *)imageName
                                   selectedImageName:(NSString *)selectedImageName
                                               block:(ALUIBarButtonBlock)block;
@end
