//
//  TravelNotesDetailController.m
//  Etravel
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelNotesDetailController.h"
@interface TravelNotesDetailController ()
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation TravelNotesDetailController


- (void)dealloc
{
    DLog(@"webView释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -45, self.view.frame.size.width, self.view.frame.size.height + 45)];
    [self.view addSubview:_webView];
    _webView.scrollView.bounces = NO;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_webView loadRequest:request];
    

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
