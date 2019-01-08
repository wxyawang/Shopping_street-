//
//  ShowViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/23.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "ShowViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "ShowCollectionViewCell.h"
#import "ShowcollectionModel.h"
#import "UIImageView+AFNetworking.h"
#import "TaobaoDetailViewController.h"

#define SHOW_URL @"http://m.meiyou.com/tae_item_list?myuid=73722622&tbuid=&device_id=20:08:ed:07:f3:79&platform=android&v=1.1.1&imei=359209025863006&bundleid=186&mode=0&app_id=7&v_auth=3.DqTGf72kmhDOyth2ubECWWx5YuN%%252FozqaQtvtToqdqhs%%253D&sdkversion=17&activity_id=0&brand_area_id=%@&item_id=0&source=&tab=item"

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 系统控件适配
#define isiPhone5or5sor5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6or6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6plusor6splus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXorXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


#define TopHeight     (isiPhoneXorXs?88:64)
#define TabbarHeight  (IS_iPhoneX?83:(49 + 6))
#define NavBarHeight   44
#define StatusBarHeight (IS_iPhoneX?44:20)
#define BottomSafeHeight (IS_iPhoneX?34:20)

//app主体颜色
#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

#define KLineGrayColor      RGBCOLOR(228.f, 228.f, 228.f)
#define KBackgroundColor    [UIColor colorOfHex:0xf6f6f6]
#define KDarkTextColor      [UIColor colorOfHex:0x333333]
#define KGrayTextColor      [UIColor colorOfHex:0x999999]

//&page=1
@interface ShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger count;
}

 @end

@implementation ShowViewController

-(NSMutableArray *)DataArray
{
    if (_DataArray == nil) {
        _DataArray = [NSMutableArray new];
    }
    return _DataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat height = 0;
    self.title = self.string;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
 
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,[self topHeight:height], Main_Screen_Width, Main_Screen_Height - [self topHeight:height] ) collectionViewLayout:flowLayout] ;
    NSLog(@"[self topHeight:height]:%f",[self topHeight:height]);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = kGrayColor;
    [_collectionView registerClass:[ShowCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    
    //去掉顶部偏移
    if (@available(iOS 11.0, *))
    {
       _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_collectionView];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    [self getFromShowNet];
   [self addRefresh];
}

- (CGFloat )topHeight:(CGFloat )height{
    if (isiPhone5or5sor5c || isiPhone6or6s) {
        height = 64;
    }else if (isiPhoneXorXs || isiPhoneXr || isiPhoneMax){
        height = 88;
    }
    return height;
}

-(void)addRefresh
{
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      [self getFromShowNet];
    }];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        count++;
        [self.DataArray removeAllObjects];
        [self getFromShowNet];
    }];
    
}

-(void)getFromShowNet
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [self.DataArray removeAllObjects];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
   [self.DataArray removeAllObjects];
    [manger GET:[NSString stringWithFormat:SHOW_URL,self.brand_area_idLabel] parameters:@{@"page":@(count)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *itemsArray = dict[@"items"];
        for (NSDictionary *dict1 in itemsArray) {
            ShowcollectionModel *model = [ShowcollectionModel new];
            model.nameLabel = dict1[@"name"];
            model.vip_priceLabel = dict1[@"vip_price"];
            model.pictureLabel = dict1[@"picture"];
            model.redirect_url = dict1[@"redirect_url"];
            model.purchase_btnLabel = dict1[@"purchase_btn"];
            model.original_priceLabel = dict1[@"original_price"];
            [self.DataArray addObject:model];
            
        }
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
        //[_collectionView.mj_header endRefreshing];
        //[_collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"获取详情数据失败");
        
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark-UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.DataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionCell = @"CollectionCell";
    ShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    ShowcollectionModel *model = self.DataArray[indexPath.item];
//    if (indexPath .item< self.DataArray.count) {
//        [self.DataArray indexOfObject:indexPath];
//    }
    cell.nameLabel.text =model.nameLabel;
    cell.SmallImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ad_taobao.png"]];
    cell.purchase_btnLabel.text = model.purchase_btnLabel;
    NSString *vipLabel = [NSString stringWithFormat:@"¥%.1f",[model.vip_priceLabel floatValue]];
    cell.vip_priceLabel.text = vipLabel;
    NSString *original = [NSString stringWithFormat:@"%.1f",[model.original_priceLabel floatValue]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",original] attributes:attribtDic];
    cell.original_priceLabel.attributedText = attribtStr;
    [cell.pictureImage setImageWithURL:[NSURL URLWithString:model.pictureLabel]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Main_Screen_Width, 0);
}
#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemCount = 2;
    if (isiPhone5or5sor5c) {
        return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 40);
    
    }else if (isiPhone6or6s){
        return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 50);

    }else if (isiPhone6plusor6splus){
        return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 60);
    }else if (isiPhoneXorXs){
        return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 65);
    }else if (isiPhoneXr){
        return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 70);
    }else if (isiPhoneMax){
        return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 75);
    }
   return CGSizeMake((Main_Screen_Width - 30)/itemCount, (Main_Screen_Width - 30)/itemCount + 50);
}

//距离collectionview的上下左右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TaobaoDetailViewController *tvc = [TaobaoDetailViewController new];
    
    ShowcollectionModel *model = self.DataArray[indexPath.item];
    
    tvc.url = [NSURL URLWithString:model.redirect_url];
    
    [self.navigationController pushViewController:tvc animated:YES];
     
}

 
@end











