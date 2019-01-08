//
//  ShowViewController.h
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/23.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController

@property (strong, nonatomic)  UICollectionView *collectionView;

@property (nonatomic,copy) NSString* brand_area_idLabel;

@property (nonatomic,copy)NSString *redirect_url;

@property (nonatomic ,strong)NSMutableArray *DataArray;

@property (nonatomic,copy)NSString *string; //正向传参


@end
