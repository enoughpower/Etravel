//
//  MapShare.m
//  Etravel
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "MapShare.h"
#import <MAMapKit/MAMapKit.h>
static MapShare *handle = nil;
@implementation MapShare
+ (instancetype)shareMap
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[MapShare alloc]init];
    });
    return handle;
}




- (instancetype)init
{
    if (self = [super init]) {
        self.mapView = [[MAMapView alloc]init];
    }
    return self;
}


@end
