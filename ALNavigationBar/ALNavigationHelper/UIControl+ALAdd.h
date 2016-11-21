//
//  UIControl+ALAdd.h
//  ReactiveCocoaTest
//
//  Created by Alan on 2016/11/3.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ALAdd)

- (void)al_addBlockForEvent:(UIControlEvents)controlEvent block:(void (^)(id sender))block;

@end
