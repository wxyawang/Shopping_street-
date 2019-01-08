//
//  TaoBaoViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/29.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "TaoBaoViewController.h"

@interface TaoBaoViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"淘宝商品";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];

}

- (IBAction)LeftButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
 
@end
