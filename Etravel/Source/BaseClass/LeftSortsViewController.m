//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "otherViewController.h"
#import "WeatherViewController.h"
#import "MyPositionController.h"
#import "TravelLineController.h"
#import "TravelSightsController.h"
#import "TravelTicketController.h"
#import "AboutUsController.h"
#import "VideoController.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *Listarray;
@property (nonatomic, strong)UISwitch *Reachable;
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackimage"];
    [self.view addSubview:imageview];

    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    self.tableview.bounces = NO;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.Listarray = @[@"天气", @"我的位置", @"旅游线路查询", @"景点查询", @"门票信息", @"小短片", @"关于我们"];
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _Listarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = _Listarray[indexPath.row];
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPath.row == 0) {
        WeatherViewController *vc = [[WeatherViewController alloc]init];
        vc.navigationItem.title = @"天气";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 1) {
        MyPositionController *vc = [[MyPositionController alloc]init];
        vc.navigationItem.title = @"我的位置";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 2) {
        TravelLineController *vc = [[TravelLineController alloc]initWithStyle:(UITableViewStyleGrouped)];
        vc.navigationItem.title = @"旅游线路查询";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 3) {
        TravelSightsController *vc = [[TravelSightsController alloc]init];
        vc.navigationItem.title = @"景点查询";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        vc.city = @"北京";
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 4) {
        TravelTicketController *vc = [[TravelTicketController alloc]init];
        vc.navigationItem.title = @"门票信息";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 5){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((self.view.bounds.size.width - 15) / 2, 150);
        // 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 间距
        // 左右间距
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        // 内边距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        VideoController *vc = [[VideoController alloc]initWithCollectionViewLayout:layout];
        vc.navigationItem.title = @"小短片";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 6) {
        AboutUsController *vc = [[AboutUsController alloc]init];
        vc.navigationItem.title = @"关于我们";
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }
    else{
        otherViewController *vc = [[otherViewController alloc] init];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.size.height /4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 50)];
    self.Reachable = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view.frame) - 70, 12, 50, 20)];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL on = [defaults boolForKey:@"reachable"];
    if (on) {
        _Reachable.on = on;
        DLog(@"--%d", on);
    }else{
        [defaults setBool:_Reachable.on forKey:@"reachable"];
        [defaults synchronize];
    }
    [_Reachable addTarget:self action:@selector(reachable:) forControlEvents:(UIControlEventValueChanged)];
    [view addSubview:_Reachable];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, view.frame.size.width - 100, 40)];
    //message.backgroundColor = [UIColor grayColor];
    message.text = @"允许使用2G/3G网络观看视频";
    message.font = [UIFont systemFontOfSize:14.f];
    message.numberOfLines = 0;
    message.textColor = [UIColor whiteColor];
    [view addSubview:message];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)reachable:(UISwitch *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:_Reachable.on forKey:@"reachable"];
    DLog(@"%d", _Reachable.on);
    [defaults synchronize];
    
}

@end
