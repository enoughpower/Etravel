//
//  VideoController.m
//  movePlayer
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "VideoController.h"
#import "VideoListCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoModel.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#define listUrl @"http://pv.funshion.com/v5/video/retrieval?channel=1007"
#define playUrl @"http://pv.funshion.com/v5/video/play"


@interface VideoController ()
@property (nonatomic, strong)NSMutableArray *listArray;
@property (nonatomic, assign)NSInteger pageIndex;
@property (nonatomic, assign)BOOL ishead;
@property (nonatomic, assign)BOOL on;
@end

@implementation VideoController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    _pageIndex = 1;
    _ishead = YES;
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [self p_makeData:1];
        [self p_headerRefresh];
        [self p_footerRefresh];
    } unreachableBlock:^(Reachability *reachability) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.on = [defaults boolForKey:@"reachable"];
}

- (void)p_makeData:(NSInteger)page
{
     [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@&pg=%ld&order=mo&cate=0", listUrl, page];
    [requestTool requestWithUrl:urlStr body:nil header:nil backValue:^(NSData *value) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        if (_ishead == YES) {
            self.listArray = [NSMutableArray array];
        }
        //NSLog(@"%@", dict);
        for (NSDictionary *d in dict[@"videos"]) {
             VideoModel *model = [[VideoModel alloc]init];
            //NSLog(@"%@", d);
            [model setValuesForKeysWithDictionary:d];
            [self.listArray addObject:model];
        }
        [self.collectionView reloadData];
        _ishead = NO;
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }];
    _pageIndex ++;
}

- (void)p_headerRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _ishead = YES;
        [self p_makeData:1];
        [self.collectionView.header endRefreshing];
    }];
}
- (void)p_footerRefresh
{
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        DLog(@"%ld", _pageIndex);
        [self p_makeData:_pageIndex];
        [self.collectionView.footer endRefreshing];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playVideo:(NSString *)url
{
    MPMoviePlayerViewController *playerViewController =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:url]];
    playerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    playerViewController.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
    [playerViewController.view setTransform:transform];
    [self presentMoviePlayerViewControllerAnimated:playerViewController];
    
    

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    VideoModel *model = _listArray[indexPath.row];
    cell.title.text = model.name;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.still]];
    cell.time.text = model.duration;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        VideoModel *model = _listArray[indexPath.row];
        NSString *itemUrl = [NSString stringWithFormat:@"%@?id=%@", playUrl, model.ID];
        [requestTool requestWithUrl:itemUrl body:nil header:nil backValue:^(NSData *value) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            NSArray *UrlArr = dict[@"mp4"];
            NSDictionary *dt = [UrlArr lastObject];
            NSString *httpUrl = dt[@"http"];
            [requestTool requestWithUrl:httpUrl body:nil header:nil backValue:^(NSData *value) {
                NSDictionary *d = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
                NSString *playStr = d[@"playlist"][0][@"urls"][0];
                [self playVideo:playStr];
                [GMDCircleLoader hideFromView:self.view animated:YES];
                
            }];
        }];
    } unreachableBlock:^(Reachability *reachability) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络无连接或未允许3G网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    } WWANOpen:_on];
    
    
    
    
    
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

*/
/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
