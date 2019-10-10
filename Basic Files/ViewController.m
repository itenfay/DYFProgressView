//
//  ViewController.m
//
//  Created by dyf on 17/5/27.
//  Copyright © 2017 dyf. All rights reserved.
//

#import "ViewController.h"
#import "DYFDisplayViewController.h"

@interface ViewController ()

@property (nonatomic, strong) DYFDisplayViewController *displayViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DYFProgressView Demo";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.displayViewController = nil;
}

- (IBAction)loadBaidu:(id)sender {
    [self pushWithUrl:@"https://www.baidu.com/"];
}

- (IBAction)loadMyGithub:(id)sender {
    [self pushWithUrl:@"https://github.com/dgynfi/"];
}

- (void)pushWithUrl:(NSString *)aUrl {
    DYFDisplayViewController *dvc = self.displayViewController;
    dvc.aUrl = aUrl;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (DYFDisplayViewController *)displayViewController {
    if (!_displayViewController) {
        _displayViewController = [[DYFDisplayViewController alloc] init];
    }
    return _displayViewController;
}

@end
