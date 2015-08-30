//
//  MyPositionController.m
//  Etravel
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "MyPositionController.h"
#import "MapShare.h"
#import <AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>
@interface MyPositionController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)MAUserLocation *userLocation;
@property (nonatomic, strong)AMapSearchAPI *search;
@end

@implementation MyPositionController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSArray *arr = _mapView.annotations;
    [_mapView removeAnnotations:arr];
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil;
    _search.delegate = nil;
    

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [MapShare shareMap].mapView;
    _mapView.frame = self.view.bounds;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    _mapView.distanceFilter = 1000.f;
    _mapView.headingFilter = 90.f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜周边景点" style:(UIBarButtonItemStyleDone) target:self action:@selector(search:)];
    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    
    _mapView.compassOrigin= CGPointMake(_mapView.frame.size.width - 50, 70); //设置指南针位置
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    
    _mapView.scaleOrigin= CGPointMake(10, 70);  //设置比例尺位置

    
    
    
    

}

- (void)search:(UIBarButtonItem *)sender
{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:mapKey Delegate:self];
    
    //构造AMapPlaceSearchRequest对象，配置关键字搜索参数
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceAround;
    DLog(@"%f  %f", _userLocation.coordinate.latitude, _userLocation.coordinate.longitude);
    poiRequest.location = [AMapGeoPoint locationWithLatitude:_userLocation.coordinate.latitude longitude:_userLocation.coordinate.longitude];
    // types属性表示限定搜索POI的类别，默认为：餐饮服务、商务住宅、生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务、汽车销售、汽车维修、摩托车服务、餐饮服务、购物服务、生活服务、体育休闲服务、
    // 医疗保健服务、住宿服务、风景名胜、商务住宅、政府机构及社会团体、科教文化服务、
    // 交通设施服务、金融保险服务、公司企业、道路附属设施、地名地址信息、公共设施
    poiRequest.types = @[@"风景名胜"];
     poiRequest.requireExtension = YES;
    //发起POI搜索
    [_search AMapPlaceSearch: poiRequest];
}

- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    //通过AMapPlaceSearchResponse对象处理搜索结果
    DLog(@"%ld", response.pois.count);
    for (AMapPOI *p in response.pois) {
        NSString *strPoi = [NSString stringWithFormat:@"POI: %@  %@  %f  %f\n", p.name, p.address, p.location.latitude, p.location.longitude];
        DLog(@"%@", strPoi);
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        pointAnnotation.subtitle = p.address;
        pointAnnotation.title = p.name;
        [_mapView addAnnotation:pointAnnotation];
        
        
    }
    
    
}


- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    DLog(@"%@", error);
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        _userLocation = userLocation;
         [_mapView setZoomLevel:13 animated:YES];
    }
    DLog(@"坐标变啦  %@", userLocation);
   
  
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
