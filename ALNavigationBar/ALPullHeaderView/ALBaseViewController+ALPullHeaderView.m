//
//  ALBaseViewController+ALPullHeaderView.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseViewController+ALPullHeaderView.h"
#import <objc/runtime.h>
#import "ALPullHeaderView.h"
#import "UINavigationBar+ALScrolling.h"

@interface ALViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) ALPullHeaderView *headerView;

@end

@implementation ALViewController (ALPullHeaderView)

// MARK: - View Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // reset navigation bar
    [self.navigationController.navigationBar al_resetNavigationBar];
}

// MARK: - Publick Method
- (void)configHeaderView:(UITableView *)tableView
{
    tableView.tableHeaderView = self.headerView;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)configHeaderImageUrl:(NSString *)imageurl
{
    self.headerView.imageUrl = imageurl;
}

- (void)configHeaderImage:(UIImage *)image
{
    self.headerView.image = image;
}

// MARK: - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    // set header view frame
    self.headerView.contentOffset = offset;
    
    // set navigation bar translatioin
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.navigationController.navigationBar al_setBarTranslationWithOffsetY:offsetY];
}

#pragma mark - Get Method
- (ALPullHeaderView *)headerView
{
    ALPullHeaderView *headerView = objc_getAssociatedObject(self, _cmd);
    if (!headerView) {
        headerView = [[ALPullHeaderView alloc] init];
        objc_setAssociatedObject(self, _cmd, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return headerView;
}

@end
