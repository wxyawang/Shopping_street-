//
//  SettingViewController.m
//  DalingProjector
//
//  Created by WANGXINYU on 2016/11/28.
//  Copyright © 2016年 XingBoyunhai. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *SettingTableView;
@property (nonatomic,strong)SettingTableViewCell *TableViewcell;
@property (nonatomic,strong)NSString *str;
@property (nonatomic,assign)double  folderSize;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.view.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1.0];
    
    self.SettingTableView.tableFooterView = [UITableView new];
    
    [self.SettingTableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    
    
}
#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.TableViewcell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    self.TableViewcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.TableViewcell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        self.TableViewcell.LeftLabel.text = [NSString stringWithFormat:@"清除缓存"];
        
    }else if (indexPath.row == 1)
    {
        self.TableViewcell.LeftLabel.text = [NSString stringWithFormat:@"关于"];
        
    }
    
    return self.TableViewcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.SettingTableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
            
            NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.0fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.0fK, 删除缓存", size * 1024.0];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
                [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject];
                [self cleanCaches:NSTemporaryDirectory()];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            [alert addAction:action];
            [alert addAction:cancel];
            [self showDetailViewController:alert sender:nil];
            
//            [[SDImageCache sharedImageCache] clearDisk];
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"清除缓存信息"]];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            [self.SettingTableView reloadData];
//            [SVProgressHUD dismiss];
//            });
            
        }
            
        break;
        case 1:
        {
            NSString *str0 = @"当前软件版本";
            NSString *str1 = @"version 1.1";
            NSString *str = [NSString stringWithFormat:@"%@\n%@",str0,str1];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"提示"] message:str preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"确定"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

@end









