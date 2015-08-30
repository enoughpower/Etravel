//
//  TravelSightsLocationController.m
//  Etravel
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelSightsLocationController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchAPI.h>
#import "MapShare.h"
@interface TravelSightsLocationController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)AMapSearchAPI *search;
@end

@implementation TravelSightsLocationController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [MapShare shareMap].mapView;
    _mapView.frame = self.view.bounds;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [self mapsarch:_locationDic];
    self.navigationItem.title = _name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"移除所有标注" style:(UIBarButtonItemStyleDone) target:self action:@selector(remove)];
    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    
    _mapView.compassOrigin= CGPointMake(_mapView.frame.size.width - 50, 70); //设置指南针位置
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    
    _mapView.scaleOrigin= CGPointMake(10, 70);  //设置比例尺位置
}
- (void)remove
{
    NSArray *arr = _mapView.annotations;
    [_mapView removeAnnotations:arr];
}

- (void)mapsarch:(NSDictionary *)location
{
    //初始化检索对象
    _search = [[AMapSearchAPI alloc]initWithSearchKey:mapKey Delegate:self];
    //构造AMapReGeocodeSearchRequest对象，location为必选项，radius为可选项
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    CGFloat lat = [location[@"lat"] doubleValue];
    CGFloat lng = [location[@"lng"] doubleValue];
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:lat longitude:lng];
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeoRequest];
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@%@", response.regeocode.addressComponent.citycode, response.regeocode.addressComponent.adcode];
        NSString *city = [NSString stringWithFormat:@"city:%@", response.regeocode.formattedAddress];
        NSLog(@"%@  %@", result, city);
        CGFloat lat = 0;
        CGFloat lng = 0;
        lat = [_locationDic[@"lat"] doubleValue];
        lng = [_locationDic[@"lng"] doubleValue];
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
        pointAnnotation.subtitle = response.regeocode.formattedAddress;
        pointAnnotation.title = _name;
        [_mapView addAnnotation:pointAnnotation];
        [_mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
        [_mapView setZoomLevel:13 animated:YES];
        NSLog(@"%f, %f", lat, lng);
        
        
        
        
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
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
