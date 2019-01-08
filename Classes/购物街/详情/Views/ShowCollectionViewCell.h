//
//  ShowCollectionViewCell.h
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/24.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *vip_priceLabel;
@property (strong, nonatomic) UIImageView *pictureImage;
@property (strong, nonatomic) UIImageView *SmallImage;
@property (weak,nonatomic) NSString *brand_area_idLabel;
 @property (strong,nonatomic) UILabel *purchase_btnLabel;
@property (strong, nonatomic) UILabel *original_priceLabel;
 
@end
