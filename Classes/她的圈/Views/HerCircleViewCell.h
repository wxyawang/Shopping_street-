//
//  HerCircleViewCell.h
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/31.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HerCircleViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *child_ageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image_url;

@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *wap_url;

@property (weak, nonatomic) IBOutlet UILabel *text;


@end
