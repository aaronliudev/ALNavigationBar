//
//  ALPullHeaderView.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALPullHeaderView : UIView

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;
/// tableview content offset
@property (nonatomic, assign) CGPoint contentOffset;

@end
