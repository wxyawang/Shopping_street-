//
//  ShopingStreetTableViewCell.h
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/22.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopingStreetTableViewCell : UITableViewCell
 

@property (weak, nonatomic) IBOutlet UIImageView *PictureImage;

@property (weak, nonatomic) IBOutlet UILabel *vip_priceLabel;


@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotion_customLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchase_btnLabel;
@property (weak, nonatomic) IBOutlet UILabel *original_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *item_count_msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *BaoyouLabel;

@end
















