//
//  AFNHttpManager.h
//  WXImitate
//
//  Created by WuQingMing on 16/11/19.
//  Copyright © 2016年 WuQingMing. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//请自行修改项目的基础路径
#define BASE_URL @"http://www.base.php"

@interface AFNHttpManager : AFHTTPSessionManager

/*
 * brief:Get方式获取网络数据
 * url：网络url
 * parameter：参数（无惨传nil）
 * block：error：为nil表示数据获取成功
 *        json：error为nil时获取到的json格式数据
 */
+ (void)getInfoWithUrl:(NSString *)subUrl
             parameter:(NSDictionary*)parameter
            complition:(void(^)(id json, NSError *error))block;

/*
 * brief:Post方式获取网络数据
 * 参数说明请参考 getInfoWithUrl
 */
+ (void)postWithUrl:(NSString *)subUrl
          parameter:(NSDictionary*)parameter
         complition:(void(^)(id json, NSError *error))block;

/*==================================参数连接在url后面========================================*/
//eg:http://www.testUrl.php?mod=test&tid=4824)

/*
 * brief:Get方式获取网络数据
 * urlAndparameter：网络url和参数(eg: getSomthing.php?mod=test&tid=4824)
 * block：error：为nil表示数据获取成功
 *        json：error为nil时获取到的json格式数据
 */
+ (void)getInfoWithParameterInUrl:(NSString *)subUrlAndparameter
            complition:(void(^)(id json, NSError *error))black;

/*
 * brief:Post方式获取网络数据
 * 参数说明请参考 getInfoWithParameterInUrl
 */
+ (void)postParameterInUrl:(NSString *)subUrlAndparameter
                       complition:(void(^)(id json, NSError *error))black;

@end
