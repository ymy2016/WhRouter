//
//  UINavigationController+WhRouter.m
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "UINavigationController+WhRouter.h"

@implementation UINavigationController (WhRouter)

// push具体执行
- (void)wh_PushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
       isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush
                   completion:(void(^)())completion{
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    viewController.hidesBottomBarWhenPushed = isHiddenTabbarWhenPush;
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// pop回上一级具体执行
- (void)wh_popViewController:(BOOL)animated completion:(void (^)())completion{
      
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popViewControllerAnimated:animated];
    [CATransaction commit];
}

// pop到指定控制器具体执行
- (void)wh_popToViewController:(UIViewController *)viewController
                      animated:(BOOL)animated
                    completion:(void (^)())completion{

    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popToViewController:viewController animated:animated];
    [CATransaction commit];
}

// popToRoot具体执行
- (void)wh_popToRootViewController:(BOOL)animated
                        completion:(void(^)())completion{
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popToRootViewControllerAnimated:animated];
    [CATransaction commit];
}

@end
