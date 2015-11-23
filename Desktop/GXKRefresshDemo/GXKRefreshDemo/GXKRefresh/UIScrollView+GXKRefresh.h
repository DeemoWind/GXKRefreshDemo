//
//  UIScrollView+GXKRefresh.h
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXKRefreshFooterView,GXKRefreshHeaderView,GXKRefreshBaseView;
@interface UIScrollView (GXKRefresh)

- (void)addGXKRefreshHeader;
- (void)addGXKRefreshFooter;
- (void)endRefreshingGXKRefreshHeader;
- (void)endRefreshingGXKRefreshFooter;
- (GXKRefreshHeaderView *)refreshHeaderView;
- (GXKRefreshFooterView *)refreshFooterView;
@end
