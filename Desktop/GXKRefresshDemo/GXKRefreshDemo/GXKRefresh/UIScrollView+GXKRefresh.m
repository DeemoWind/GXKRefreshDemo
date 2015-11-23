//
//  UIScrollView+GXKRefresh.m
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIScrollView+GXKRefresh.h"
#import "GXKRefreshBaseView.h"
#import "GXKRefreshHeaderView.h"
#import "GXKRefreshFooterView.h"

#import "objc/runtime.h"

@interface UIScrollView()<GXKRefreshDelegate>

@property (nonatomic, weak) GXKRefreshHeaderView * refreshHeaderView;
@property (nonatomic, weak) GXKRefreshFooterView * refreshFooterView;

@end

@implementation UIScrollView (GXKRefresh)

#pragma mark - 关联属性
static char GXKRefreshHeaderViewKey;
static char GXKRefreshFooterViewKey;

#pragma mark - setter and getter
- (void)setRefreshHeaderView:(GXKRefreshHeaderView *)headerView
{
    [self willChangeValueForKey:@"GXKRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &GXKRefreshHeaderViewKey, headerView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GXKRefreshHeaderViewKey"];
}
- (GXKRefreshHeaderView *)refreshHeaderView
{
    return objc_getAssociatedObject(self, &GXKRefreshHeaderViewKey);
}
- (void)setRefreshFooterView:(GXKRefreshFooterView *)footerView
{
    [self willChangeValueForKey:@"GXKRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &GXKRefreshFooterViewKey, footerView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GXKRefreshFooterViewKey"];
}
- (GXKRefreshFooterView *)refreshFooterView
{
    return objc_getAssociatedObject(self, &GXKRefreshFooterViewKey);
}

#pragma mark - 扩展的函数
- (void)addGXKRefreshHeader
{
    if(self.refreshHeaderView == nil)
    {
        GXKRefreshHeaderView * headerView = [GXKRefreshHeaderView refreshHeaderView];
        [self addSubview:headerView];
        //headerView.delegate = self;
        
        self.refreshHeaderView = headerView;
    }
    
}

- (void)addGXKRefreshFooter
{
    if(self.refreshFooterView == nil)
    {
        GXKRefreshFooterView * footerView = [GXKRefreshFooterView refreshFooterView];
        [self addSubview:footerView];
        
        //footerView.delegate = self;
        
        self.refreshFooterView = footerView;
    }
    
}

- (void)endRefreshingGXKRefreshFooter
{
    [self.refreshFooterView endRefreshing];
}
- (void)endRefreshingGXKRefreshHeader
{
    [self.refreshHeaderView endRefreshing];
}
@end
