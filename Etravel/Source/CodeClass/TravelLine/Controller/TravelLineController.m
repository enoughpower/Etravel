//
//  TravelLineController.m
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelLineController.h"
#import "TravelLineCell.h"
#import "TravelLineModel.h"
#import "TravelItemController.h"
@interface TravelLineController ()<UISearchBarDelegate>
@property (nonatomic, strong)TravelLineModel *lineModel;
@property (nonatomic, strong)UISearchBar *searchBar;
@end

@implementation TravelLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelLineCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"Line"];
    self.tableView.bounces = NO;
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入要去的城市";
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.navigationItem.titleView = _searchBar;
    UIImage *back = [UIImage imageNamed:@"1"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:back];

    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [self makeData:@"北京"];
    } unreachableBlock:^(Reachability *reachability) {
        
    }];
    

}

- (void)makeData:(NSString *)city
{
    [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@?location=%@&output=json", Lineurl, city];
    [requestTool requestWithUrl:urlStr body:nil header:apikey backValue:^(NSData *value) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        self.lineModel = [[TravelLineModel alloc]init];
        [_lineModel setValuesForKeysWithDictionary:dic[@"result"]];
        //DLog(@"%@", dic);
        //DLog(@"%@", _lineModel);
        [self.tableView reloadData];
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }];
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
    [self makeData:searchBar.text];
   
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
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

    return _lineModel.lineItineraries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Line" forIndexPath:indexPath];
    TravelLineItemModel *m = _lineModel.lineItineraries[indexPath.row];
    cell.nameLabel.text = m.name;
    cell.descriptionLabel.text = m.itemDescription;
    cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.4];
    //DLog(@"%@", m.name);
    //DLog(@"%@", m.itemDescription);
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return [self heightForText:_lineModel.lineDescription] + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self heightForText:_lineModel.abstract] + 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelLineItemModel *m = _lineModel.lineItineraries[indexPath.row];
    return [self heightForText:m.itemDescription] + 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    //view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, [self heightForText:_lineModel.lineDescription])];
    //label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.text = _lineModel.lineDescription;
    label.font = [UIFont systemFontOfSize:15.f];
    [view addSubview:label];

    return view;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]init];
    //view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, [self heightForText:_lineModel.abstract])];
    //label.backgroundColor = [UIColor whiteColor];
    label1.numberOfLines = 0;
    label1.textColor = [UIColor blackColor];
    label1.text = _lineModel.abstract;
    label1.font = [UIFont systemFontOfSize:15.f];
    [view1 addSubview:label1];
    
    return view1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TravelLineItemModel *m = _lineModel.lineItineraries[indexPath.row];
    TravelItemController *travel = [[TravelItemController alloc]initWithStyle:(UITableViewStyleGrouped)];
    travel.model = m;
    [self.navigationController pushViewController:travel animated:YES];
    
    
    
    
}


- (CGFloat)heightForText:(NSString *)string
{
    CGRect textframe = [string boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 10, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil];
    return textframe.size.height;
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
