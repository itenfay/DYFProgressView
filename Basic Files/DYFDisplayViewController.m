//
//  DYFDisplayViewController.m
//
//  Created by Tenfay on 17/5/27.
//  Copyright © 2017 Tenfay. All rights reserved.
//

#import "DYFDisplayViewController.h"
#import "DYFWebProgressView.h"

#define RGB_V(v) (v)/255.0
#define SCR_S    UIScreen.mainScreen.bounds.size
#define SCR_W    SCR_S.width
#define SCR_H    SCR_S.height

@interface DYFDisplayViewController () <WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) UIToolbar *wk_toolBar;
@property (nonatomic, strong) DYFWebProgressView *progressView;

@end

@implementation DYFDisplayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSLog(@"%s", __FUNCTION__);
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self addProgressView];
    [self addWKWebView];
    [self addWKToolBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *bgColor = [UIColor colorWithRed:RGB_V(243)
                                       green:RGB_V(243)
                                        blue:RGB_V(243)
                                       alpha:1];
    self.view.backgroundColor = bgColor;
    
    [self loadRequest];
}

- (BOOL)hasSafeArea {
    BOOL hasSafeArea = NO;
    
    UIApplication *sharedApp = UIApplication.sharedApplication;
    if (@available(iOS 11.0, *)) {
        hasSafeArea = sharedApp.delegate.window.safeAreaInsets.bottom > 0;
    }
    
    return hasSafeArea;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat topM    = self.hasSafeArea ? (44.f + 44.f) : (20.f + 44.f);
    CGFloat bottomM = self.hasSafeArea ? 34.f : 0.f;
    CGFloat tbH     = 44.f;
    
    CGRect tbFrame;
    tbFrame.origin.x    = 0;
    tbFrame.origin.y    = CGRectGetHeight(self.view.bounds) - tbH;
    tbFrame.size.width  = CGRectGetWidth(self.view.bounds);
    tbFrame.size.height = tbH;
    self.wk_toolBar.frame = tbFrame;
    
    [self adjustWKToolBar];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = tbFrame.size.width;
    CGFloat h = tbFrame.origin.y;
    self.wk_webView.frame = CGRectMake(x, y, w, h);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.progressView endLoading];
}

- (WKWebViewConfiguration *)wk_webViewConfiguration {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.minimumFontSize   = 0;
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    config.allowsInlineMediaPlayback = YES;
    
    if (@available(iOS 9.0, *))
    {
        config.allowsPictureInPictureMediaPlayback = YES;
        config.allowsAirPlayForMediaPlayback       = YES;
        if (@available(iOS 10.0, *)) {
            config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
        } else {
            config.requiresUserActionForMediaPlayback = YES;
        }
    }
    else {
        // Fallback on earlier versions
        config.mediaPlaybackAllowsAirPlay = YES;
        config.mediaPlaybackRequiresUserAction = YES;
    }
    
    return config;
}

- (WKWebView *)wk_webView {
    if (!_wk_webView) {
        _wk_webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.wk_webViewConfiguration];
    }
    return _wk_webView;
}

- (void)addWKWebView {
    UIColor *bgColor = [UIColor colorWithRed:RGB_V(243)
                                       green:RGB_V(243)
                                        blue:RGB_V(243)
                                       alpha:1];
    
    self.wk_webView.backgroundColor    = bgColor;
    self.wk_webView.opaque             = NO;
    self.wk_webView.navigationDelegate = self;
    self.wk_webView.UIDelegate         = self;
    
    self.wk_webView.autoresizingMask   = (UIViewAutoresizingFlexibleLeftMargin |
                                          UIViewAutoresizingFlexibleTopMargin  |
                                          UIViewAutoresizingFlexibleWidth      |
                                          UIViewAutoresizingFlexibleHeight);
    
    [self.view addSubview:self.wk_webView];
}

- (void)addWKToolBar {
    self.wk_toolBar.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleTopMargin  |
                                        UIViewAutoresizingFlexibleWidth      |
                                        UIViewAutoresizingFlexibleHeight);
    
    [self.view addSubview:self.wk_toolBar];
}

- (UIToolbar *)wk_toolBar {
    if (!_wk_toolBar) {
        _wk_toolBar = [[UIToolbar alloc] init];
        _wk_toolBar.barStyle = UIBarStyleDefault;
    }
    return _wk_toolBar;
}

- (void)adjustWKToolBar {
    if (_wk_toolBar) {
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *rewindItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(onBack:)];
        UIBarButtonItem *forWardItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(onForward:)];
        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onRefresh:)];
        UIBarButtonItem *stopItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(onStop:)];
        
        NSArray *items = @[flexibleSpace, rewindItem,
                           flexibleSpace, forWardItem,
                           flexibleSpace, refreshItem,
                           flexibleSpace, stopItem,
                           flexibleSpace];
        [self.wk_toolBar setItems:items animated:YES];
    }
}

- (void)loadRequest {
    NSURL *aURL = [NSURL URLWithString:self.aUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:aURL];
    [self.wk_webView loadRequest:request];
}

- (void)onBack:(id)sender {
    if ([self.wk_webView canGoBack]) {
        [self.wk_webView goBack];
    }
}

- (void)onForward:(id)sender {
    if ([self.wk_webView canGoForward]) {
        [self.wk_webView goForward];
    }
}

- (void)onRefresh:(id)sender {
    [self.wk_webView reload];
}

- (void)onStop:(id)sender {
    if ([self.wk_webView isLoading]) {
        [self.wk_webView stopLoading];
    }
}

- (void)addProgressView {
    if (!_progressView) {
        [self.navigationBar addSubview:self.progressView];
    }
}

- (void)setupNavigationItemTitle {
    self.navigationItem.title = self.wk_webView.title;
}

#pragma make - WKNavigationDelegate, WKUIDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // didStartProvisionalNavigation.
    
    NSURL *aURL = [webView.URL copy];
    NSLog(@"%s url: %@", __FUNCTION__, aURL);
    
    [self.progressView startLoading];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    // didReceiveServerRedirectForProvisionalNavigation.
    NSLog(@"%s url: %@", __FUNCTION__, webView.URL);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
    [self.progressView endLoading];
    [self setupNavigationItemTitle];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (!error) { return; }
    
    NSString *errMessage = [NSString stringWithFormat:@"%zi, %@", error.code, error.localizedDescription];
    NSLog(@"%s [error]: %@", __FUNCTION__, errMessage);
    
    [self.progressView endLoading];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (!error) { return; }
    
    NSString *errMessage = [NSString stringWithFormat:@"%zi, %@", error.code, error.localizedDescription];
    NSLog(@"%s [error]: %@", __FUNCTION__, errMessage);
    
    [self.progressView endLoading];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // decidePolicyForNavigationAction.
    [self setupNavigationItemTitle];
    
    NSURL *aURL = [navigationAction.request.URL copy];
    NSString *aUrl = aURL.absoluteString;
    NSLog(@"%s url: %@", __FUNCTION__, aUrl);
    
    if (![aUrl isEqualToString:@"about:blank"]) {}
    
    // Method NO.1: resolve the problem about '_blank'.
    //if (navigationAction.targetFrame == nil) {
    //NSLog(@"- [webView loadRequest:navigationAction.request]");
    //[webView loadRequest:navigationAction.request];
    //}
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // createWebViewWithConfiguration.
    
    NSURL *aURL = [navigationAction.request.URL copy];
    NSString *aUrl = aURL.absoluteString;
    NSLog(@"%s url: %@", __FUNCTION__, aUrl);
    
    if (!navigationAction.targetFrame.isMainFrame) {
        NSLog(@"- [webView loadRequest:navigationAction.request]");
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
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

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if (_wk_webView) { _wk_webView = nil; }
}

@end
