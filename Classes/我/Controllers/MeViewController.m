//
//  MeViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/22.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *TableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation MeViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
     return  _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:253/255.0 green:109/255.0 blue:142/255.0 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.TableView.delegate= self;
    
    self.TableView.dataSource = self;
    
    [self.TableView registerNib:[UINib nibWithNibName:@"MeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark-UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}


@end
