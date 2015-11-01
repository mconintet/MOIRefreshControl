//
//  MOIRefreshControlDefaultSubView.m
//  MOIRefreshControlDemo
//
//  Created by mconintet on 10/20/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import "MOIRefreshControlDefaultSubView.h"
#import "macros.h"

@implementation MOIRefreshControlDefaultSubView

- initWithFont:(UIFont*)font label:(NSString*)label
{
    self = [super init];
    if (self) {
        _loadingView = ({
            UIActivityIndicatorView* view = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            view.hidesWhenStopped = NO;
            CGRect frame = view.frame;
            frame.origin.y = 10;
            view.frame = frame;
            [self addSubview:view];
            view;
        });

        if (label != nil) {
            _textLabel = ({
                UITextView* view = [[UITextView alloc] init];
                view.font = font;
                view.scrollEnabled = NO;
                view.textAlignment = NSTextAlignmentCenter;
                view.textColor = [UIColor blackColor];
                [self addSubview:view];
                view;
            });
        }

        [self setLabel:label];
    }
    return self;
}

- (void)centerLoadingView
{
    _loadingView.center = CGPointMake(self.frame.size.width / 2, _loadingView.center.y);
}

- (void)setLabel:(NSString*)label
{
    _textLabel.text = label;

    CGFloat maxWidth = 0.6 * [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = _loadingView.frame.origin.y + _loadingView.frame.size.height;

    CGSize textSize = CGSizeZero;
    if (label != nil) {
        textSize = [_textLabel sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
        height += textSize.height;
    }
    else {
        height += 10;
    }

    CGRect frame = self.frame;
    frame.size.height = height;
    frame.size.width = maxWidth;
    self.frame = frame;

    frame = _textLabel.frame;
    frame.size = CGSizeMake(maxWidth, textSize.height);
    frame.origin.y = _loadingView.frame.origin.y + _loadingView.frame.size.height;
    _textLabel.frame = frame;

    [self centerLoadingView];
}

- (void)setLabel:(NSString*)label withColor:(UIColor*)color
{
    _textLabel.textColor = color;
    [self setLabel:label];
}

@end
