//
//  TravelTicketDetailController.m
//  Etravel
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelTicketDetailController.h"
#import "TravelTicketDetail.h"
#import "TravelTicketView.h"
@interface TravelTicketDetailController ()
@property (nonatomic, strong)TravelTicketView*ttv;
@end

@implementation TravelTicketDetailController

-(void)loadView
{
    self.ttv = [[TravelTicketView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _ttv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        // Do any additional setup after loading the view from its nib.
        NSString *urlStr = [NSString stringWithFormat:@"%@?id=%@", TicketDetailurl, _ID];
        [requestTool requestWithUrl:urlStr body:nil header:apikey backValue:^(NSData *value) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *d = dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"];
            TravelTicketDetail *model = [[TravelTicketDetail alloc]init];
            [model setValuesForKeysWithDictionary:d];
            DLog(@"%@", model.priceLists);
            self.ttv.detail = model;
            [GMDCircleLoader hideFromView:self.view animated:YES];
        }];

    } unreachableBlock:^(Reachability *reachability) {
        
    }];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
