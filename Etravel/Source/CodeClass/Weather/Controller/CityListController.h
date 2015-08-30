//
//  CityListController.h
//  Etravel
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^PassBlock)(NSDictionary *);
@interface CityListController : UITableViewController
@property (nonatomic, copy)PassBlock passCity;
@end
