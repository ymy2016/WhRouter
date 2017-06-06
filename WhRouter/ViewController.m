//
//  ViewController.m
//  WhRouter
//
//  Created by 伟华 on 17/3/16.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "WhRouterManager.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>]
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSDictionary *dic = @{
                          @"age":@123
                          };
//    [[WhRouterManager router] push:@"SecondViewController" animated:YES paramsDic:dic isHiddenTabbarWhenPush:YES completion:nil];
    
    [[WhRouterManager router] present:@"SecondViewController" animated:YES paramsDic:dic completion:nil];
    
}

// 接收pop、dismiss回传值
- (void)wh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic{

    NSLog(@"%@",ParamsDic);
}


@end
