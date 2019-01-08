//
//  ShopingCartViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/22.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "ShopingCartViewController.h"
#import "GWCWebViewController.h"

@interface ShopingCartViewController ()

@end

@implementation ShopingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"购物车";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:253/255.0 green:109/255.0 blue:142/255.0 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (IBAction)Login:(UIButton *)sender {
    
    GWCWebViewController *wcc = [GWCWebViewController new];
    
    wcc.hidesBottomBarWhenPushed = YES;

    
    [self.navigationController pushViewController:wcc animated:YES];
}
 
@end











