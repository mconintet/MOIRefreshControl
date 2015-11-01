//
//  MOIRefreshControl.m
//  MOIRefreshControlDemo
//
//  Created by mconintet on 10/20/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import "MOIRefreshControl.h"
#import "macros.h"

@interface MOIRefreshControl ()
@property (nonatomic) CGFloat originY;
@property (nonatomic, assign) CGFloat scrollViewOrginOffsetY;
@property (nonatomic, assign) CGFloat scrollCriticalOffsetY;
@end

@implementation MOIRefreshControl

- initWithSubView:(UIView*)subView
     inScrollView:(UIScrollView*)scrollView
{
    self = [super init];
    if (self) {
        _subView = subView;
        _scrollView = scrollView;
        _refreshState = MOIRefreshControlStateNone;

        [self addSubview:_subView];
        [_scrollView addSubview:self];

        _scrollView.delegate = self;
        self.alpha = 0;
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    if (_originY == 0 && scrollView.contentOffset.y <= 0) {
        DLOG(@"begin");
        _refreshState = MOIRefreshControlStateBegin;

        _scrollViewOrginOffsetY = scrollView.contentOffset.y;
        _originY = -self.subView.frame.size.height;
        _scrollCriticalOffsetY = _scrollViewOrginOffsetY + _originY;

        CGRect frame = self.frame;
        frame.size.width = _scrollView.frame.size.width;
        frame.size.height = _subView.frame.size.height;
        frame.origin.y = _originY;
        self.frame = frame;

        [self centerSubView];

        [UIView transitionWithView:self
                          duration:0.3
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^(void) {
                            self.alpha = 1;
                        }
                        completion:nil];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView
{
    if (_refreshState == MOIRefreshControlStateNeedRefresh) {
        _refreshState = MOIRefreshControlStateRefreshing;
        [scrollView setContentOffset:CGPointMake(0, _scrollCriticalOffsetY) animated:YES];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    else if (_refreshState == MOIRefreshControlStateRefreshing) {
        [scrollView setContentOffset:CGPointMake(0, _scrollCriticalOffsetY) animated:YES];
    }
    else if (_refreshState == MOIRefreshControlStateBegin) {
        _refreshState = MOIRefreshControlStateNone;
        _originY = 0;
        [UIView transitionWithView:self
                          duration:0.3
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^(void) {
                            self.alpha = 0;
                        }
                        completion:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if (_scrollCriticalOffsetY == 0 || _refreshState == MOIRefreshControlStateNone) {
        return;
    }

    if (scrollView.contentOffset.y <= _scrollCriticalOffsetY) {
        CGRect frame = self.frame;
        frame.origin.y = _originY - ABS(_scrollCriticalOffsetY - scrollView.contentOffset.y);
        self.frame = frame;

        if (_refreshState == MOIRefreshControlStateBegin) {
            _refreshState = MOIRefreshControlStateNeedRefresh;
        }
    }
    else if (scrollView.contentOffset.y == _scrollViewOrginOffsetY) {
        [UIView transitionWithView:self
                          duration:0.3
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^(void) {
                            self.alpha = 0;
                        }
                        completion:nil];
    }
}

- (void)endRefreshingWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion
{
    DLOG(@"endRefreshing");
    DLOG(@"_scrollViewOrginOffsetY %f", _scrollViewOrginOffsetY);

    [UIView transitionWithView:_scrollView
        duration:duration
        options:UIViewAnimationOptionCurveEaseOut
        animations:^(void) {
            _scrollView.contentOffset = CGPointMake(0, _scrollViewOrginOffsetY);
        }
        completion:^void(BOOL finished) {
            if (finished) {
                _originY = 0;
                _refreshState = MOIRefreshControlStateNone;
                if (completion) {
                    completion();
                }
            }
        }];
}

- (void)centerSubView
{
    _subView.center = CGPointMake(self.frame.size.width / 2,
        self.frame.size.height / 2);
}
@end
