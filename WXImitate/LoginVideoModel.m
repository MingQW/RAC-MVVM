//
//  LoginVideoModel.m
//  WXImitate
//
//  Created by WuQingMing on 16/11/19.
//  Copyright © 2016年 WuQingMing. All rights reserved.
//

#import "LoginVideoModel.h"
#import "AFNHttpManager.h"

@interface LoginVideoModel()
@property(nonatomic, strong) RACSignal *loginValidSignal;
@end

@implementation LoginVideoModel

- (instancetype)init {
    if (self = [super init]) {
        [self loginCommandStatus];
    }
    
    return self;
}

- (void)loginCommandStatus {
    RACSignal *startedMessageSource = [self.loginCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
        return @1;
    }];
    
    RACSignal *completedMessageSource = [self.loginCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            return (event.eventType == RACEventTypeCompleted);
        }] map:^id(NSNumber *value) {
            if ([value isEqual: @2]) {
                return @2;
            }
            
            return @0;
        }];
    }];
    
    RACSignal *failedMessageSource = [[self.loginCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        return @3;
    }];
    
    RAC(self, rcLoginStatus) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:self.loginValidSignal signalBlock:^RACSignal *(id input) {
            return [self createLoginSignal];
        }];
    }
    
    return _loginCommand;
}

- (RACSignal *)createLoginSignal {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSDictionary *parameter = @{@"acount": @"", @"pwd": self.password};
        [AFNHttpManager getInfoWithUrl:@"" parameter:parameter complition:^(id json, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
            else {
                [subscriber sendNext:@"2"];
            }
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

- (RACSignal*)loginValidSignal {
    if (!_loginValidSignal) {
        _loginValidSignal = [RACObserve(self, password)map:^id(NSString* pwd) {
            return @(pwd.length > 0);
        }];
    }
    
    return _loginValidSignal;
}

@end
