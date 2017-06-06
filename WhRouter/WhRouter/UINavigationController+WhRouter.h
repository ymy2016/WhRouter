//
//  UINavigationController+WhRouter.h
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (WhRouter)

// push具体执行
- (void)wh_PushViewController:(UIViewController *)viewController
                      animated:(BOOL)animated
        isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush
                    completion:(void(^)())completion;

// pop具体执行
- (void)wh_popViewController:(BOOL)animated
                  completion:(void (^)())completion;

// pop到指定控制器具体执行
- (void)wh_popToViewController:(UIViewController *)viewController
                      animated:(BOOL)animated
                    completion:(void (^)())completion;

// popToRoot具体执行
- (void)wh_popToRootViewController:(BOOL)animated
                        completion:(void(^)())completion;

@end
