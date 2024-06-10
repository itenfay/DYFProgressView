//
//  DYFDisplayViewController.h
//
//  Created by Tenfay on 17/5/27.
//  Copyright © 2017 Tenfay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DYFDisplayViewController : UIViewController

@property (copy, nonatomic) NSString *aUrl;

@property (strong, nonatomic) WKWebView *wk_webView;

@end
