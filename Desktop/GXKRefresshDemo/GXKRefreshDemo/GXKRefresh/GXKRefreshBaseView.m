//
//  GXKRefreshBaseView.m
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GXKRefreshBaseView.h"
#import "GXKRefreshHeaderView.h"

@interface GXKRefreshBaseView ()
{
    NSString * _beginDragText;
    NSString * _draggingText;
    NSString * _loadingText;
    
}
//@property (nonatomic,assign) UIButton * alertButtonView;
//@property (nonatomic,assign) UIView * _loadingView;


@end
@implementation GXKRefreshBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)refreshView
{
    GXKRefreshBaseView * baseView = [[self alloc] initWithFrame:CGRectZero];
    return baseView;
}

#pragma mark - setter and getter

- (void)setScrollView:(UIScrollView *)scrollView
{
    //NSLog(@"%@",NSStringFromSelector(_cmd));
    //1.移除旧的KVO
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //2.保存成员变量
    _scrollView = scrollView;
    //3.添加新的监听
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    //    [_scrollView addSubview:self];
    
}

- (UIView *)loadingView
{
    if (_loadingView == nil)
    {
        //1.
        UIView * loadingView = [UIView new];//[[UIView alloc] init];
        //2.
        [self addSubview:loadingView];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
        
        
        //创建子控件
        UILabel * labelTitle = [UILabel new];
        [loadingView addSubview:labelTitle];
        labelTitle.text = @"adsad";//_loadingText;//@"正在读取";
        labelTitle.frame = loadingView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView addSubview:activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
        
        
    }
    
    return _loadingView;
}

- (UIButton *)alertButtonView
{
    if (_alertButtonView == nil)
    {
        //1.创建对象
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //2.建立父子关系
        [self addSubview:btn];
        //3.Frame
        btn.frame = self.bounds;
        //4.保存成员变量值
        self.alertButtonView = btn;
        //5.其他属性设置
        
        //        [btn setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        
        
    }
    return _alertButtonView;
}
#pragma mark - KVO的回掉方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if(self.state == GXKRefreshStateLoading) return;
    
    [self updateFrame];
    [self changeStateRegular];
    
    
}
- (void)changeStateRegular
{
    NSLog(@"changeStateRegular Method Must Implements By SubClass！");
}
#pragma mark - 设置视图文本文字的方法
- (void)setState:(GXKRefreshState)state
{
    _state = state;
    
    switch (state) {
            
        case GXKRefreshStateBeginDrag:
            
            [self.alertButtonView setTitle:[self titleWithStatus:state] forState:UIControlStateNormal];
            break;
        case GXKRefreshStateDraging:
            //            NSLog(@"松开读取更多");
            [self.alertButtonView setTitle:[self titleWithStatus:state]  forState:UIControlStateNormal];
            break;
        case GXKRefreshStateLoading:
            self.alertButtonView.hidden = YES;
            self.loadingView;
            break;
            
        default:
            break;
    }
    [self stateSeted];
}
- (void)stateSeted
{
    NSLog(@"stateSeted Method Must Implements By SubClass！");
}
- (void)setTitle:(NSString *)title forState:(GXKRefreshState)state
{
    switch (state) {
            
        case GXKRefreshStateBeginDrag:
            _beginDragText = title;
            break;
        case GXKRefreshStateDraging:
            _draggingText = title;
            break;
        case GXKRefreshStateLoading:
            _loadingText = title;
            break;
            
        default:
            break;
    }
    
}

- (NSString *)titleWithStatus:(GXKRefreshState)state
{
    NSString * title = nil;
    
    switch (state) {
            
        case GXKRefreshStateBeginDrag:
            title = _beginDragText?_beginDragText:@"拖拽";
            break;
        case GXKRefreshStateDraging:
            title = _draggingText?_draggingText:@"松开";
            break;
        case GXKRefreshStateLoading:
            title = _loadingText?_loadingText:@"加载";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (void)endRefreshing
{
    NSLog(@"endRefreshing");
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0,0);
    [self clear];
}
- (void)clear
{
    [self.alertButtonView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.state = GXKRefreshStateBeginDrag;
}


- (void)updateFrame
{
    //由子类实现
    NSLog(@"updateFrame Method Must Implements By SubClass！");
//    if(self.scrollView != nil)
//    {
//        CGFloat selfX = 0;
//        CGFloat selfY = -60;
//        CGFloat selfW = self.scrollView.frame.size.width;
//        CGFloat selfH = 60;
//        
//        self.frame = CGRectMake(selfX, selfY, selfW, selfH);
//        
//        
//        self.backgroundColor = [UIColor purpleColor];
//    }
}

#pragma mark - 被加到父视图时要做的事
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"headerView已经被添加到UISCrollView!");
    UITableView * tableView = (UITableView *)newSuperview;
    self.scrollView = tableView;
    
    //updateFrame交给子类来实现
    [self updateFrame];
}
- (void)didMoveToSuperview
{
    self.scrollView = (UIScrollView *)self.superview;
}

#pragma mark - 析构函数
- (void)dealloc
{
    //添加KVO必须要移除，否则还会继续监听，就会报错
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
