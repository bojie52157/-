//
//  XMGWebViewController.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/16.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGWebViewController.h"


@interface XMGWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;


@end

@implementation XMGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载url
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

}

#pragma mark -监听点击

- (IBAction)reload{
    [self.webView reload];
}

- (IBAction)back{
    [self.webView goBack];
}

- (IBAction)forward{
    [self.webView goForward];
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}
@end
