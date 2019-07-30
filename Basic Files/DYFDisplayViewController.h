//
//  DYFDisplayViewController.h
//
//  Created by dyf on 17/5/27.
//  Copyright © 2017 dyf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYFDisplayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@property (copy, nonatomic) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
