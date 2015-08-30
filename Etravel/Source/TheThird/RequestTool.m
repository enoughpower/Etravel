//
//  requestTool.m
//  Tool
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "requestTool.h"

@implementation requestTool

+ (void)requestWithUrl:(NSString *)urlStr body:(NSString *)bodyStr header:(NSString *)headerStr backValue:(backValue)bv
{
    // 1.url
    NSString *newStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:newStr];
    // 2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 3.
    if (bodyStr.length != 0) {
        // 方式
        request.HTTPMethod = @"POST";
        // 包体
        request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    if (headerStr != 0) {
        [request addValue: headerStr forHTTPHeaderField: @"apikey"];
    }
    // 异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            // 回调传值
            bv(data);
        }
    }];
    
}


@end
