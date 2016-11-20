//
//  LoginVideoModel.h
//  WXImitate
//
//  Created by WuQingMing on 16/11/19.
//  Copyright © 2016年 WuQingMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVideoModel : NSObject

//登录状态回馈值
@property (nonatomic, strong) NSNumber *rcLoginStatus;

//登录事件
@property (nonatomic, strong) RACCommand *loginCommand;

//账号密码
@property (nonatomic, copy) NSString *acount;
@property (nonatomic, copy) NSString *password;

@end
