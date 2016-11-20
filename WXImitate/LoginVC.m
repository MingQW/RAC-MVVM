//
//  LoginVC.m
//  WXImitate
//
//  Created by WuQingMing on 16/11/19.
//  Copyright © 2016年 WuQingMing. All rights reserved.
//

#import "LoginVC.h"
#import "LoginVideoModel.h"

@interface LoginVC ()
@property (strong, nonatomic) LoginVideoModel *viewModel;
@property (strong, nonatomic) IBOutlet UITextField *passwordLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.viewModel = [[LoginVideoModel alloc] init];
    [self bindWM];
}

- (void) bindWM {
    self.loginButton.rac_command = self.viewModel.loginCommand;
    RAC(self.viewModel, password) = self.passwordLabel.rac_textSignal;
    
    [RACObserve(self.viewModel, rcLoginStatus) subscribeNext:^(NSNumber *x) {
        switch ([x integerValue]) {
            case 1:
                NSLog(@"login begin!");
                break;
            case 2:
                NSLog(@"login success!");
                break;
            case 3:
                NSLog(@"login failure!");
                break;
                
            default:
                break;
        }
    }];
    
    [self.viewModel.loginCommand.enabled subscribeNext:^(id x) {
        self.loginButton.backgroundColor = [x isEqual: @1] ? [UIColor greenColor] : [UIColor lightGrayColor];
    }];
}

- (IBAction)handleTouchLoginTrouble:(id)sender {
}

- (IBAction)handleTouchMore:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
