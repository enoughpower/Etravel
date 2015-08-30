//
//  JudgeNetwork.m
//  Etravel
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "JudgeNetwork.h"
static JudgeNetwork *network = nil;


@implementation JudgeNetwork
+(instancetype)shareNetwork
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[JudgeNetwork alloc]init];
    });
    return network;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.ability = [Reachability reachabilityForInternetConnection];
        [_ability startNotifier];
    }
    return self;
}

- (void)reachableBlock:(reachableBL)reachable unreachableBlock:(unreachableBL)unreachable
{
    self.ability.reachableBlock = reachable;
    self.ability.unreachableBlock = unreachable;
    if (self.ability.isReachable) {
        reachable(self.ability);
    }else {
        unreachable(self.ability);
    }

}

- (void)reachableBlock:(reachableBL)reachable unreachableBlock:(unreachableBL)unreachable WWANOpen:(BOOL)open
{
    self.ability.reachableBlock = reachable;
    self.ability.unreachableBlock = unreachable;
    if (self.ability.currentReachabilityStatus == ReachableViaWiFi) {
        reachable(self.ability);
    }else if ((self.ability.currentReachabilityStatus == ReachableViaWWAN) && open){
        reachable(self.ability);
    }else {
        unreachable(self.ability);
    }
    
    
}





@end
