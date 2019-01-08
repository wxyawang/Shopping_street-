//
//  ShopingStreetViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/22.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "ShopingStreetViewController.h"
#import "AFNetworking.h"
#import "ShopingStreet.h"
#import "MJRefresh.h"
#import "ScrollViewModel.h"
#import "URLModel.h"
#import "ShowcollectionModel.h"
#import "ShopingStreetTableViewCell.h"
#import "TaobaoDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ShowViewController.h"
#import "SDCycleScrollView.h"
#import "ClothingViewController.h"

#import "LeftViewController.h"//左视图文件
#import "UIViewController+MMDrawerController.h" //第三方封装的文件
#import "MMDrawerBarButtonItem.h"


#define GWJ_URL @"http://m.meiyou.com/tae_brand_list?myuid=73722622&tbuid=&device_id=20:08:ed:07:f3:79&platform=android&v=1.1.1&imei=359209025863006&bundleid=186&mode=0&app_id=7&v_auth=3.DqTGf72kmhDOyth2ubECWWx5YuN%252FozqaQtvtToqdqhs%253D&sdkversion=17&path=&timestamp="

#define SHOW_URL @"http://m.meiyou.com/tae_item_list?myuid=73722622&tbuid=&device_id=20:08:ed:07:f3:79&platform=android&v=1.1.1&imei=359209025863006&bundleid=186&mode=0&app_id=7&v_auth=3.DqTGf72kmhDOyth2ubECWWx5YuN%%252FozqaQtvtToqdqhs%%253D&sdkversion=17&activity_id=0&brand_area_id=%@&item_id=0&page=1&source=&tab=item"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ShopingStreetViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,SDCycleScrollViewDelegate>
{
    NSInteger count;
}

@property (weak, nonatomic) IBOutlet UITableView *ShopingTableView;

@property (nonatomic ,strong)NSMutableArray *dataArray;//cell数据源

@property (nonatomic ,strong)NSMutableArray *dataSource;//广告栏数据源

@property (nonatomic,strong)NSMutableArray *dataImage;

@property (strong,nonatomic)SDCycleScrollView *cycleScrollView;//轮播器

@property (strong,nonatomic) ScrollViewModel *model;

@property (strong,nonatomic) ShowViewController *svc;
@end

@implementation ShopingStreetViewController


-(NSMutableArray *)dataImage
{
    if (_dataImage == nil) {
        _dataImage = [NSMutableArray new];
    }
    return _dataImage;
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    count = 0;
    self.title = @"购物街";
     self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:253/255.0 green:109/255.0 blue:142/255.0 alpha:1.0];
     [self creatTableViewUI];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Rightclick:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemRewind target:self action:@selector(Leftclick:)];
}
-(void)Rightclick:(UIBarButtonItem *)right {
    self.ShopingTableView.hidden = YES;
}

-(void)Leftclick:(UIBarButtonItem *)right {
    self.ShopingTableView.hidden = NO;
}

- (void)creatTableViewUI {
    
    self.ShopingTableView.delegate = self;
    self.ShopingTableView.dataSource = self;
    [self.ShopingTableView registerNib:[UINib nibWithNibName:@"ShopingStreetTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self getDataSourceFrom];
    [self ScrollNetWorkImages];
    [self getDataFromNet];
    [self addRefresh];
}

- (void)creatCollectionViewUI {
    
}

-(void)addRefresh
{
    
    self.ShopingTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        count ++;
        [self getDataFromNet];
        
    }];
    self.ShopingTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
    }];

}

- (IBAction)LeftButton:(UIButton *)sender {
    
    //开关左抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


 //获取cell数据
-(void)getDataFromNet
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manger GET:GWJ_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.dataArray removeAllObjects];
        
        //解析数据
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
       
       NSArray *item_listArray= dict[@"item_list"];
        for (NSDictionary *dict1 in item_listArray) {
            
            NSArray *item_listArray1 = dict1[@"item_list"];
            
            for (NSDictionary *dict2 in item_listArray1) {
                
                ShopingStreet *model = [ShopingStreet new];
                model.NameLabel = dict2[@"name"];
                model.PictureImage = dict2[@"picture"];
                
                NSString *str = dict2[@"original_price"];
                NSString *str1 = @"￥";
                
                NSString *str2 = dict2[@"vip_price"];

                model.original_priceLabel = [NSString stringWithFormat:@"%@%@",str1,str];
               
                model.promotion_customLabel = dict2[@"promotion_custom"];
                
                model.purchase_btnLabel = dict2[@"purchase_btn"];
                
                model.vip_price = [NSString stringWithFormat:@"%@%@",str1,str2];
                
                model.item_count_msgLabel = dict2[@"item_count_msg"];
                model.brand_area_idLabel = dict2[@"brand_area_id"];
                
                model.brand_area_nameLabel = dict2[@"brand_area_name"];
                
                model.redirect_urlLabel = dict2[@"redirect_url"];
                
                [self.dataArray addObject:model];
           }
           
            [self.ShopingTableView.mj_header endRefreshing];
            [self.ShopingTableView.mj_footer endRefreshing];
            
            [self.ShopingTableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"获取数据失败");
        
        [self.ShopingTableView.mj_header endRefreshing];
        [self.ShopingTableView.mj_footer endRefreshing];
        
        
    }];
}

//获取广告栏的数据

-(void)getDataSourceFrom
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.dataArray removeAllObjects];
    [self.dataImage removeAllObjects];
    
    [manger GET:GWJ_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *bannerArray = dict[@"banner"];
        for (NSDictionary *dict1 in bannerArray) {
            self.model = [ScrollViewModel new];
            self.model .picture_url = dict1[@"picture_url"];
            self.model .name = dict1[@"name"];
            self.model .link_value = dict1[@"link_value"];
            [self.dataSource addObject:self.model];
            [self.dataImage addObject:self.model.picture_url];
             self.cycleScrollView.imageURLStringsGroup = self.dataImage;
            [self.ShopingTableView reloadData];
        }
        
       self.ShopingTableView.tableHeaderView = self.cycleScrollView;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"获取数据失败");
    }];
}

-(void)ScrollNetWorkImages{
    
    CGRect rect = CGRectMake(0,64, self.view.bounds.size.width, 130
                             );
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:nil];
    
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
    self.cycleScrollView.autoScrollTimeInterval = 4.0;
    
    self.cycleScrollView.showPageControl = YES;
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    self.cycleScrollView.currentPageDotColor = [UIColor redColor];
    
    self.cycleScrollView.pageDotColor = [UIColor whiteColor];
 
    [self.view addSubview:self.cycleScrollView];
}

#pragma mark - 代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    ScrollViewModel *model = self.dataSource[index];
    self.svc = [ShowViewController new];
    self.svc.hidesBottomBarWhenPushed = YES;
    self.svc.brand_area_idLabel = model .link_value ;
    self.svc.string = model .name;
    [self.navigationController pushViewController:self.svc animated:YES];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    //NSLog(@"%ld",index);
}

#pragma mark-UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopingStreetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopingStreet *model = self.dataArray[indexPath.row];

    cell.NameLabel.text = model.NameLabel;
    cell.purchase_btnLabel.text = model.purchase_btnLabel;
    cell.vip_priceLabel.text = model.vip_price;
 
    NSString *vipLabel = [NSString stringWithFormat:@"%.2f",[model.original_priceLabel floatValue]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:vipLabel attributes:attribtDic];
    cell.original_priceLabel.attributedText = attribtStr;
    
    cell.promotion_customLabel.text = model.promotion_customLabel;
    
    if (model.promotion_customLabel.length != 0) {
        
        cell.BaoyouLabel.hidden = YES;
    }else
    {
        cell.BaoyouLabel.hidden = NO;
    }
    
    
    if (model.item_count_msgLabel.length == 0) {
        
        cell.item_count_msgLabel.hidden = YES;
 
    }else
    {
        cell.item_count_msgLabel.hidden = NO;
    }
    
    cell.item_count_msgLabel.text = model.item_count_msgLabel;
    
    
    [cell.PictureImage setImageWithURL:[NSURL URLWithString:model.PictureImage]];
   
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopingStreet *model = self.dataArray[indexPath.row];
    
    if (model.item_count_msgLabel.length != 0) {
        
        ShowViewController *svc = [ShowViewController new];
        
        svc.brand_area_idLabel  = [NSString stringWithFormat:@"%@",model.brand_area_idLabel];
        
        svc.string = model.brand_area_nameLabel;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
    
        TaobaoDetailViewController *tvc = [TaobaoDetailViewController new];
        
        ShopingStreet *model = self.dataArray[indexPath.row];
        
        tvc.url = [NSURL URLWithString:model.redirect_urlLabel];
        
        [self.navigationController pushViewController:tvc animated:YES];
        
       
    }
    
}


@end










