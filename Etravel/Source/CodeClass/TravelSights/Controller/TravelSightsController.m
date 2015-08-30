//
//  TravelSightsController.m
//  Etravel
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelSightsController.h"
#import "TravelSightsView.h"
#import "TravelSightsLocationController.h"
@interface TravelSightsController ()<UISearchBarDelegate>
@property (nonatomic, strong)TravelSightsView *tsv;
@property (nonatomic, strong)TravelSightsModel *model;
@property (nonatomic, strong)UISearchBar *searchBar;
@end

@implementation TravelSightsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"在地图上显示" style:(UIBarButtonItemStyleDone) target:self action:@selector(show)];
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [self p_makeData:self.city];
    } unreachableBlock:^(Reachability *reachability) {
        
    }];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入要去的景点";
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    [self.view addSubview:_searchBar];
    self.tsv.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]];
    

}

-(void)loadView
{
    self.tsv = [[TravelSightsView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _tsv;
}

- (void)p_makeData:(NSString *)key
{
    NSString *httpUrl = nil;
    NSString *URLkey = nil;
    [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
    if (_url != nil) {
        httpUrl = _url;
        
    }else if (key != nil) {
        NSString *city = [self getPingYin:key];
        httpUrl = [NSString stringWithFormat:@"%@?id=%@&output=json", Sighturl, city];
        URLkey = apikey;
    }
    
    [requestTool requestWithUrl:httpUrl body:nil header:URLkey backValue:^(NSData *value) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
        self.model = [[TravelSightsModel alloc]init];
        [_model setValuesForKeysWithDictionary:dict[@"result"]];
        if (_model.name == nil) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未找到结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else{
        self.tsv.model = _model;
        }
        [GMDCircleLoader hideFromView:self.view animated:YES];
    }];
}

- (void)show
{
    TravelSightsLocationController *tslc = [[TravelSightsLocationController alloc]init];
    tslc.locationDic = _model.location;
    tslc.name = _model.name;
    [self.navigationController pushViewController:tslc animated:YES];
}








// 汉字符转化为拼音字符
- (NSString *)getPingYin:(NSString *)HanZi
{
    NSString *hanziText = HanZi;
    if ([hanziText length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziText];
        // 带声调
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            //NSLog(@"pinyin: %@", ms);
        }
        // 不带声调
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            //NSLog(@"pinyin: %@", ms);
            return [ms stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
    }
    return nil;
    
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
    [self p_makeData:searchBar.text];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
