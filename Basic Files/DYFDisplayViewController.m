//
//  DYFDisplayViewController.m
//
//  Created by dyf on 17/5/27.
//  Copyright © 2017 dyf. All rights reserved.
//

#import "DYFDisplayViewController.h"
#import "DYFWebProgressView.h"

#define RGB_V(v) (v)/255.f

@interface DYFDisplayViewController () <UIWebViewDelegate>

@property (nonatomic, strong) DYFWebProgressView *progressView;

@end

@implementation DYFDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addProgressView];
    [self loadRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.progressView endLoading];
}

- (void)loadRequest {
    [self.m_webView setDelegate:self];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.m_webView loadRequest:req];
}

- (void)addProgressView {
    if (!_progressView) {
        [self.navigationBar addSubview:self.progressView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"%s: url - %@", __func__, urlString);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
    [self.progressView startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
    [self.progressView endLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%s: error - %@", __func__, error.description);
    [self.progressView endLoading];
}

- (DYFWebProgressView *)progressView {
    if (!_progressView) {
        CGFloat w = self.navigationBar.bounds.size.width;
        CGFloat h = 3.f;
        CGFloat x = 0.f;
        CGFloat y = self.navigationBar.bounds.size.height - h;
        
        _progressView = [[DYFWebProgressView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _progressView.lineWidth = 3.f;
        _progressView.lineColor = [UIColor colorWithRed:RGB_V(10) green:RGB_V(115) blue:RGB_V(255) alpha:1];
    }
    return _progressView;
}

- (UINavigationBar *)navigationBar {
    return self.navigationController.navigationBar;
}

@end
