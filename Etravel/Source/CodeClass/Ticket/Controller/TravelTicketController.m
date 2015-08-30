//
//  TravelTicketController.m
//  Etravel
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelTicketController.h"
#import <MJRefresh.h>
#import "TravelTicketModel.h"
#import "TravelTicketDetailController.h"
@interface TravelTicketController ()
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger pageIndex;
@property (nonatomic, assign)BOOL ishead;
@end

@implementation TravelTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ticket"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]];
    _pageIndex = 1;
    _ishead = YES;
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [self p_makeData:1];
        [self p_headerRefresh];
        [self p_footerRefresh];
    } unreachableBlock:^(Reachability *reachability) {

    }];



}

- (void)p_makeData:(NSInteger)page
{
    [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@?pageno=%ld&pagesize=20", Ticketurl, page];
    [requestTool requestWithUrl:urlStr body:nil header:apikey backValue:^(NSData *value) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        if (_ishead == YES) {
            self.dataArray = [NSMutableArray array];
        }
        //DLog(@"%@", dic);
        NSArray *list = dic[@"retData"][@"ticketList"];
        //DLog(@"%@", list);
        for (NSDictionary *d in list) {
            TravelTicketModel *m = [[TravelTicketModel alloc]init];
            [m setValuesForKeysWithDictionary:d];
            [self.dataArray addObject:m];
        }
        //DLog(@"%@", _dataArray);
        [self.tableView reloadData];
        _ishead = NO;
         [GMDCircleLoader hideFromView:self.view animated:YES];
    }];
    _pageIndex ++;
   
    
}

- (void)p_headerRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _ishead = YES;
        [self p_makeData:1];
        [self.tableView.header endRefreshing];
    }];
}
- (void)p_footerRefresh
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self p_makeData:_pageIndex];
        [self.tableView.footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticket" forIndexPath:indexPath];
    TravelTicketModel *m = _dataArray[indexPath.row];
    cell.textLabel.text = m.spotName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelTicketModel *m = _dataArray[indexPath.row];
    TravelTicketDetailController *ttdc = [[TravelTicketDetailController alloc]init];
    ttdc.ID = m.productId;
    ttdc.navigationItem.title = m.spotName;
    [self.navigationController pushViewController:ttdc animated:YES];
    
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
