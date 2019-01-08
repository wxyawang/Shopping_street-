//
//  HerWebViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/31.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "HerWebViewController.h"

@interface HerWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation HerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    //self.navigationController.navigationBarHidden = YES;

    self.webView.autoresizesSubviews = YES;
}


- (IBAction)LeftButton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end











