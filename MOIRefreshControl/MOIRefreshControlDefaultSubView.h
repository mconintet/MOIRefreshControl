//
//  MOIRefreshControlDefaultSubView.h
//  MOIRefreshControlDemo
//
//  Created by mconintet on 10/20/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOIRefreshControl.h"

@interface MOIRefreshControlDefaultSubView : UIView

@property (nonatomic, strong) UITextView* textLabel;
@property (nonatomic, weak) MOIRefreshControl* refreshCtrl;
@property (nonatomic, strong) UIActivityIndicatorView* loadingView;

- initWithFont:(UIFont*)font label:(NSString*)label;

- (void)setLabel:(NSString*)label;
- (void)setLabel:(NSString*)label withColor:(UIColor*)color;
@end
