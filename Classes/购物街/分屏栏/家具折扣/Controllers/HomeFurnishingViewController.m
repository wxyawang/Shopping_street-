//
//  HomeFurnishingViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/29.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "HomeFurnishingViewController.h"
#import "All2ViewController.h"
#import "HouseholdDailyController.h"
 #import "BooksViewController.h"
#import "DigitalViewController.h"
#import "OutdoorViewController.h"



#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface HomeFurnishingViewController ()<UIScrollViewDelegate>
{
    
    BOOL _isHaveCreateContainer;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation HomeFurnishingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTopButton];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.scrollView.bounces = NO;
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
    self.scrollView.contentSize = CGSizeMake(WIDTH * 4, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    All2ViewController *avc = [All2ViewController new];
    HouseholdDailyController *gvc = [HouseholdDailyController new];
    
    BooksViewController *svc = [BooksViewController new];
    DigitalViewController *bvc = [DigitalViewController new];
    
    
    [self addChildViewController:avc];
    [self addChildViewController:gvc];
    [self addChildViewController:svc];
    [self addChildViewController:bvc];
    
    
    [self.scrollView addSubview:avc.view];
    [self.scrollView addSubview:gvc.view];
    [self.scrollView addSubview:svc.view];
    [self.scrollView addSubview:bvc.view];
    
    
    avc.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 40);
    gvc.view.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 64 - 40);
    svc.view.frame = CGRectMake(WIDTH * 2, 0, WIDTH, HEIGHT - 64 - 40);
    bvc.view.frame = CGRectMake(WIDTH * 3, 0, WIDTH, HEIGHT - 64 - 40);
    self.scrollView.delegate = self;
}

-(void)createTopButton
{
   
    NSArray *titles = @[@"全部",@"家居日用",@"图书",@"数码家电"];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i * 70+ 30, 0, 70, 40);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [self.topView addSubview:button];
        
        if (i==0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
             [button setBackgroundImage:[UIImage imageNamed:@"navBtn_bag"] forState:UIControlStateNormal];
            
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 100 + i;
        
    }
    
   
}

-(void)buttonClick:(UIButton *)button
{
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = (UIButton *)[self.topView viewWithTag:100 + i];
        
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
    
    for (int i = 0; i < 4; i ++) {
        
        UIButton *button = (UIButton *)[self.topView viewWithTag:100 + i];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    UIButton *button = (UIButton *)[self.topView viewWithTag:100 + offsetIndex];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"navBtn_bag"] forState:UIControlStateNormal];
}



@end
