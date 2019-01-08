//
//  LeftViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/26.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "LeftViewController.h"
#import "HomeFurnishingViewController.h"
#import "BeautifulyFootViewController.h"
#import "BeautyViewController.h"
#import "BabyViewController.h"
#import "ClothingViewController.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL _isRelate;
}
@property (nonatomic,strong)NSArray *dataSource;

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)UICollectionView *Collection;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//设置自己想要的颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:253/255.0 green:109/255.0 blue:142/255.0 alpha:1.0];
    [self.navigationItem setTitle:@"商品分类"];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray arrayWithObjects:@"古玩收藏",@"工艺一品",@"数码相机",@"男女饰品",@"品牌手表",@"男女包包",@"电脑手机",@"居家用品",@"运动休闲",@"品牌手表",@"男女包包",@"电脑手机",nil];
    
    [self TableView];
    [self CollectionView];
    
}

-(UITableView *)TableView{
    if (self.table == nil) {
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4,kScreenHeight - 40) style:UITableViewStylePlain];
        self.table.backgroundColor = [UIColor grayColor];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.rowHeight = kScreenHeight / 12;
        self.table.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.table];
    }
    return self.table;
}

-(UICollectionView *)CollectionView{
    if (self.Collection == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        self.Collection = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidth/4, 0, kScreenWidth*3/4, kScreenHeight - 40) collectionViewLayout:layout];//初始化，并设置布局方式
        self.Collection.backgroundColor = [UIColor whiteColor];
        
        [self.Collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];//注册UICollectionViewCell，这是固定格式，也是必须要实现的
        
        [self.Collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];//注册头/尾视图
        [self.Collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
        self.Collection.delegate = self;
        self.Collection.dataSource = self;
        [self.view addSubview:self.Collection];
    }
    return self.Collection;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //设置组数，不写该方法默认是一组
    return self.dataSource.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";//注意，此处的identifier要与注册cell时使用的标识保持一致
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    if(indexPath.item == 0)
    {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        UILabel *titleTextLable = [[UILabel alloc]initWithFrame:cell.frame];
        titleTextLable.textColor = [UIColor whiteColor];
        titleTextLable.text = self.dataSource[indexPath.section];
        titleTextLable.backgroundColor = [UIColor redColor];
        cell.backgroundView = titleTextLable;
        cell.userInteractionEnabled = NO;
    }else
    {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        cell.userInteractionEnabled = YES;
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    // return CGSizeMake(WIDTH*3/4, 30);
    return CGSizeMake(kScreenWidth*3/4,1);//在此如果将头视图的尺寸设置为（0，0）则左侧的tableView的分类cell不会根据collectionView的滑动而滑到相应的分类的cell。
    
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //根据类型以及标识获取注册过的头视图,
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    /*
     UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
     
     label.text = category_arr[indexPath.section];
     [headerView addSubview:label];
     label.textColor = [UIColor whiteColor];
     */
    
    return headerView;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //设置item尺寸
    if(indexPath.item == 0)
    {
        return CGSizeMake(self.view.frame.size.width - kScreenWidth/4, 40);
        
    }
    
    return CGSizeMake(self.view.frame.size.width/4.0, self.view.frame.size.width/4.0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //设置组距离上向左右的间距
    return UIEdgeInsetsMake(0,0,0,0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    //两个item的列间距
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    //如果一组中有多行item，设置行间距
    return 0;
}
// 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:253/255.0 green:109/255.0 blue:142/255.0 alpha:1.0];
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    selectedBackgroundView.alpha = 0.8;
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 2, kScreenHeight / 12)];
    lineLabel.backgroundColor = [UIColor redColor];
    [selectedBackgroundView addSubview:lineLabel];
    cell.selectedBackgroundView = selectedBackgroundView;//自定义cell选中时的背景
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zi组，%zi行",indexPath.section,indexPath.item);
    
    HomeFurnishingViewController * myview = [[HomeFurnishingViewController alloc]init];
    [self.navigationController pushViewController:myview animated:YES];
}

// tableview cell 选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.table) {
        _isRelate = NO;
        [self.TableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        //将CollectionView的滑动范围调整到tableView相对应的cell的内容
        
        [self.CollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        
    }
}
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.table selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

//将显示视图
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (_isRelate) {
        
        NSInteger topcellsection = [[[collectionView indexPathsForVisibleItems]firstObject]section];
        if (collectionView == self.Collection) {
            [self.TableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topcellsection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            
        }
    }
}
//将结束显示视图
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (_isRelate) {
        NSInteger itemsection = [[[collectionView indexPathsForVisibleItems]firstObject]section];
        if (collectionView == self.Collection) {
            [self selectRowAtIndexPath:indexPath.section];
            //当collectionView滑动时，tableView的cell自动选中相应的分类
            [self.TableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:itemsection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isRelate = YES;
}
@end











