//
//  GXKRefreshFooterView.m
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GXKRefreshFooterView.h"

@implementation GXKRefreshFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/**/
#pragma mark - 类构造方法
+ (id)refreshFooterView
{
    return [self refreshView];
}

#pragma mark - 重写父类中需要的方法
- (void)updateFrame
{
    CGFloat selfX = 0;
    CGFloat selfY = self.scrollView.contentSize.height;
    CGFloat selfW = self.scrollView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    
    self.backgroundColor = [UIColor cyanColor];
}
- (void)changeStateRegular
{
    if (self.scrollView.isDragging){
        
        CGFloat maxY  = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
        CGFloat footerViewHeight = self.frame.size.height;
        
        if (self.scrollView.contentOffset.y >= maxY && self.scrollView.contentOffset.y < maxY + footerViewHeight)
        {
            [self setState:GXKRefreshStateBeginDrag];
        }
        else if(self.scrollView.contentOffset.y > maxY + footerViewHeight)
        {
            [self setState:GXKRefreshStateDraging];
        }
        
        
    }//end  if (self.scrollView.isDragging)
    else
    {
        if (self.state == GXKRefreshStateDraging)
        {
            [self setState:GXKRefreshStateLoading];
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
             
        }
        
    }//end else
}
- (void)stateSeted
{
    NSLog(@"stateSeted header");
    
    if([self.delegate respondsToSelector:@selector(refreshFooter:state:)])
    {
        NSLog(@"stateSeted header--------------");
        [self.delegate refreshFooter:self state:self.state];
    }
    
}

@end
