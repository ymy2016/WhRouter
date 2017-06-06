//
//  FourViewController.m
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "FourViewController.h"
#import "NavButton.h"
#import "WhRouterManager.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    [self configUI];

}

- (void)configUI{
    
    // 导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [[NavButton alloc] initWithBtnStr:@"返回" horizontalAlignment:UIControlContentHorizontalAlignmentLeft btnActionBlock:^{
        
            NSDictionary *dic = @{
                                      @"age":@123,
                                      @"name":@"谭伟华"
                                      };
        
        [[WhRouterManager router] popToViewController:@"SecondViewController" animated:YES paramsDic:dic];
        
//      [[WhRouterManager router] popViewControllerAnimated:YES paramsDic:dic completion:nil];
        
    }];
}

@end
