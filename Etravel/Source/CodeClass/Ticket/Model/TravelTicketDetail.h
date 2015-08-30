//
//  TravelTicketDetail.h
//  Etravel
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelTicketDetail : NSObject
@property (nonatomic, copy)NSString *spotName;
@property (nonatomic, copy)NSString *spotDescription;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *province;
@property (nonatomic, copy)NSString *city;
@property (nonatomic, strong)NSMutableArray *priceLists;
@property (nonatomic, copy)NSString *imageUrl;
@end
