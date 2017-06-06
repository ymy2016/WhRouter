//
//  ThirdViewController.m
//  WhRouter
//
//  Created by 伟华 on 17/3/22.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "ThirdViewController.h"
#import "NavButton.h"
#import "WhRouterManager.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self configUI];
    
}

- (void)configUI{
    
    // 导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [[NavButton alloc] initWithBtnStr:@"返回" horizontalAlignment:UIControlContentHorizontalAlignmentLeft btnActionBlock:^{
        
        [[WhRouterManager router] popViewControllerAnimated:YES];
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [[WhRouterManager router] push:@"FourViewController" animated:YES];

}

// 接收pop、dismiss回传值
- (void)wh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic{
 
    NSLog(@"%@",ParamsDic);
}

@end
