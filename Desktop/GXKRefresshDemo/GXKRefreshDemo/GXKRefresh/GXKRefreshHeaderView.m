//
//  GXKRefreshHeaderView.m
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GXKRefreshHeaderView.h"

@implementation GXKRefreshHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/**/

#pragma mark - 类构造方法

+ (id)refreshHeaderView
{
    return [self refreshView];
}

#pragma mark - 实现父类中需要的方法
- (void)updateFrame
{
    if(self.scrollView != nil)
    {
        CGFloat selfX = 0;
        CGFloat selfY = -60;
        CGFloat selfW = self.scrollView.frame.size.width;
        CGFloat selfH = 60;
        
        self.frame = CGRectMake(selfX, selfY, selfW, selfH);
        
        
        self.backgroundColor = [UIColor purpleColor];
    }
}

- (void)changeStateRegular
{
    if (self.scrollView.isDragging){
        
        //NSLog(@"%lf",self.scrollView.contentOffset.y);
        //if (_scrollView.contentOffset.y >= maxY && _scrollView.contentOffset.y < maxY + footerViewHeight)
        if (self.scrollView.contentOffset.y < 0 && self.scrollView.contentOffset.y > -60)
        {
            //NSLog(@"GXKRefreshStateBeginDrag");
            [self setState:GXKRefreshStateBeginDrag];
        }
        else if(self.scrollView.contentOffset.y < -60)
        {
            //NSLog(@"GXKRefreshStateDraging");
            [self setState:GXKRefreshStateDraging];
        }
        
        
    }//end  if (self.scrollView.isDragging)
    else
    {
        if (self.state == GXKRefreshStateDraging)
        {
            [self setState:GXKRefreshStateLoading];
            self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            
        }
        
    }//end else
}

- (void)stateSeted
{
    NSLog(@"stateSeted header");
    if ([self.delegate respondsToSelector:@selector(refreshHeader:state:)]) {
        [self.delegate refreshHeader:self state:self.state];
    }
    
}

//- (void)willMoveToSuperview:(UIView *)newSuperview
//{
//    NSLog(@"headerView已经被添加到UISCrollView!");
//    UITableView * tableView = (UITableView *)newSuperview;
//    self.scrollView = tableView;
//    [self updateFrame];
//}
//- (void)didMoveToSuperview
//{
//    self.scrollView = (UIScrollView *)self.superview;
//}




//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if(self = [super initWithFrame:frame])
//    {
//        
//    }
//    return self;
//}




//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    
//    if(self.state == GXKRefreshStateLoading) return;
//    
//    [self updateFrame];
//    
//    if (self.scrollView.isDragging){
//        
//        CGFloat maxY  = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
//        CGFloat footerViewHeight = self.frame.size.height;
//        
//        NSLog(@"%lf",self.scrollView.contentOffset.y);
//        //if (_scrollView.contentOffset.y >= maxY && _scrollView.contentOffset.y < maxY + footerViewHeight)
//        if (self.scrollView.contentOffset.y < 0 && self.scrollView.contentOffset.y > -60)
//        {
//            NSLog(@"GXKRefreshStateBeginDrag");
//            [self setState:GXKRefreshStateBeginDrag];
//        }
//        else if(self.scrollView.contentOffset.y < -60)
//        {
//            NSLog(@"GXKRefreshStateDraging");
//            [self setState:GXKRefreshStateDraging];
//        }
//        
//        
//    }//end  if (self.scrollView.isDragging)
//    else
//    {
//        if (self.state == GXKRefreshStateDraging)
//        {
//            [self setState:GXKRefreshStateLoading];
//            self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
//            
//            //[_delegate footerViewStatus:self status:GPFooterViewStatusLoading];
//        }
//        
//    }//end else
//}


@end
