//
//  WeatherViewController.m
//  Etravel
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "WeatherViewController.h"
#import "MapShare.h"
#import "CityListController.h"
#import "WeatherModel.h"
#import <UIImageView+WebCache.h>
#import <MAMapKit/MAMapKit.h>
@interface WeatherViewController ()<MAMapViewDelegate>
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, assign)CGFloat latitude;
@property (nonatomic,assign)CGFloat longitude;
@property (nonatomic, strong)NSDictionary *WeatherDict;

// ------天气界面属性----


// 天气背景
@property (weak, nonatomic) IBOutlet UIImageView *weather;

// 城市
@property (weak, nonatomic) IBOutlet UILabel *city;
// 现在的天气图标
@property (weak, nonatomic) IBOutlet UIImageView *nowPic;
// 现在的温度
@property (weak, nonatomic) IBOutlet UILabel *nowTemperature;
// 现在的天气
@property (weak, nonatomic) IBOutlet UILabel *nowWeather;
// 现在的空气湿度
@property (weak, nonatomic) IBOutlet UILabel *nowSd;
// 现在的空气质量
@property (weak, nonatomic) IBOutlet UILabel *nowAqi;
// 现在的风速
@property (weak, nonatomic) IBOutlet UILabel *nowWind;
// 天气更新时间
@property (weak, nonatomic) IBOutlet UILabel *nowTemTime;
// 今天的天气图标
@property (weak, nonatomic) IBOutlet UIImageView *f1Pic;
// 今天的温度
@property (weak, nonatomic) IBOutlet UILabel *f1Temperature;
// 今天的天气
@property (weak, nonatomic) IBOutlet UILabel *f1Weather;
// 明天的天气图标
@property (weak, nonatomic) IBOutlet UIImageView *f2Pic;
// 明天的温度
@property (weak, nonatomic) IBOutlet UILabel *f2Temperature;
// 明天的天气
@property (weak, nonatomic) IBOutlet UILabel *f2Weather;
// 后天的天气图标
@property (weak, nonatomic) IBOutlet UIImageView *f3Pic;
// 后天的温度
@property (weak, nonatomic) IBOutlet UILabel *f3Temperature;
// 后天的天气
@property (weak, nonatomic) IBOutlet UILabel *f3Weather;

@end

@implementation WeatherViewController

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"longitude"];
    
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    if ((_latitude + _longitude) == 0) {
        self.mapView = [MapShare shareMap].mapView;
        _mapView.delegate = self;
        _mapView.distanceFilter = 10.f;
        _mapView.headingFilter = 90.f;
        _mapView.showsUserLocation = YES;
        //DLog(@"%f,%f", _latitude, _longitude);

    }else{

    }
        //DLog(@"%f,%f", _latitude, _longitude);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil;
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"切换位置" style:(UIBarButtonItemStyleDone) target:self action:@selector(cityAction:)];
       // 添加观察者，当坐标值改变时，请求数据
    [self addObserver:self forKeyPath:@"longitude" options:NSKeyValueObservingOptionNew context:nil];
    


}


// 切换位置按钮
- (void)cityAction:(UIBarButtonItem *)sender
{
    CityListController *cityList = [[CityListController alloc]initWithStyle:(UITableViewStylePlain)];
    cityList.passCity = ^(NSDictionary*city){
        self.navigationItem.title = city[@"city"];
        self.latitude = [city[@"lat"] doubleValue];
        self.longitude = [city[@"lon"] doubleValue];
        
    };
    [self.navigationController pushViewController:cityList animated:YES];
}

// 当坐标发生变化，调用此函数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [[JudgeNetwork shareNetwork] reachableBlock:^(Reachability *reachability) {
        [GMDCircleLoader setOnView:self.view withTitle:@"loading..." animated:YES];
        DLog(@"坐标变啦  %f, %f", _latitude, _longitude);
        // 拼接路径
        NSString *WeatherUrl = [NSString stringWithFormat:@"%@?lng=%f&lat=%f&from=5&needMoreDay=0&needIndex=0", Weatherurl, _longitude, _latitude];
        // 请求数据
        [requestTool requestWithUrl:WeatherUrl body:nil header:apikey backValue:^(NSData *value) {
            _WeatherDict = [NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            WeatherModel *model = [[WeatherModel alloc]init];
            [model setValuesForKeysWithDictionary:_WeatherDict[@"showapi_res_body"]];
            self.city.text = model.cityInfo[@"c3"];
            NSString *nowPic = model.now[@"weather_pic"];
            [self.nowPic sd_setImageWithURL:[NSURL URLWithString:nowPic] placeholderImage:[UIImage imageNamed:@"sun.png"]];
            self.nowAqi.text = [NSString stringWithFormat:@"%@", model.now[@"aqi"]];
            self.nowSd.text = [NSString stringWithFormat:@"%@", model.now[@"sd"]];
            self.nowTemTime.text = [NSString stringWithFormat:@"%@更新", model.now[@"temperature_time"]];
            self.nowTemperature.text = [NSString stringWithFormat:@"%@°", model.now[@"temperature"]];
            self.nowWeather.text = model.now[@"weather"];
            self.nowWind.text = [NSString stringWithFormat:@"%@%@", model.now[@"wind_direction"], model.now[@"wind_power"]];
            NSString *f1Pic = model.f1[@"day_weather_pic"];
            [self.f1Pic sd_setImageWithURL:[NSURL URLWithString:f1Pic] placeholderImage:[UIImage imageNamed:@"sun.png"]];
            self.f1Temperature.text = [NSString stringWithFormat:@"%@/%@°", model.f1[@"day_air_temperature"], model.f1[@"night_air_temperature"]];
            self.f1Weather.text = [NSString stringWithFormat:@"%@/%@", model.f1[@"day_weather"], model.f1[@"night_weather"]];
            NSString *f2Pic = model.f1[@"day_weather_pic"];
            [self.f2Pic sd_setImageWithURL:[NSURL URLWithString:f2Pic] placeholderImage:[UIImage imageNamed:@"sun.png"]];
            self.f2Temperature.text = [NSString stringWithFormat:@"%@/%@°", model.f2[@"day_air_temperature"], model.f2[@"night_air_temperature"]];
            self.f2Weather.text = [NSString stringWithFormat:@"%@/%@", model.f2[@"day_weather"], model.f2[@"night_weather"]];
            NSString *f3Pic = model.f3[@"day_weather_pic"];
            [self.f3Pic sd_setImageWithURL:[NSURL URLWithString:f3Pic] placeholderImage:[UIImage imageNamed:@"sun.png"]];
            self.f3Temperature.text = [NSString stringWithFormat:@"%@/%@°", model.f3[@"day_air_temperature"], model.f3[@"night_air_temperature"]];
            self.f3Weather.text = [NSString stringWithFormat:@"%@/%@", model.f3[@"day_weather"], model.f3[@"night_weather"]];
            NSString *weather = model.now[@"weather"];
            [self weather:weather];
            [GMDCircleLoader hideFromView:self.view animated:YES];
            
        }];
    } unreachableBlock:^(Reachability *reachability) {
        
    }];
   
}

- (void)weather:(NSString *)weather
{
    if ([weather isEqualToString:@"晴"]) {
        self.weather.image = [UIImage imageNamed:@"晴.jpg"];
    }else if ([weather isEqualToString:@"多云"]) {
        self.weather.image = [UIImage imageNamed:@"多云.jpg"];
    }else if ([weather isEqualToString:@"阴"]) {
        self.weather.image = [UIImage imageNamed:@"阴.jpeg"];
    }else if ([weather isEqualToString:@"小雨"]||[weather isEqualToString:@"中雨"]||[weather isEqualToString:@"大雨"]||[weather isEqualToString:@"阵雨"]) {
        self.weather.image = [UIImage imageNamed:@"雨.jpg"];
    }else if ([weather isEqualToString:@"小雪"]||[weather isEqualToString:@"中雪"]||[weather isEqualToString:@"大雪"]) {
        self.weather.image = [UIImage imageNamed:@"雪.jpeg"];
    }else if ([weather isEqualToString:@"雷阵雨"]) {
        self.weather.image = [UIImage imageNamed:@"雷阵雨.jpg"];
    }
}



#pragma mark -- mapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //DLog(@"%f, %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    self.latitude = userLocation.location.coordinate.latitude;
    self.longitude = userLocation.location.coordinate.longitude;
    //DLog(@"%f,%f", _latitude, _longitude);
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    DLog(@"%@", error);
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
