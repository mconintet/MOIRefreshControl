//
//  MOIRefreshControl.h
//  MOIRefreshControlDemo
//
//  Created by mconintet on 10/20/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MOIRefreshControlState) {
    MOIRefreshControlStateNone = 0,
    MOIRefreshControlStateBegin = 1,
    MOIRefreshControlStateNeedRefresh = 2,
    MOIRefreshControlStateRefreshing = 3
};

@interface MOIRefreshControl : UIControl <UIScrollViewDelegate>

@property (nonatomic, strong) UIView* subView;
@property (nonatomic, weak) UIScrollView* scrollView;
@property (nonatomic, readonly) MOIRefreshControlState refreshState;

- initWithSubView:(UIView*)subView
     inScrollView:(UIScrollView*)scrollView;

// you should call these mehtod if you set your own delegate on scroll view
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView;
- (void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView;
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

- (void)endRefreshingWithDuration:(NSTimeInterval)duration
                       completion:(void (^)(void))completion;

- (void)centerSubView;
@end
