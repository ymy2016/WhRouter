//
//  SecondViewController.m
//  WhRouter
//
//  Created by 伟华 on 17/3/16.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "SecondViewController.h"
#import "NavButton.h"
#import "WhRouterManager.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self configUI];
    
    NSLog(@"%zd",self.age);
}

- (void)configUI{
 
    // 导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [[NavButton alloc] initWithBtnStr:@"返回" horizontalAlignment:UIControlContentHorizontalAlignmentLeft btnActionBlock:^{
       
        [[WhRouterManager router] popViewControllerAnimated:YES];
    
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [[WhRouterManager router] push:@"ThirdViewController" animated:YES paramsDic:nil isHiddenTabbarWhenPush:NO completion:nil];
    
}

// 接收pop、dismiss回传值
- (void)wh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic{
 
    NSLog(@"%@",ParamsDic);
}

@end
