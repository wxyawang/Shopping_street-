//
//  ShowCollectionViewCell.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/24.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "ShowCollectionViewCell.h"
#import "UIView+MJExtension.h"

#define isiPhone5or5sor5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhone6or6sor7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhone6plusor6splusor7plusor8plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXorXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXsorMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


@implementation ShowCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _pictureImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.mj_w, self.mj_w)];
        _pictureImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_pictureImage];
        
        if (isiPhone5or5sor5c) {
            NSLog(@"这是 iPhone5 或 5s 或 5c") ;
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w   / 10 - 10 , self.mj_w   + 5, self.mj_w - 20, self.mj_w   / 10)];
            _nameLabel.numberOfLines = 2;
            _nameLabel.font = [UIFont fontWithName:@"Arial"size:10];
            _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            _original_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 15, self.mj_w + 25, self.mj_w - 60, self.mj_w / 10)];
            _original_priceLabel.font = [UIFont fontWithName:@"Arial"size:8];
            _original_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            _vip_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 - 10, self.mj_w + 25, self.mj_w, self.mj_w / 10)];
            _vip_priceLabel.textColor = [UIColor redColor];
            _vip_priceLabel.font = [UIFont fontWithName:@"Arial"size:10];
            _vip_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _purchase_btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 80, self.mj_w + 25, self.mj_w - 60, self.mj_w / 10)];
             _purchase_btnLabel.textColor = [UIColor redColor];
            _purchase_btnLabel.font = [UIFont fontWithName:@"Arial"size:8];
            _purchase_btnLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        }else if (isiPhone6or6sor7){
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w   / 10 - 10 , self.mj_w   + 5, self.mj_w - 20, self.mj_w   / 10)];
            _nameLabel.numberOfLines = 2;
            _nameLabel.font = [UIFont fontWithName:@"Arial"size:12];
            _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
        
            _original_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 30, self.mj_w + 30, self.mj_w - 60, self.mj_w / 10)];
            _original_priceLabel.font = [UIFont fontWithName:@"Arial"size:10];
            _original_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _vip_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 - 10, self.mj_w + 30, self.mj_w, self.mj_w / 10)];
            _vip_priceLabel.textColor = [UIColor redColor];
            _vip_priceLabel.font = [UIFont fontWithName:@"Arial"size:12];
            _vip_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self.contentView addSubview:_vip_priceLabel];
            
            _purchase_btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 80, self.mj_w + 30, self.mj_w - 60, self.mj_w / 10)];
             _purchase_btnLabel.textColor = [UIColor redColor];
            _purchase_btnLabel.font = [UIFont fontWithName:@"Arial"size:10];
            _purchase_btnLabel.lineBreakMode = NSLineBreakByWordWrapping;
      
             NSLog(@"这是 iPhone6 或 6s");
        }else if (isiPhone6plusor6splusor7plusor8plus){
        
                _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w   / 10 - 10 , self.mj_w   + 5, self.mj_w - 20, self.mj_w   / 10)];
                _nameLabel.numberOfLines = 2;
                _nameLabel.font = [UIFont fontWithName:@"Arial"size:13];
                _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
                
                
                _original_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 30, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
                _original_priceLabel.font = [UIFont fontWithName:@"Arial"size:11];
                _original_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
                
                
                _vip_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 - 10, self.mj_w + 35, self.mj_w, self.mj_w / 10)];
                _vip_priceLabel.textColor = [UIColor redColor];
                _vip_priceLabel.font = [UIFont fontWithName:@"Arial"size:13];
                _vip_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [self.contentView addSubview:_vip_priceLabel];
                
                _purchase_btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 100, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
                _purchase_btnLabel.textColor = [UIColor redColor];
                _purchase_btnLabel.font = [UIFont fontWithName:@"Arial"size:11];
                _purchase_btnLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            NSLog(@"这是 iPhone6plus 或6splus或iPhone7plus 或8plus");
        }else if (isiPhoneXorXs){
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w   / 10 - 10 , self.mj_w   + 5, self.mj_w - 20, self.mj_w   / 10)];
            _nameLabel.numberOfLines = 2;
            _nameLabel.font = [UIFont fontWithName:@"Arial"size:13];
            _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _original_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 30, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
            _original_priceLabel.font = [UIFont fontWithName:@"Arial"size:12];
            _original_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _vip_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 - 10, self.mj_w + 35, self.mj_w, self.mj_w / 10)];
            _vip_priceLabel.textColor = [UIColor redColor];
            _vip_priceLabel.font = [UIFont fontWithName:@"Arial"size:13];
            _vip_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self.contentView addSubview:_vip_priceLabel];
            
            _purchase_btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 100, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
            _purchase_btnLabel.textColor = [UIColor redColor];
            _purchase_btnLabel.font = [UIFont fontWithName:@"Arial"size:12];
            _purchase_btnLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            NSLog(@"这是 iPhoneX 或Xs");
        }else if (isiPhoneXr){
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w   / 10 - 10 , self.mj_w   + 5, self.mj_w - 20, self.mj_w   / 10)];
            _nameLabel.numberOfLines = 2;
            _nameLabel.font = [UIFont fontWithName:@"Arial"size:14];
            _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _original_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 30, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
            _original_priceLabel.font = [UIFont fontWithName:@"Arial"size:12];
            _original_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _vip_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 - 10, self.mj_w + 35, self.mj_w, self.mj_w / 10)];
            _vip_priceLabel.textColor = [UIColor redColor];
            _vip_priceLabel.font = [UIFont fontWithName:@"Arial"size:14];
            _vip_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self.contentView addSubview:_vip_priceLabel];
            
            _purchase_btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 100, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
            _purchase_btnLabel.textColor = [UIColor redColor];
            _purchase_btnLabel.font = [UIFont fontWithName:@"Arial"size:12];
            _purchase_btnLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            NSLog(@"这是 iPhoneXr");
        }else if (isiPhoneXsorMax){
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w   / 10 - 15 , self.mj_w   + 5, self.mj_w - 20, self.mj_w   / 10)];
            _nameLabel.numberOfLines = 2;
            _nameLabel.font = [UIFont fontWithName:@"Arial"size:14];
            _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _original_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 30, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
            _original_priceLabel.font = [UIFont fontWithName:@"Arial"size:13];
            _original_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            _vip_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 - 15, self.mj_w + 35, self.mj_w, self.mj_w / 10)];
            _vip_priceLabel.textColor = [UIColor redColor];
            _vip_priceLabel.font = [UIFont fontWithName:@"Arial"size:14];
            _vip_priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self.contentView addSubview:_vip_priceLabel];
            
            _purchase_btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mj_w / 10 + 100, self.mj_w + 35, self.mj_w - 60, self.mj_w / 10)];
            _purchase_btnLabel.textColor = [UIColor redColor];
            _purchase_btnLabel.font = [UIFont fontWithName:@"Arial"size:13];
            _purchase_btnLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            NSLog(@"这是 iPhoneXs 或Max");
        }
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_original_priceLabel];
        [self.contentView addSubview:_vip_priceLabel];
        [self.contentView addSubview:_purchase_btnLabel];
    }
    
    return self;
}


@end
