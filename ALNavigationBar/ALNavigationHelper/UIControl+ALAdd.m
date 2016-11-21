//
//  UIControl+ALAdd.m
//  ReactiveCocoaTest
//
//  Created by Alan on 2016/11/3.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "UIControl+ALAdd.h"
#import <objc/runtime.h>

static const char KALAddControlEventsKey;

@interface ALUIControlBlockTarget : NSObject

@property (nonatomic, copy) void(^controlBlock)(id sender);
@property (nonatomic, assign) UIControlEvents controlEvent;

@end

@implementation ALUIControlBlockTarget

- (instancetype)initWithEvent:(UIControlEvents)event block:(void(^)(id sender))block
{
    if (self) {
        self.controlEvent = event;
        self.controlBlock = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender
{
    if (_controlBlock) _controlBlock(sender);
}

@end

@implementation UIControl (ALAdd)

- (void)al_addBlockForEvent:(UIControlEvents)controlEvent block:(void (^)(id sender))block
{
    if (!controlEvent) return;
    
    NSMutableSet *events = objc_getAssociatedObject(self, &KALAddControlEventsKey);
    if (!events) {
        events = [NSMutableSet set];
        objc_setAssociatedObject(self, &KALAddControlEventsKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    ALUIControlBlockTarget *target = [[ALUIControlBlockTarget alloc] initWithEvent:controlEvent block:block];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvent];
    
    [events addObject:target];
}

@end
