//
//  AppDelegate.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/22.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "AppDelegate.h"
#import "MeViewController.h"
#import "HerCircleViewController.h"
#import "ShopingCartViewController.h"
#import "ShopingStreetViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "SettingViewController.h"
#import "CustomViewController.h"
#import "ShowViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ShopingStreetViewController *ssc = [ShopingStreetViewController new];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:ssc];
    ssc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"购物街" image:[UIImage imageNamed:@"bottom_ic_first@2x"] selectedImage:[UIImage imageNamed:@"bottom_ic_first_up@2x"]];
    
    
    HerCircleViewController *hvc = [HerCircleViewController new];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:hvc];
    nvc2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"贝贝圈" image:[UIImage imageNamed:@"bottom_ic_tata@2x"] selectedImage:[UIImage imageNamed:@"bottom_ic_tata_up@2x"]];
    
    ShopingCartViewController *scc = [ShopingCartViewController new];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:scc];
    nvc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"bottom_ic_buy@2x"] selectedImage:[UIImage imageNamed:@"bottom_ic_buy_up@2x"]];
    
    SettingViewController  *mvc = [SettingViewController new];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:mvc];
    nvc4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"bottom_ic_mine@2x"] selectedImage:[UIImage imageNamed:@"bottom_ic_mine_up@2x"]];
    
    LeftViewController *cvc = [LeftViewController new];
    UINavigationController *nvc5 = [[UINavigationController alloc]initWithRootViewController:cvc];
    nvc5.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:nil selectedImage:nil];
    
    UITabBarController *tab = [UITabBarController new];
    tab.viewControllers = @[nvc1,nvc2,nvc3,nvc4,nvc5];
    
    
    [tab.tabBar setTintColor:[UIColor colorWithRed:252/255.0 green:52/255.0 blue:128/255.0 alpha:1.0]];
    
    
    //LeftViewController *leftVC = [LeftViewController new];
 
  
    //MMDrawerController * RootVC = [[MMDrawerController alloc]initWithCenterViewController:tab leftDrawerViewController:leftVC];
    
    self.window.rootViewController = tab;
    
    //self.window.rootViewController = RootVC;
    
    //[RootVC setMaximumLeftDrawerWidth:180];
    
    //[RootVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //[RootVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    
    [self.window makeKeyWindow];
    
    return YES;
}

 
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
