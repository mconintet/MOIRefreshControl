##About

Custom refresh control in Object-C for iOS.

## Usage

```objc
- (void)viewDidLoad{
	// Use MOIRefreshControlDefaultSubView
    MOIRefreshControlDefaultSubView* view = [[MOIRefreshControlDefaultSubView alloc]
        initWithFont:[UIFont systemFontOfSize:14]
               label:@"load more"];
                                                 
	// Create and setup
    _refreshCtrl = [[MOIRefreshControl alloc] initWithSubView:view
                                                 inScrollView:_tbv];  
    [_refreshCtrl addTarget:self
                     action:@selector(refreshing:)
           forControlEvents:UIControlEventValueChanged]; 
}

// refreshing
- (void)refreshing:(id)sender
{
	__block MOIRefreshControl* refreshCtrl = (MOIRefreshControl*)sender;
    MOIRefreshControlDefaultSubView* view = (MOIRefreshControlDefaultSubView*)refreshCtrl.subView;
    [view setLabel:@"loading..."];
    [view.loadingView startAnimating];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC),
        dispatch_get_main_queue(), ^(void) {
            
            // do some real refreshing work
            
            [view.loadingView stopAnimating];
            [refreshCtrl endRefreshingWithDuration:0.3
                                        completion:^(void) {
                                            [_tbv reloadData];
                                            [view setLabel:@"load more"];
                                        }];
        });
}                                                                                    
```

## Screenshot

![](https://raw.githubusercontent.com/mconintet/MOIRefreshControl/master/screenshot.gif)

## Installation

```
// in your pod file
pod 'MOIRefreshControl', :git => 'https://github.com/mconintet/MOIRefreshControl.git'
```

```
// command line
pod install
```
