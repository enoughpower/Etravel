//
//  TravelNotesController.m
//  Etravel
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelNotesController.h"
#import "TravelNotesCell.h"
#import "AppDelegate.h"
#import "TravelNotesModel.h"
#import "TravelNotesDetailController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
@interface TravelNotesController ()<UISearchBarDelegate>
@property (nonatomic, strong)NSMutableArray *notes;
@property (nonatomic, assign)NSInteger pageIndex;
@property (nonatomic,strong)UISearchBar *searchBar;
@end

@implementation TravelNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelNotesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"notes"];
    self.title = @"主界面";
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"旅行游记";
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    self.notes = [NSMutableArray array];
    _pageIndex = 1;
    [self p_headerRefresh];
    [self p_footerRefresh];
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        DLog(@"有网");
        [self makeData:@"" page:1];
        
        
    } unreachableBlock:^(Reachability *reachability) {
        DLog(@"没网");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络无连接，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];

    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.frame = CGRectMake(0, 0, 100, 25);
    self.navigationItem.titleView = _searchBar;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入要搜索的关键字";
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;


    

}

- (void)makeData:(NSString *)key page:(NSInteger)page
{
    [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@?query=%@&page=%ld", Notesurl, key, page];
    [requestTool requestWithUrl:urlStr body:nil header:apikey backValue:^(NSData *value) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *d in dict[@"data"][@"books"]) {
            TravelNotesModel *model = [[TravelNotesModel alloc]init];
            [model setValuesForKeysWithDictionary:d];
            [self.notes addObject:model];
        }
        //DLog(@"%@", _notes);
        [self.tableView reloadData];
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }];
    _pageIndex ++;
    
}

- (void)p_headerRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.notes = [NSMutableArray array];
        self.searchBar.text = nil;
        [self makeData:@"" page:1];
        [self.tableView.header endRefreshing];
    }];
}

- (void)p_footerRefresh
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self makeData:self.searchBar.text page:_pageIndex];
        [self.tableView.footer endRefreshing];
    }];
}



- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- searchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    DLog(@"%@", searchBar.text);
    self.notes = [NSMutableArray array];
    _pageIndex = 1;
    [self makeData:self.searchBar.text page:_pageIndex];

    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notes" forIndexPath:indexPath];
    TravelNotesModel *m = _notes[indexPath.row];
    cell.titleLabel.text = m.title;
    [cell.userHeadImage sd_setImageWithURL:[NSURL URLWithString:m.userHeadImg] placeholderImage:[UIImage imageNamed:@"userPic.jpg"]];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:m.headImage] placeholderImage:[UIImage imageNamed:@"weather.jpg"]];
    cell.userName.text = m.userName;
    cell.notesLabel.text = m.text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelNotesModel *m = _notes[indexPath.row];
    TravelNotesDetailController *detail = [[TravelNotesDetailController alloc]init];
    detail.urlStr = m.bookUrl;
    detail.navigationItem.title = m.title;
    [self.navigationController pushViewController:detail animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelNotesModel *m = _notes[indexPath.row];
    CGRect textFrame = [m.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 10, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    CGFloat h = self.view.size.width /5 *4 + 30 + 10;
    return h + textFrame.size.height;

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
