//
//  ViewController2.m
//  MOIRefreshControlDemo
//
//  Created by mconintet on 10/20/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import "ViewController.h"
#import "MOIRefreshControl.h"
#import "MOIRefreshControlDefaultSubView.h"

@interface ViewController ()
@property (nonatomic, strong) UITableView* tbv;
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) MOIRefreshControl* refreshCtrl;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    _tbv = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tbv.dataSource = self;
    _tbv.delegate = self;
    [self.view addSubview:_tbv];

    MOIRefreshControlDefaultSubView* view = [[MOIRefreshControlDefaultSubView alloc]
        initWithFont:[UIFont systemFontOfSize:14]
               label:@"load more"];

    _refreshCtrl = [[MOIRefreshControl alloc] initWithSubView:view
                                                 inScrollView:_tbv];

    [_refreshCtrl addTarget:self
                     action:@selector(refreshing:)
           forControlEvents:UIControlEventValueChanged];

    _data = [@[ @"1", @"2", @"3" ] mutableCopy];
}

- (void)refreshing:(id)sender
{
    static int idx = 3;

    __block MOIRefreshControl* refreshCtrl = (MOIRefreshControl*)sender;
    MOIRefreshControlDefaultSubView* view = (MOIRefreshControlDefaultSubView*)refreshCtrl.subView;
    [view setLabel:@"loading..."];
    [view.loadingView startAnimating];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC),
        dispatch_get_main_queue(), ^(void) {
            for (int i = 0; i < 3; i++) {
                NSString* str = [NSString stringWithFormat:@"%d", ++idx];
                [_data addObject:str];
            }
            NSLog(@"refreshing:");
            [view.loadingView stopAnimating];
            [refreshCtrl endRefreshingWithDuration:0.3
                                        completion:^(void) {
                                            [_tbv reloadData];
                                            [view setLabel:@"load more"];
                                        }];
        });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* cellID = @"sellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [_data objectAtIndex:indexPath.row];
    return cell;
}

@end
