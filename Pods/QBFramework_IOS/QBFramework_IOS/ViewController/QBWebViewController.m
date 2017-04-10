//
//  QBWebViewController.m
//  QBFramework
//
//  Created by quentin on 16/7/11.
//  Copyright © 2016年 Quentin. All rights reserved.
//

#import "QBWebViewController.h"
#import "QBConfig.h"

@interface QBWebViewController () <UIWebViewDelegate>

{
    UIWebView *_webView;
    
    UIActivityIndicatorView     *_indicatorView;

}

@property (nonatomic, strong) NSURL *aUrl;
@end

@implementation QBWebViewController
@synthesize aUrl;
@synthesize showSubTitle;

- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        self.aUrl = url;
        self.showSubTitle = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.navigationTitle == nil) {
        if (showSubTitle) {
            SET_NAVIGATION_TITLE_SUBTITLE(LSTR(@"加载中..."), self.aUrl.absoluteString);
        }
        else {
            SET_NAVIGATION_TITLE(LSTR(@"加载中..."));
        }
    }
    
    ADD_BACK(back);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame))];
        webView.delegate = self;
        [self.view addSubview:webView];
        _webView = webView;
        
        //UIActivityIndicatorView
        {
            _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _indicatorView.frame = CGRectMake((CGRectGetWidth(self.view.frame) - CGRectGetWidth(_indicatorView.frame)) / 2, (CGRectGetHeight(self.view.frame) - CGRectGetHeight(_indicatorView.frame)) / 2, CGRectGetWidth(_indicatorView.frame), CGRectGetHeight(_indicatorView.frame));
            [self.view addSubview:_indicatorView];
            
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:self.aUrl];
        
        [_webView loadRequest:request];
    }
    
}

- (void)back
{
    _webView.delegate = nil;
    [_webView stopLoading];
    
    if (self.presentingViewController.presentedViewController == self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)goBack
{
    [_webView stopLoading];
    [_webView goBack];
}

#pragma mark - UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length > 0 && self.navigationTitle == nil) {
        
        if (showSubTitle) {
            SET_NAVIGATION_TITLE_SUBTITLE(title, self.aUrl.absoluteString);
        }
        else {
            SET_NAVIGATION_TITLE(title);
        }
    }
    
    [_indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length > 0 && self.navigationTitle == nil) {
        if (showSubTitle) {
            SET_NAVIGATION_TITLE_SUBTITLE(title, self.aUrl.absoluteString);
        }
        else {
            SET_NAVIGATION_TITLE(title);
        }
    }
    
    [_indicatorView stopAnimating];
    
    if ([_webView canGoBack]) {
        ADD_BACK_HOME_BUTTON(goBack, back);
    }
    else {
        ADD_BACK(back);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_indicatorView stopAnimating];
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length > 0 && self.navigationTitle == nil) {
        if (showSubTitle) {
            SET_NAVIGATION_TITLE_SUBTITLE(title, self.aUrl.absoluteString);
        }
        else {
            SET_NAVIGATION_TITLE(title);
        }
    }
    else {
        
        if (self.navigationTitle == nil) {
            if (showSubTitle) {
                SET_NAVIGATION_TITLE_SUBTITLE(@"加载失败", self.aUrl.absoluteString);
            }
            else {
                SET_NAVIGATION_TITLE(@"加载失败");
            }
        }

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
