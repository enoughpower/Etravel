//
//  JudgeNetwork.h
//  Etravel
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability.h>
typedef void (^reachableBL)(Reachability * reachability);
typedef void (^unreachableBL)(Reachability * reachability);
@interface JudgeNetwork : NSObject

@property (nonatomic, strong)Reachability *ability;
+ (instancetype)shareNetwork;
- (void)reachableBlock:(reachableBL)reachable unreachableBlock:(unreachableBL)unreachable;
- (void)reachableBlock:(reachableBL)reachable unreachableBlock:(unreachableBL)unreachable WWANOpen:(BOOL)open;
@end
