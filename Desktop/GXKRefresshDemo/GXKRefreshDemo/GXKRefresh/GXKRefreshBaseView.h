//
//  GXKRefreshBaseView.h
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXKRefreshHeaderView,GXKRefreshFooterView;

typedef NS_ENUM(NSInteger, GXKRefreshState)
{
    GXKRefreshStateBeginDrag,
    GXKRefreshStateDraging,
    GXKRefreshStateLoading
};

@protocol  GXKRefreshDelegate<NSObject>

- (void)refreshFooter:(GXKRefreshFooterView *)footerView state:(GXKRefreshState)state;
- (void)refreshHeader:(GXKRefreshHeaderView *)headerView state:(GXKRefreshState)state;

@end

@protocol GXKRefreshSubClass <NSObject>

//子类必须实现的方法
- (void)updateFrame;
- (void)changeStateRegular;
- (void)stateSeted;

@end
//
@interface GXKRefreshBaseView : UIView <GXKRefreshSubClass>
{
    __weak UIScrollView * _scrollView;
    
    __weak UIButton * _alertButtonView;
    
    __weak UIView * _loadingView;
    
//    __weak UIScrollView * _scrollView;
//
    GXKRefreshState _state;
}

@property (nonatomic, assign) GXKRefreshState state;
@property (nonatomic, weak) UIButton * alertButtonView;
@property (nonatomic, weak) UIView * loadingView;
@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) id<GXKRefreshDelegate> delegate;

+ (id)refreshView;


- (void)endRefreshing;


@end
