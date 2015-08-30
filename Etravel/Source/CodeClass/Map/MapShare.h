//
//  MapShare.h
//  Etravel
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MAMapView;
@interface MapShare : NSObject
@property (nonatomic, strong)MAMapView *mapView;

+ (instancetype)shareMap;
@end
