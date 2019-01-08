//
//  ClothingViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/26.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "ClothingViewController.h"
#import "AllViewController.h"
#import "GirlClothingViewController.h"
#import "ShoesViewController.h"
#import "BagViewController.h"
#import "AccessoriesViewController.h"

#import "ShopingStreetViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ClothingViewController ()<UIScrollViewDelegate>
{
         BOOL _isHaveCreateContainer;
        UIView *_topView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ClothingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTopButton];
   self.automaticallyAdjustsScrollViewInsets = NO;
   self.scrollView.bounces = NO;
     
}

- (IBAction)LeftButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:UIModalTransitionStyleCoverVertical completion:nil];
    
}

 -(void)viewDidAppear:(BOOL)animated
{
    if (!_isHaveCreateContainer) {
        
        [self createContainer];
        _isHaveCreateContainer = YES;
    }
    
    
}

-(void)createContainer
{
    self.scrollView.contentSize = CGSizeMake(WIDTH * 5, 0);
    self.scrollView.pagingEnabled = YES;
    
    AllViewController *avc = [AllViewController new];
    GirlClothingViewController *gvc = [GirlClothingViewController new];
    ShoesViewController *svc = [ShoesViewController new];
    BagViewController *bvc = [BagViewController new];
    AccessoriesViewController *acc = [AccessoriesViewController new];
    
    [self addChildViewController:avc];
    [self addChildViewController:gvc];
    [self addChildViewController:svc];
    [self addChildViewController:bvc];
    [self addChildViewController:acc];
    
    [self.scrollView addSubview:avc.view];
    [self.scrollView addSubview:gvc.view];
    [self.scrollView addSubview:svc.view];
    [self.scrollView addSubview:bvc.view];
    [self.scrollView addSubview:acc.view];

    avc.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 36);
    gvc.view.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 64 - 36);
    svc.view.frame = CGRectMake(WIDTH * 2, 0, WIDTH, HEIGHT - 64 - 36);
    bvc.view.frame = CGRectMake(WIDTH * 3, 0, WIDTH, HEIGHT - 64 - 36);
    acc.view.frame = CGRectMake(WIDTH * 4,0, WIDTH, HEIGHT - 64- 36);
    
    self.scrollView.delegate = self;

    
}

-(void)createTopButton
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    NSArray *titles = @[@"全部",@"女装",@"鞋靴",@"包袋",@"配饰"];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i * 70+ 20, 0, 80, 35);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [_topView addSubview:button];
        
        if (i==0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"navBtn_bag"] forState:UIControlStateNormal];
            
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 100 + i;
        
        
        
    }
    
    [self.view addSubview:_topView];
}

-(void)buttonClick:(UIButton *)button
{
    for (int i = 0; i < 5; i++) {
        
        UIButton *button = (UIButton *)[_topView viewWithTag:100 + i];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        
    }
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"navBtn_bag"] forState:UIControlStateNormal];
    
    //点击按钮，滚动下方的scrollView
    [self.scrollView setContentOffset:CGPointMake((button.tag - 100) * WIDTH, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int offsetIndex = scrollView.contentOffset.x / WIDTH;
    
    for (int i = 0; i < 5; i ++) {
        
        UIButton *button = (UIButton *)[_topView viewWithTag:100 + i];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    
    UIButton *button = (UIButton *)[_topView viewWithTag:100 + offsetIndex];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"navBtn_bag"] forState:UIControlStateNormal];
}


 
@end

















