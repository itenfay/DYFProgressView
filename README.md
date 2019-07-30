[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!)](https://github.com/dgynfi/DYFProgressView)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;

## 技术交流群(群号:155353383) 

欢迎加入技术交流群，一起探讨技术问题。<br />
![](https://github.com/dgynfi/DYFProgressView/raw/master/images/qq155353383.jpg)

## DYFProgressView

超好用的进度条和网页进度条，操作简单好用。(Super useful progress bar and web page progress bar. The operation is simple and easy to use.)

## 使用说明

1. 实例化

```ObjC
// Lazy load
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

```

2. 添加到父视图

```ObjC
// 添加到父视图。
- (void)addProgressView {
    if (!_progressView) {
        [self.navigationBar addSubview:self.progressView];
    }
}

// 在开始加载进度前，调用它
[self addProgressView];
```

3. 开始加载进度

```ObjC
[self.progressView startLoading];
```

4. 结束加载进度

```ObjC
[self.progressView endLoading];
```
