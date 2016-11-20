//
//  AFNHttpManager.m
//  WXImitate
//
//  Created by WuQingMing on 16/11/19.
//  Copyright © 2016年 WuQingMing. All rights reserved.
//

#import "AFNHttpManager.h"

@implementation AFNHttpManager

+ (instancetype)sharedManager {
    static AFNHttpManager *instanse = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instanse = [[AFNHttpManager alloc] init];
        instanse.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return instanse;
}

+ (void)getInfoWithUrl:(NSString *)subUrl
             parameter:(NSDictionary*)parameter
            complition:(void(^)(id json, NSError *error))block {
    NSString *pathUrl = [NSString stringWithFormat:@"%@/%@", BASE_URL, subUrl];
    [[[self class] sharedManager] GET:pathUrl parameters:parameter
                              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                  NSError *error;
                                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                                  block(dic, error);
                              }failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                  block(nil, error);
                              }];
}

+ (void)postWithUrl:(NSString *)subUrl
          parameter:(NSDictionary*)parameter
         complition:(void(^)(id json, NSError *error))block {
    NSString *pathUrl = [NSString stringWithFormat:@"%@/%@", BASE_URL, subUrl];
    [[[self class] sharedManager] POST:pathUrl parameters:parameter
                              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                  NSError *error;
                                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                                  block(dic, error);
                              }failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                  block(nil, error);
                              }];
}

+ (void)getInfoWithParameterInUrl:(NSString *)subUrlAndparameter
                       complition:(void(^)(id json, NSError *error))black {
    NSString *pathUrl = [NSString stringWithFormat:@"%@/%@", BASE_URL, subUrlAndparameter];
    [self getInfoWithUrl:pathUrl parameter:nil complition:^(id json, NSError *eror) {
        black(json, eror);
    }];
}

+ (void)postParameterInUrl:(NSString *)subUrlAndparameter
                complition:(void(^)(id json, NSError *error))black {
    NSString *pathUrl = [NSString stringWithFormat:@"%@/%@", BASE_URL, subUrlAndparameter];
    [self postWithUrl:pathUrl parameter:nil complition:^(id json, NSError *eror) {
        black(json, eror);
    }];
}

+ (void)checkNetWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
    }];
    return;
}

@end
