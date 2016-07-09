//
//  ViewController.m
//  kerkeePlusExample
//
//  Created by zihong on 15/8/25.
//  Copyright (c) 2015年 zihong. All rights reserved.
//

#import "ViewController.h"
#import "kerkee.h"
#import "KCRegistMgr.h"
#import "KCBaseDefine.h"
#import "KCWebPathDefine.h"
#import "KCURIComponents.h"
#import "KCActionTest.h"
#import "KCUriRegister.h"
#import "KCUriDispatcher.h"
#import "KCFetchManifest.h"
#import "KCJSCompileExecutor.h"
#import "KCFile.h"
#import "KCFileManager.h"
#import "KCString.h"
#import "KCLog.h"
#import "kerkeePlus/KCDownloadEngine.h"
#import "KCDeployTest.h"


@interface ViewController ()
{
    KCWebView* m_webView;
    KCJSBridge* m_jsBridge;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //addSkipBackupAttributeToItemAtURL
    
    KCDeployTest* deployTest = [[KCDeployTest alloc] init];
    [deployTest setup];
    [deployTest check];
    
    
    
    [KCRegistMgr registAllClass];
    KCLog(@"docment dir:\n%@",KCWebPath_HtmlRootPath);
    
    m_webView = [[KCWebView alloc] initWithFrame:self.view.bounds];
    //add webview in your view
    [self.view addSubview:m_webView];
    //you can implement webview delegate
    m_jsBridge = [[KCJSBridge alloc] initWithWebView:m_webView delegate:self];
    

//    NSString* pathTestHtml = [[NSBundle mainBundle] pathForResource:@"test.html" ofType:Nil];
//    NSURL* url =[NSURL URLWithString:pathTestHtml];
    NSURL* url =[NSURL URLWithString:KCWebPath_ModulesTest_File];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [m_webView loadRequest:request];
    
    [self testFetchManifest];
    
    //test action
    [self testAction];
    
    [self testDownload];
}


-(void)testAction
{
    KCUriRegister* uriRegister = [KCUriDispatcher markDefaultRegister:@"kerkee"];
//    KCUriRegister* uriRegister = [KCUriDispatcher defaultUriRegister];
    KCActionTest* action = [[KCActionTest alloc] init];
    [uriRegister registerAction:action];
    
    [KCUriDispatcher dispatcher:@"kerkee://search/path?A=1&B=2&C=3&D=4"];
}


-(void)testFetchManifest
{
    KCURI* uriServer = [KCURI parse:@"http://www.linzihong.com/test/html/manifest"];
    [KCFetchManifest fetchOneServerManifest:uriServer block:^(KCManifestObject *aManifestObject) {
    }];
    [KCFetchManifest fetchServerManifests:uriServer block:^(KCManifestObject *aManifestObject) {
        
        KCLog(@"%@", aManifestObject);
    }];
    
    
    KCURI* uriLocal = [KCURI parse:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/html"] stringByAppendingPathComponent:@"manifest"]];
//    [KCFetchManifest fetchOneLocalManifest:uriLocal block:^(KCManifestObject *aManifestObject)
//    {
//        KCLog(@"%@", aManifestObject);
//    }];
    
    [KCFetchManifest fetchLocalManifests:uriLocal block:^(KCManifestObject *aManifestObject) {
        KCLog(@"%@", aManifestObject);
    }];
}

- (void)testDownload
{
    NSString* urlDownload = @"http://gdown.baidu.com/data/wisegame/4f9b25fb0e093ac6/QQ_220.apk";
    //    NSString* urlDownload = @"http://www.linzihong.com/test/update/html.dek"
    [[KCDownloadEngine defaultDownloadEngine] startDownloadWithURL:[NSURL URLWithString:urlDownload] toPath:nil delegate:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark KCWebViewProgressDelegate

-(void)webView:(KCWebView*)webView identifierForInitialRequest:(NSURLRequest*)initialRequest
{
}

#pragma mark - UIWebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    NSString *scrollHeight = [aWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    NSLog(@"scrollHeight: %@", scrollHeight);
    NSLog(@"webview.contentSize.height %f", aWebView.scrollView.contentSize.height);
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:aWebView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:[scrollHeight floatValue]];
    
//    [aWebView addConstraint:heightConstraint];
    NSLog(@"webview frame %@", NSStringFromCGRect(aWebView.frame));
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


@end
